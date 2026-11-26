module Lumen

open Fable.Core
open System

// Draw and sound are host imports. Every value that crosses the boundary is a
// number, so the module needs WasmGC and nothing else.

[<Import("clear", "draw")>]
let clear (r: float) (g: float) (b: float) : unit = nativeOnly

[<Import("cam", "draw")>]
let cam (x: float) (y: float) : unit = nativeOnly

[<Import("fillRect", "draw")>]
let fillRect (x: float) (y: float) (w: float) (h: float) (r: float) (g: float) (b: float) (a: float) : unit = nativeOnly

[<Import("fillCircle", "draw")>]
let fillCircle (x: float) (y: float) (rad: float) (r: float) (g: float) (b: float) (a: float) : unit = nativeOnly

[<Import("tone", "sfx")>]
let tone (kind: int) : unit = nativeOnly

type Ball =
    { mutable X: float
      mutable Y: float
      mutable Vx: float
      mutable Vy: float
      mutable R: float }

type Input =
    { mutable PointerX: float
      mutable PointerOn: int
      mutable Aimed: int
      mutable KeyLeft: int
      mutable KeyRight: int
      mutable LaunchReq: int
      mutable StartReq: int
      mutable ActionLatch: int }

type Trail =
    { mutable X0: float
      mutable Y0: float
      mutable X1: float
      mutable Y1: float
      mutable X2: float
      mutable Y2: float }

type Brick =
    { mutable X: float
      mutable Y: float
      mutable W: float
      mutable H: float
      mutable Hp: int
      mutable MaxHp: int
      mutable Alive: int
      mutable Next: Brick option }

type Spark =
    { mutable X: float
      mutable Y: float
      mutable Vx: float
      mutable Vy: float
      mutable Life: float
      mutable Max: float
      mutable Kind: int
      mutable Next: Spark option }

type World =
    { mutable Phase: int
      mutable Score: int
      mutable Best: int
      mutable Lives: int
      mutable Level: int
      mutable PaddleX: float
      mutable PaddleW: float
      mutable PaddleY: float
      mutable PaddleH: float
      mutable Acc: float
      mutable Time: float
      mutable Timer: float
      mutable Shake: float
      mutable Flash: float
      mutable Combo: int
      mutable ComboT: float
      mutable Speed: float
      mutable BricksLeft: int
      mutable Hit: int
      Ball: Ball
      Input: Input
      Trail: Trail
      mutable Bricks: Brick
      Sparks: Spark }

let rowCount (level: int) : int =
    let r = 2 + level
    if r > 6 then 6 else r

let brickHp (level: int) (row: int) : int =
    if level < 2 then 1
    elif level < 4 then if row = 0 then 2 else 1
    else 1 + (row % 3)

let shouldKeep (level: int) (row: int) (col: int) (rows: int) : bool =
    let kind = level % 5
    if kind = 2 then (row + col) % 2 = 0
    elif kind = 3 then col = 0 || col = 7 || row = 0 || row = rows - 1
    elif kind = 4 then
        let mid = 3.5
        let d = if float col > mid then float col - mid else mid - float col
        d + float row <= 3.2
    else true

let rec buildIndex (level: int) (index: int) : Brick =
    let cols = 8
    let rows = rowCount level
    let gap = 7.0
    let margin = 18.0
    let bw = (480.0 - margin * 2.0 - gap * float (cols - 1)) / float cols
    let bh = 22.0
    let top = 34.0
    if index >= cols * rows then
        { X = 0.0
          Y = 0.0
          W = 0.0
          H = 0.0
          Hp = 0
          MaxHp = 0
          Alive = 0
          Next = None }
    else
        let rest = buildIndex level (index + 1)
        let row = index / cols
        let col = index - row * cols
        if shouldKeep level row col rows then
            let hp = brickHp level row
            { X = margin + float col * (bw + gap)
              Y = top + float row * (bh + gap)
              W = bw
              H = bh
              Hp = hp
              MaxHp = hp
              Alive = 1
              Next = Some rest }
        else
            rest

let rec countAlive (b: Brick) : int =
    let here = if b.Alive = 1 then 1 else 0
    match b.Next with
    | Some n -> here + countAlive n
    | None -> here

let rec makeSparks (i: int) : Spark =
    if i <= 0 then
        { X = 0.0
          Y = 0.0
          Vx = 0.0
          Vy = 0.0
          Life = 0.0
          Max = 0.48
          Kind = 0
          Next = None }
    else
        let rest = makeSparks (i - 1)
        { X = 0.0
          Y = 0.0
          Vx = 0.0
          Vy = 0.0
          Life = 0.0
          Max = 0.48
          Kind = i
          Next = Some rest }

let rec updateSparks (s: Spark) (dt: float) : unit =
    if s.Life > 0.0 then
        s.Life <- s.Life - dt
        s.Vy <- s.Vy + 460.0 * dt
        s.X <- s.X + s.Vx * dt
        s.Y <- s.Y + s.Vy * dt
    match s.Next with
    | Some n -> updateSparks n dt
    | None -> ()

let rec spawn (s: Spark) (n: int) (x: float) (y: float) : unit =
    if n <= 0 then ()
    elif s.Life <= 0.0 then
        let ang = float s.Kind * 0.9 + float n * 1.17
        s.X <- x
        s.Y <- y
        s.Vx <- Math.Cos(ang) * (90.0 + float n * 28.0)
        s.Vy <- Math.Sin(ang) * (70.0 + float n * 22.0) - 80.0
        s.Life <- 0.42 + float (n % 3) * 0.06
        s.Max <- s.Life
        match s.Next with
        | Some nxt -> spawn nxt (n - 1) x y
        | None -> ()
    else
        match s.Next with
        | Some nxt -> spawn nxt n x y
        | None -> ()

let addScore (w: World) (basePts: int) : unit =
    if w.ComboT > 0.0 then w.Combo <- w.Combo + 1 else w.Combo <- 1
    if w.Combo > 8 then w.Combo <- 8
    w.ComboT <- 1.2
    w.Score <- w.Score + basePts * w.Combo
    if w.Score > w.Best then w.Best <- w.Score

let clampPaddle (w: World) : unit =
    if w.PaddleX < 12.0 then w.PaddleX <- 12.0
    let maxX = 468.0 - w.PaddleW
    if w.PaddleX > maxX then w.PaddleX <- maxX

let movePaddle (w: World) (dt: float) : unit =
    let input = w.Input
    if input.KeyLeft = 1 || input.KeyRight = 1 then
        input.PointerOn <- 0
        let speed = 520.0
        if input.KeyLeft = 1 then w.PaddleX <- w.PaddleX - speed * dt
        if input.KeyRight = 1 then w.PaddleX <- w.PaddleX + speed * dt
    elif input.PointerOn = 1 then
        w.PaddleX <- input.PointerX - w.PaddleW / 2.0
    clampPaddle w

let stick (w: World) : unit =
    let b = w.Ball
    b.X <- w.PaddleX + w.PaddleW / 2.0
    b.Y <- w.PaddleY - b.R - 3.0
    b.Vx <- 0.0
    b.Vy <- 0.0

let plantTrail (w: World) : unit =
    let t = w.Trail
    let x = w.Ball.X
    let y = w.Ball.Y
    t.X0 <- x
    t.Y0 <- y
    t.X1 <- x
    t.Y1 <- y
    t.X2 <- x
    t.Y2 <- y

let prepareLevel (w: World) (level: int) : unit =
    w.Level <- level
    let pw0 = 116.0 - float (level - 1) * 7.0
    let pw = if pw0 < 72.0 then 72.0 else pw0
    w.PaddleW <- pw
    w.PaddleX <- (480.0 - pw) / 2.0
    let sp = 305.0 + float (level - 1) * 16.0
    w.Speed <- if sp > 465.0 then 465.0 else sp
    w.Bricks <- buildIndex level 0
    w.BricksLeft <- countAlive w.Bricks
    w.Hit <- 0
    stick w
    plantTrail w

let beginGame (w: World) : unit =
    w.Score <- 0
    w.Lives <- 3
    w.Combo <- 0
    w.ComboT <- 0.0
    w.Flash <- 0.0
    w.Shake <- 0.0
    prepareLevel w 1

let launch (w: World) : unit =
    stick w
    w.Phase <- 2
    let speed = w.Speed
    let mutable vx = 72.0
    if w.Input.Aimed = 1 then
        let aim = (w.Input.PointerX - (w.PaddleX + w.PaddleW / 2.0)) / (w.PaddleW / 2.0)
        vx <- aim * speed * 0.46
    if vx > speed * 0.62 then vx <- speed * 0.62
    if vx < -speed * 0.62 then vx <- -speed * 0.62
    let vy2 = speed * speed - vx * vx
    w.Ball.Vx <- vx
    w.Ball.Vy <- -Math.Sqrt(vy2)
    plantTrail w
    tone 4

let consume (w: World) : unit =
    let input = w.Input
    if (w.Phase = 0 || w.Phase = 5) && input.StartReq = 1 then
        beginGame w
        launch w
    elif w.Phase = 1 && input.LaunchReq = 1 then
        launch w
    input.StartReq <- 0
    input.LaunchReq <- 0

let shiftTrail (w: World) : unit =
    let t = w.Trail
    t.X2 <- t.X1
    t.Y2 <- t.Y1
    t.X1 <- t.X0
    t.Y1 <- t.Y0
    t.X0 <- w.Ball.X
    t.Y0 <- w.Ball.Y

let rec collide (w: World) (b: Brick) : unit =
    if w.Hit = 0 && b.Alive = 1 then
        let ball = w.Ball
        let cx =
            if ball.X < b.X then b.X
            elif ball.X > b.X + b.W then b.X + b.W
            else ball.X
        let cy =
            if ball.Y < b.Y then b.Y
            elif ball.Y > b.Y + b.H then b.Y + b.H
            else ball.Y
        let dx = ball.X - cx
        let dy = ball.Y - cy
        if dx * dx + dy * dy <= ball.R * ball.R then
            w.Hit <- 1
            if dx = 0.0 && dy = 0.0 then
                ball.Vy <- -Math.Abs(ball.Vy)
                ball.Y <- b.Y - ball.R - 0.4
            elif Math.Abs(dx) > Math.Abs(dy) then
                if dx < 0.0 then
                    ball.Vx <- -Math.Abs(ball.Vx)
                    ball.X <- b.X - ball.R - 0.4
                else
                    ball.Vx <- Math.Abs(ball.Vx)
                    ball.X <- b.X + b.W + ball.R + 0.4
            elif dy < 0.0 then
                ball.Vy <- -Math.Abs(ball.Vy)
                ball.Y <- b.Y - ball.R - 0.4
            else
                ball.Vy <- Math.Abs(ball.Vy)
                ball.Y <- b.Y + b.H + ball.R + 0.4
            b.Hp <- b.Hp - 1
            let sp = Math.Sqrt(ball.Vx * ball.Vx + ball.Vy * ball.Vy)
            let nsp = if sp < 520.0 then sp * 1.012 else sp
            if sp > 1.0 then
                ball.Vx <- ball.Vx / sp * nsp
                ball.Vy <- ball.Vy / sp * nsp
            if b.Hp <= 0 then
                b.Alive <- 0
                w.BricksLeft <- w.BricksLeft - 1
                addScore w 100
                w.Shake <- w.Shake + 0.55
                w.Flash <- 0.16
                tone 2
                spawn w.Sparks 5 (b.X + b.W / 2.0) (b.Y + b.H / 2.0)
            else
                addScore w 40
                w.Shake <- w.Shake + 0.28
                tone 1
    if w.Hit = 0 then
        match b.Next with
        | Some n -> collide w n
        | None -> ()
    else
        ()

let physics (w: World) (dt: float) : unit =
    let ball = w.Ball
    w.Hit <- 0
    shiftTrail w
    ball.X <- ball.X + ball.Vx * dt
    ball.Y <- ball.Y + ball.Vy * dt
    if ball.X < ball.R then
        ball.X <- ball.R
        ball.Vx <- Math.Abs(ball.Vx)
        tone 3
    if ball.X > 480.0 - ball.R then
        ball.X <- 480.0 - ball.R
        ball.Vx <- -Math.Abs(ball.Vx)
        tone 3
    if ball.Y < ball.R + 10.0 then
        ball.Y <- ball.R + 10.0
        ball.Vy <- Math.Abs(ball.Vy)
        tone 3
    let top = w.PaddleY
    if ball.Vy > 0.0
       && ball.Y + ball.R >= top
       && ball.Y <= top + w.PaddleH
       && ball.X >= w.PaddleX - ball.R
       && ball.X <= w.PaddleX + w.PaddleW + ball.R then
        let center = w.PaddleX + w.PaddleW / 2.0
        let offset = (ball.X - center) / (w.PaddleW / 2.0)
        let speed = Math.Sqrt(ball.Vx * ball.Vx + ball.Vy * ball.Vy)
        let ang = offset * 1.05
        ball.Vx <- Math.Sin(ang) * speed
        ball.Vy <- -Math.Abs(Math.Cos(ang) * speed)
        if ball.Vy > -80.0 then ball.Vy <- -80.0
        ball.Y <- top - ball.R - 0.6
        w.Shake <- w.Shake + 0.22
        tone 0
    collide w w.Bricks
    if w.BricksLeft <= 0 && w.Phase = 2 then
        w.Score <- w.Score + 400 * w.Level
        if w.Score > w.Best then w.Best <- w.Score
        w.Phase <- 4
        w.Timer <- 0.85
        w.Flash <- 0.28
        tone 6
    if ball.Y - ball.R > 800.0 && w.Phase = 2 then
        w.Lives <- w.Lives - 1
        w.Combo <- 0
        w.ComboT <- 0.0
        w.Shake <- 1.1
        if w.Lives <= 0 then
            w.Phase <- 5
            tone 7
        else
            w.Phase <- 3
            w.Timer <- 0.62
            tone 5

let tickTimers (w: World) (dt: float) : unit =
    if w.Phase = 3 || w.Phase = 4 then
        w.Timer <- w.Timer - dt
        if w.Timer <= 0.0 then
            if w.Phase = 3 then
                w.Phase <- 1
                stick w
                plantTrail w
            else
                prepareLevel w (w.Level + 1)
                w.Phase <- 1

let step (w: World) (dt: float) : unit =
    w.Time <- w.Time + dt
    if w.Shake > 0.0 then w.Shake <- w.Shake - dt * 1.7
    if w.Shake < 0.0 then w.Shake <- 0.0
    if w.ComboT > 0.0 then w.ComboT <- w.ComboT - dt
    else w.Combo <- 0
    updateSparks w.Sparks dt
    tickTimers w dt
    consume w
    if w.Phase = 2 then
        movePaddle w dt
        physics w dt
    elif w.Phase = 0 || w.Phase = 1 then
        movePaddle w dt
        stick w

let rec substeps (w: World) (left: int) : unit =
    if left <= 0 then ()
    elif w.Acc < 0.0166667 then ()
    else
        step w 0.0166667
        w.Acc <- w.Acc - 0.0166667
        substeps w (left - 1)

let rec drawBricks (b: Brick) : unit =
    if b.Alive = 1 then
        let cr = if b.Hp >= 3 then 0.82 elif b.Hp = 2 then 0.90 else 0.24
        let cg = if b.Hp >= 3 then 0.35 elif b.Hp = 2 then 0.63 else 0.56
        let cb = if b.Hp >= 3 then 0.23 elif b.Hp = 2 then 0.24 else 0.45
        fillRect (b.X + 1.5) (b.Y + 3.0) b.W b.H 0.0 0.0 0.0 0.28
        fillRect b.X b.Y b.W b.H cr cg cb 1.0
        fillRect (b.X + 2.0) (b.Y + 2.0) (b.W - 4.0) 4.0 1.0 0.96 0.88 0.28
        if b.Hp < b.MaxHp then
            fillRect (b.X + 4.0) (b.Y + b.H * 0.45) (b.W - 8.0) 2.0 0.08 0.07 0.05 0.45
    match b.Next with
    | Some n -> drawBricks n
    | None -> ()

let rec drawSparks (s: Spark) : unit =
    if s.Life > 0.0 then
        let a = if s.Max > 0.0 then s.Life / s.Max else 0.0
        let rad = 2.2 + a * 2.4
        if s.Kind % 3 = 0 then fillCircle s.X s.Y rad 0.98 0.86 0.55 a
        elif s.Kind % 3 = 1 then fillCircle s.X s.Y rad 0.90 0.55 0.22 a
        else fillCircle s.X s.Y rad 0.55 0.82 0.68 a
    match s.Next with
    | Some n -> drawSparks n
    | None -> ()

let drawPaddle (w: World) : unit =
    let x = w.PaddleX
    let y = w.PaddleY
    let pw = w.PaddleW
    let ph = w.PaddleH
    let cap = ph / 2.0
    fillRect (x + 2.0) (y + 5.0) pw ph 0.0 0.0 0.0 0.25
    fillRect (x + cap) y (pw - ph) ph 0.86 0.62 0.29 1.0
    fillCircle (x + cap) (y + cap) cap 0.86 0.62 0.29 1.0
    fillCircle (x + pw - cap) (y + cap) cap 0.86 0.62 0.29 1.0
    fillRect (x + 12.0) (y + 3.0) (pw - 24.0) 3.2 1.0 0.93 0.78 0.7

let drawBall (w: World) : unit =
    let b = w.Ball
    let pulse = 0.5 + 0.5 * Math.Sin(w.Time * 3.4)
    let t = w.Trail
    if w.Phase = 2 then
        fillCircle t.X2 t.Y2 (b.R * 0.55) 0.90 0.64 0.24 0.18
        fillCircle t.X1 t.Y1 (b.R * 0.72) 0.95 0.74 0.32 0.28
        fillCircle t.X0 t.Y0 (b.R * 0.86) 1.0 0.84 0.48 0.4
    fillCircle b.X b.Y (b.R + 11.0 + pulse * 5.0) 0.90 0.62 0.22 (0.14 + pulse * 0.08)
    fillCircle b.X b.Y b.R 1.0 0.91 0.68 1.0
    fillCircle (b.X - 2.2) (b.Y - 2.6) 2.5 1.0 0.98 0.92 0.95

let render (w: World) : unit =
    let mag = w.Shake * 6.5
    cam (Math.Sin(w.Time * 53.0) * mag) (Math.Cos(w.Time * 41.0) * mag * 0.6)
    clear 0.078 0.090 0.059
    fillRect 10.0 10.0 460.0 780.0 0.098 0.114 0.075 1.0
    fillRect 10.0 10.0 460.0 2.0 0.90 0.75 0.40 0.35
    fillRect 18.0 786.0 444.0 2.0 0.82 0.35 0.23 0.45
    drawBricks w.Bricks
    drawSparks w.Sparks
    drawPaddle w
    drawBall w
    if w.Flash > 0.0 then
        fillRect 0.0 0.0 480.0 800.0 1.0 0.86 0.55 (w.Flash * 0.4)

let tick (w: World) (dt: float) : int =
    let dt2 = if dt > 0.05 then 0.05 elif dt < 0.0 then 0.0 else dt
    w.Acc <- w.Acc + dt2
    if w.Acc > 0.05 then w.Acc <- 0.05
    substeps w 4
    render w
    if w.Flash > 0.0 then w.Flash <- w.Flash - dt2
    if w.Flash < 0.0 then w.Flash <- 0.0
    w.Phase

let pointer (w: World) (x: float) (y: float) (mode: int) : unit =
    let input = w.Input
    let cx = if x < 0.0 then 0.0 elif x > 480.0 then 480.0 else x
    input.PointerX <- cx
    input.Aimed <- 1
    if mode = 0 || mode = 1 || mode = 2 then input.PointerOn <- 1
    if mode = 3 then input.PointerOn <- 0
    if mode = 1 || mode = 3 then
        input.LaunchReq <- 1
        input.StartReq <- 1
    if y > 1000000.0 then input.PointerX <- cx

let key (w: World) (code: int) (down: int) : unit =
    let input = w.Input
    if code = 1 then input.KeyLeft <- down
    elif code = 2 then input.KeyRight <- down
    elif code = 3 then
        if down = 1 && input.ActionLatch = 0 then
            input.ActionLatch <- 1
            input.LaunchReq <- 1
            input.StartReq <- 1
        if down = 0 then input.ActionLatch <- 0

let score (w: World) : int = w.Score
let best (w: World) : int = w.Best
let lives (w: World) : int = w.Lives
let level (w: World) : int = w.Level
let bricks (w: World) : int = w.BricksLeft
let combo (w: World) : int = if w.ComboT > 0.0 then w.Combo else 0
let phase (w: World) : int = w.Phase
let paddleX (w: World) : float = w.PaddleX
let ballX (w: World) : float = w.Ball.X
let ballY (w: World) : float = w.Ball.Y

let init (bestScore: int) : World =
    let ball = { X = 240.0; Y = 720.0; Vx = 0.0; Vy = 0.0; R = 8.0 }
    let input =
        { PointerX = 240.0
          PointerOn = 0
          Aimed = 0
          KeyLeft = 0
          KeyRight = 0
          LaunchReq = 0
          StartReq = 0
          ActionLatch = 0 }
    let trail = { X0 = 240.0; Y0 = 720.0; X1 = 240.0; Y1 = 720.0; X2 = 240.0; Y2 = 720.0 }
    let w =
        { Phase = 0
          Score = 0
          Best = bestScore
          Lives = 3
          Level = 1
          PaddleX = 182.0
          PaddleW = 116.0
          PaddleY = 742.0
          PaddleH = 14.0
          Acc = 0.0
          Time = 0.0
          Timer = 0.0
          Shake = 0.0
          Flash = 0.0
          Combo = 0
          ComboT = 0.0
          Speed = 305.0
          BricksLeft = 0
          Hit = 0
          Ball = ball
          Input = input
          Trail = trail
          Bricks = buildIndex 1 0
          Sparks = makeSparks 22 }
    w.BricksLeft <- countAlive w.Bricks
    stick w
    plantTrail w
    w
