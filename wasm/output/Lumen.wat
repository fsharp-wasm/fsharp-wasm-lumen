(module
  ;; ── Types ───────────────────────────────────────────
  (type $AnyFn (sub (struct)))
  (type $WasmStr (array (mut i32)))
  (type $ListBase (sub (struct)))
  (type $StringBuilder (sub (struct (field (mut (ref $WasmStr))) (field (mut i32)) (field (mut i32)))))
  (type $Lumen_Ball (sub (struct (field (mut f64)) (field (mut f64)) (field (mut f64)) (field (mut f64)) (field (mut f64)))))
  (type $Lumen_Input (sub (struct (field (mut f64)) (field (mut i32)) (field (mut i32)) (field (mut i32)) (field (mut i32)) (field (mut i32)) (field (mut i32)) (field (mut i32)))))
  (type $Lumen_Trail (sub (struct (field (mut f64)) (field (mut f64)) (field (mut f64)) (field (mut f64)) (field (mut f64)) (field (mut f64)))))
  (type $Lumen_Brick (sub (struct (field (mut f64)) (field (mut f64)) (field (mut f64)) (field (mut f64)) (field (mut i32)) (field (mut i32)) (field (mut i32)) (field (mut (ref null $Lumen_Brick))))))
  (type $Lumen_Spark (sub (struct (field (mut f64)) (field (mut f64)) (field (mut f64)) (field (mut f64)) (field (mut f64)) (field (mut f64)) (field (mut i32)) (field (mut (ref null $Lumen_Spark))))))
  (type $Lumen_World (sub (struct (field (mut i32)) (field (mut i32)) (field (mut i32)) (field (mut i32)) (field (mut i32)) (field (mut f64)) (field (mut f64)) (field (mut f64)) (field (mut f64)) (field (mut f64)) (field (mut f64)) (field (mut f64)) (field (mut f64)) (field (mut f64)) (field (mut i32)) (field (mut f64)) (field (mut f64)) (field (mut i32)) (field (mut i32)) (field (ref $Lumen_Ball)) (field (ref $Lumen_Input)) (field (ref $Lumen_Trail)) (field (mut (ref $Lumen_Brick))) (field (ref $Lumen_Spark)))))
  ;; ── Imports ────────────────────────────────────────
  (import "sfx" "tone" (func $sfx_tone (param i32)))
  (import "draw" "fillRect" (func $draw_fillRect (param f64) (param f64) (param f64) (param f64) (param f64) (param f64) (param f64) (param f64)))
  (import "draw" "fillCircle" (func $draw_fillCircle (param f64) (param f64) (param f64) (param f64) (param f64) (param f64) (param f64)))
  (import "draw" "cam" (func $draw_cam (param f64) (param f64)))
  (import "draw" "clear" (func $draw_clear (param f64) (param f64) (param f64)))
  (import "env" "consolePrint" (func $consolePrint (param (ref $WasmStr))))
  ;; ── Functions ──────────────────────────────────────
  (func $mathSin (param $x f64) (result f64)
    (local $twoPi f64)
    (local $pi f64)
    (local $k f64)
    (local $r f64)
    (local $t f64)
    f64.const 6.2831853071795862
    local.set $twoPi
    f64.const 3.1415926535897931
    local.set $pi
    local.get $x
    local.get $twoPi
    f64.div
    i32.trunc_f64_s
    f64.convert_i32_s
    local.set $k
    local.get $x
    local.get $twoPi
    local.get $k
    f64.mul
    f64.sub
    local.set $r
    local.get $r
    local.get $pi
    f64.gt
    if
      local.get $r
      local.get $twoPi
      f64.sub
      local.set $r
    end
    local.get $r
    local.get $pi
    f64.neg
    f64.lt
    if
      local.get $r
      local.get $twoPi
      f64.add
      local.set $r
    end
    local.get $r
    local.get $r
    f64.mul
    local.set $t
    local.get $r
    f64.const 1
    local.get $t
    f64.const -0.16666666666666666
    local.get $t
    f64.const 0.0083333333333333332
    local.get $t
    f64.const -0.00019841269841269841
    local.get $t
    f64.const 2.7557319223985888e-06
    local.get $t
    f64.const -2.505210838544172e-08
    local.get $t
    f64.const 1.6059043836821613e-10
    local.get $t
    f64.const -7.6471637318198164e-13
    f64.mul
    f64.add
    f64.mul
    f64.add
    f64.mul
    f64.add
    f64.mul
    f64.add
    f64.mul
    f64.add
    f64.mul
    f64.add
    f64.mul
    f64.add
    f64.mul
  )
  (func $mathCos (param $x f64) (result f64)
    (local $twoPi f64)
    (local $pi f64)
    (local $k f64)
    (local $r f64)
    (local $t f64)
    f64.const 6.2831853071795862
    local.set $twoPi
    f64.const 3.1415926535897931
    local.set $pi
    local.get $x
    local.get $twoPi
    f64.div
    i32.trunc_f64_s
    f64.convert_i32_s
    local.set $k
    local.get $x
    local.get $twoPi
    local.get $k
    f64.mul
    f64.sub
    local.set $r
    local.get $r
    local.get $pi
    f64.gt
    if
      local.get $r
      local.get $twoPi
      f64.sub
      local.set $r
    end
    local.get $r
    local.get $pi
    f64.neg
    f64.lt
    if
      local.get $r
      local.get $twoPi
      f64.add
      local.set $r
    end
    local.get $r
    local.get $r
    f64.mul
    local.set $t
    f64.const 1
    local.get $t
    f64.const -0.5
    local.get $t
    f64.const 0.041666666666666664
    local.get $t
    f64.const -0.0013888888888888889
    local.get $t
    f64.const 2.4801587301587302e-05
    local.get $t
    f64.const -2.7557319223985888e-07
    local.get $t
    f64.const 2.08767569878681e-09
    local.get $t
    f64.const -1.1470745597729725e-11
    f64.mul
    f64.add
    f64.mul
    f64.add
    f64.mul
    f64.add
    f64.mul
    f64.add
    f64.mul
    f64.add
    f64.mul
    f64.add
    f64.mul
    f64.add
  )
  (func $rowCount (param $level_1 i32) (result i32) ;; exported as "rowCount"
    (local $r i32)
    i32.const 2
    local.get $level_1
    i32.add
    local.set $r
    local.get $r
    i32.const 6
    i32.gt_s
    if (result i32)
      i32.const 6
    else
      local.get $r
    end
  )
  (func $brickHp (param $level_1 i32) (param $row i32) (result i32) ;; exported as "brickHp"
    local.get $level_1
    i32.const 2
    i32.lt_s
    if (result i32)
      i32.const 1
    else
      local.get $level_1
      i32.const 4
      i32.lt_s
      if (result i32)
        local.get $row
        i32.const 0
        i32.eq
        if (result i32)
          i32.const 2
        else
          i32.const 1
        end
      else
        i32.const 1
        local.get $row
        i32.const 3
        i32.rem_s
        i32.add
      end
    end
  )
  (func $shouldKeep (param $level_1 i32) (param $row i32) (param $col i32) (param $rows i32) (result i32) ;; exported as "shouldKeep"
    (local $kind i32)
    local.get $level_1
    i32.const 5
    i32.rem_s
    local.set $kind
    local.get $kind
    i32.const 2
    i32.eq
    if (result i32)
      local.get $row
      local.get $col
      i32.add
      i32.const 2
      i32.rem_s
      i32.const 0
      i32.eq
    else
      local.get $kind
      i32.const 3
      i32.eq
      if (result i32)
        local.get $col
        i32.const 0
        i32.eq
        if (result i32)
          i32.const 1
        else
          local.get $col
          i32.const 7
          i32.eq
        end
        if (result i32)
          i32.const 1
        else
          local.get $row
          i32.const 0
          i32.eq
        end
        if (result i32)
          i32.const 1
        else
          local.get $row
          local.get $rows
          i32.const 1
          i32.sub
          i32.eq
        end
      else
        local.get $kind
        i32.const 4
        i32.eq
        if (result i32)
          local.get $col
          f64.convert_i32_s
          f64.const 3.5
          f64.gt
          if (result f64)
            local.get $col
            f64.convert_i32_s
            f64.const 3.5
            f64.sub
          else
            f64.const 3.5
            local.get $col
            f64.convert_i32_s
            f64.sub
          end
          local.get $row
          f64.convert_i32_s
          f64.add
          f64.const 3.2000000000000002
          f64.le
        else
          i32.const 1
        end
      end
    end
  )
  (func $buildIndex (param $level_1 i32) (param $index i32) (result (ref $Lumen_Brick)) ;; exported as "buildIndex"
    (local $rows i32)
    (local $bw f64)
    (local $rest (ref $Lumen_Brick))
    (local $row i32)
    (local $col i32)
    (local $hp i32)
    local.get $level_1
    call $rowCount
    local.set $rows
    f64.const 444
    f64.const 7
    i32.const 7
    f64.convert_i32_s
    f64.mul
    f64.sub
    i32.const 8
    f64.convert_i32_s
    f64.div
    local.set $bw
    local.get $index
    i32.const 8
    local.get $rows
    i32.mul
    i32.ge_s
    if (result (ref $Lumen_Brick))
      f64.const 0
      f64.const 0
      f64.const 0
      f64.const 0
      i32.const 0
      i32.const 0
      i32.const 0
      ref.null $Lumen_Brick
      struct.new $Lumen_Brick
    else
      local.get $level_1
      local.get $index
      i32.const 1
      i32.add
      call $buildIndex
      local.set $rest
      local.get $index
      i32.const 8
      i32.div_s
      i32.const -1
      i32.xor
      i32.const -1
      i32.xor
      local.set $row
      local.get $index
      local.get $row
      i32.const 8
      i32.mul
      i32.sub
      local.set $col
      local.get $level_1
      local.get $row
      local.get $col
      local.get $rows
      call $shouldKeep
      if (result (ref $Lumen_Brick))
        local.get $level_1
        local.get $row
        call $brickHp
        local.set $hp
        f64.const 18
        local.get $col
        f64.convert_i32_s
        local.get $bw
        f64.const 7
        f64.add
        f64.mul
        f64.add
        f64.const 34
        local.get $row
        f64.convert_i32_s
        f64.const 29
        f64.mul
        f64.add
        local.get $bw
        f64.const 22
        local.get $hp
        local.get $hp
        i32.const 1
        local.get $rest
        struct.new $Lumen_Brick
      else
        local.get $rest
      end
    end
  )
  (func $countAlive (param $b (ref $Lumen_Brick)) (result i32) ;; exported as "countAlive"
    (local $here i32)
    (local $matchValue (ref null $Lumen_Brick))
    local.get $b
    struct.get $Lumen_Brick 6
    i32.const 1
    i32.eq
    if (result i32)
      i32.const 1
    else
      i32.const 0
    end
    local.set $here
    local.get $b
    struct.get $Lumen_Brick 7
    local.set $matchValue
    local.get $matchValue
    ref.is_null
    if (result i32)
      local.get $here
    else
      local.get $here
      local.get $matchValue
      ref.cast (ref $Lumen_Brick)
      call $countAlive
      i32.add
    end
  )
  (func $makeSparks (param $i i32) (result (ref $Lumen_Spark)) ;; exported as "makeSparks"
    local.get $i
    i32.const 0
    i32.le_s
    if (result (ref $Lumen_Spark))
      f64.const 0
      f64.const 0
      f64.const 0
      f64.const 0
      f64.const 0
      f64.const 0.47999999999999998
      i32.const 0
      ref.null $Lumen_Spark
      struct.new $Lumen_Spark
    else
      f64.const 0
      f64.const 0
      f64.const 0
      f64.const 0
      f64.const 0
      f64.const 0.47999999999999998
      local.get $i
      local.get $i
      i32.const 1
      i32.sub
      call $makeSparks
      struct.new $Lumen_Spark
    end
  )
  (func $updateSparks (param $s (ref $Lumen_Spark)) (param $dt f64) ;; exported as "updateSparks"
    (local $matchValue (ref null $Lumen_Spark))
    local.get $s
    struct.get $Lumen_Spark 4
    f64.const 0
    f64.gt
    if
      local.get $s
      local.get $s
      struct.get $Lumen_Spark 4
      local.get $dt
      f64.sub
      struct.set $Lumen_Spark 4
      local.get $s
      local.get $s
      struct.get $Lumen_Spark 3
      f64.const 460
      local.get $dt
      f64.mul
      f64.add
      struct.set $Lumen_Spark 3
      local.get $s
      local.get $s
      struct.get $Lumen_Spark 0
      local.get $s
      struct.get $Lumen_Spark 2
      local.get $dt
      f64.mul
      f64.add
      struct.set $Lumen_Spark 0
      local.get $s
      local.get $s
      struct.get $Lumen_Spark 1
      local.get $s
      struct.get $Lumen_Spark 3
      local.get $dt
      f64.mul
      f64.add
      struct.set $Lumen_Spark 1
    end
    local.get $s
    struct.get $Lumen_Spark 7
    local.set $matchValue
    local.get $matchValue
    ref.is_null
    if
    else
      local.get $matchValue
      ref.cast (ref $Lumen_Spark)
      local.get $dt
      call $updateSparks
    end
  )
  (func $spawn (param $s (ref $Lumen_Spark)) (param $n i32) (param $x f64) (param $y f64) ;; exported as "spawn"
    (local $ang f64)
    (local $matchValue (ref null $Lumen_Spark))
    (local $matchValue_1 (ref null $Lumen_Spark))
    local.get $n
    i32.const 0
    i32.le_s
    if
    else
      local.get $s
      struct.get $Lumen_Spark 4
      f64.const 0
      f64.le
      if
        local.get $s
        struct.get $Lumen_Spark 6
        f64.convert_i32_s
        f64.const 0.90000000000000002
        f64.mul
        local.get $n
        f64.convert_i32_s
        f64.const 1.1699999999999999
        f64.mul
        f64.add
        local.set $ang
        local.get $s
        local.get $x
        struct.set $Lumen_Spark 0
        local.get $s
        local.get $y
        struct.set $Lumen_Spark 1
        local.get $s
        local.get $ang
        call $mathCos
        f64.const 90
        local.get $n
        f64.convert_i32_s
        f64.const 28
        f64.mul
        f64.add
        f64.mul
        struct.set $Lumen_Spark 2
        local.get $s
        local.get $ang
        call $mathSin
        f64.const 70
        local.get $n
        f64.convert_i32_s
        f64.const 22
        f64.mul
        f64.add
        f64.mul
        f64.const 80
        f64.sub
        struct.set $Lumen_Spark 3
        local.get $s
        f64.const 0.41999999999999998
        local.get $n
        i32.const 3
        i32.rem_s
        f64.convert_i32_s
        f64.const 0.059999999999999998
        f64.mul
        f64.add
        struct.set $Lumen_Spark 4
        local.get $s
        local.get $s
        struct.get $Lumen_Spark 4
        struct.set $Lumen_Spark 5
        local.get $s
        struct.get $Lumen_Spark 7
        local.set $matchValue
        local.get $matchValue
        ref.is_null
        if
        else
          local.get $matchValue
          ref.cast (ref $Lumen_Spark)
          local.get $n
          i32.const 1
          i32.sub
          local.get $x
          local.get $y
          call $spawn
        end
      else
        local.get $s
        struct.get $Lumen_Spark 7
        local.set $matchValue_1
        local.get $matchValue_1
        ref.is_null
        if
        else
          local.get $matchValue_1
          ref.cast (ref $Lumen_Spark)
          local.get $n
          local.get $x
          local.get $y
          call $spawn
        end
      end
    end
  )
  (func $addScore (param $w (ref $Lumen_World)) (param $basePts i32) ;; exported as "addScore"
    local.get $w
    struct.get $Lumen_World 15
    f64.const 0
    f64.gt
    if
      local.get $w
      local.get $w
      struct.get $Lumen_World 14
      i32.const 1
      i32.add
      struct.set $Lumen_World 14
    else
      local.get $w
      i32.const 1
      struct.set $Lumen_World 14
    end
    local.get $w
    struct.get $Lumen_World 14
    i32.const 8
    i32.gt_s
    if
      local.get $w
      i32.const 8
      struct.set $Lumen_World 14
    end
    local.get $w
    f64.const 1.2
    struct.set $Lumen_World 15
    local.get $w
    local.get $w
    struct.get $Lumen_World 1
    local.get $basePts
    local.get $w
    struct.get $Lumen_World 14
    i32.mul
    i32.add
    struct.set $Lumen_World 1
    local.get $w
    struct.get $Lumen_World 1
    local.get $w
    struct.get $Lumen_World 2
    i32.gt_s
    if
      local.get $w
      local.get $w
      struct.get $Lumen_World 1
      struct.set $Lumen_World 2
    end
  )
  (func $clampPaddle (param $w (ref $Lumen_World)) ;; exported as "clampPaddle"
    (local $maxX f64)
    local.get $w
    struct.get $Lumen_World 5
    f64.const 12
    f64.lt
    if
      local.get $w
      f64.const 12
      struct.set $Lumen_World 5
    end
    f64.const 468
    local.get $w
    struct.get $Lumen_World 6
    f64.sub
    local.set $maxX
    local.get $w
    struct.get $Lumen_World 5
    local.get $maxX
    f64.gt
    if
      local.get $w
      local.get $maxX
      struct.set $Lumen_World 5
    end
  )
  (func $movePaddle (param $w (ref $Lumen_World)) (param $dt f64) ;; exported as "movePaddle"
    (local $input (ref $Lumen_Input))
    local.get $w
    struct.get $Lumen_World 20
    local.set $input
    local.get $input
    struct.get $Lumen_Input 3
    i32.const 1
    i32.eq
    if (result i32)
      i32.const 1
    else
      local.get $input
      struct.get $Lumen_Input 4
      i32.const 1
      i32.eq
    end
    if
      local.get $input
      i32.const 0
      struct.set $Lumen_Input 1
      local.get $input
      struct.get $Lumen_Input 3
      i32.const 1
      i32.eq
      if
        local.get $w
        local.get $w
        struct.get $Lumen_World 5
        f64.const 520
        local.get $dt
        f64.mul
        f64.sub
        struct.set $Lumen_World 5
      end
      local.get $input
      struct.get $Lumen_Input 4
      i32.const 1
      i32.eq
      if
        local.get $w
        local.get $w
        struct.get $Lumen_World 5
        f64.const 520
        local.get $dt
        f64.mul
        f64.add
        struct.set $Lumen_World 5
      end
    else
      local.get $input
      struct.get $Lumen_Input 1
      i32.const 1
      i32.eq
      if
        local.get $w
        local.get $input
        struct.get $Lumen_Input 0
        local.get $w
        struct.get $Lumen_World 6
        f64.const 2
        f64.div
        f64.sub
        struct.set $Lumen_World 5
      end
    end
    local.get $w
    call $clampPaddle
  )
  (func $stick (param $w (ref $Lumen_World)) ;; exported as "stick"
    (local $b (ref $Lumen_Ball))
    local.get $w
    struct.get $Lumen_World 19
    local.set $b
    local.get $b
    local.get $w
    struct.get $Lumen_World 5
    local.get $w
    struct.get $Lumen_World 6
    f64.const 2
    f64.div
    f64.add
    struct.set $Lumen_Ball 0
    local.get $b
    local.get $w
    struct.get $Lumen_World 7
    local.get $b
    struct.get $Lumen_Ball 4
    f64.sub
    f64.const 3
    f64.sub
    struct.set $Lumen_Ball 1
    local.get $b
    f64.const 0
    struct.set $Lumen_Ball 2
    local.get $b
    f64.const 0
    struct.set $Lumen_Ball 3
  )
  (func $plantTrail (param $w (ref $Lumen_World)) ;; exported as "plantTrail"
    (local $t (ref $Lumen_Trail))
    (local $x f64)
    (local $y f64)
    local.get $w
    struct.get $Lumen_World 21
    local.set $t
    local.get $w
    struct.get $Lumen_World 19
    struct.get $Lumen_Ball 0
    local.set $x
    local.get $w
    struct.get $Lumen_World 19
    struct.get $Lumen_Ball 1
    local.set $y
    local.get $t
    local.get $x
    struct.set $Lumen_Trail 0
    local.get $t
    local.get $y
    struct.set $Lumen_Trail 1
    local.get $t
    local.get $x
    struct.set $Lumen_Trail 2
    local.get $t
    local.get $y
    struct.set $Lumen_Trail 3
    local.get $t
    local.get $x
    struct.set $Lumen_Trail 4
    local.get $t
    local.get $y
    struct.set $Lumen_Trail 5
  )
  (func $prepareLevel (param $w (ref $Lumen_World)) (param $level_1 i32) ;; exported as "prepareLevel"
    (local $pw0 f64)
    (local $pw f64)
    (local $sp f64)
    local.get $w
    local.get $level_1
    struct.set $Lumen_World 4
    f64.const 116
    local.get $level_1
    i32.const 1
    i32.sub
    f64.convert_i32_s
    f64.const 7
    f64.mul
    f64.sub
    local.set $pw0
    local.get $pw0
    f64.const 72
    f64.lt
    if (result f64)
      f64.const 72
    else
      local.get $pw0
    end
    local.set $pw
    local.get $w
    local.get $pw
    struct.set $Lumen_World 6
    local.get $w
    f64.const 480
    local.get $pw
    f64.sub
    f64.const 2
    f64.div
    struct.set $Lumen_World 5
    f64.const 305
    local.get $level_1
    i32.const 1
    i32.sub
    f64.convert_i32_s
    f64.const 16
    f64.mul
    f64.add
    local.set $sp
    local.get $w
    local.get $sp
    f64.const 465
    f64.gt
    if (result f64)
      f64.const 465
    else
      local.get $sp
    end
    struct.set $Lumen_World 16
    local.get $w
    local.get $level_1
    i32.const 0
    call $buildIndex
    struct.set $Lumen_World 22
    local.get $w
    local.get $w
    struct.get $Lumen_World 22
    call $countAlive
    struct.set $Lumen_World 17
    local.get $w
    i32.const 0
    struct.set $Lumen_World 18
    local.get $w
    call $stick
    local.get $w
    call $plantTrail
  )
  (func $beginGame (param $w (ref $Lumen_World)) ;; exported as "beginGame"
    local.get $w
    i32.const 0
    struct.set $Lumen_World 1
    local.get $w
    i32.const 3
    struct.set $Lumen_World 3
    local.get $w
    i32.const 0
    struct.set $Lumen_World 14
    local.get $w
    f64.const 0
    struct.set $Lumen_World 15
    local.get $w
    f64.const 0
    struct.set $Lumen_World 13
    local.get $w
    f64.const 0
    struct.set $Lumen_World 12
    local.get $w
    i32.const 1
    call $prepareLevel
  )
  (func $launch (param $w (ref $Lumen_World)) ;; exported as "launch"
    (local $speed f64)
    (local $vx f64)
    (local $aim f64)
    (local $vy2 f64)
    local.get $w
    call $stick
    local.get $w
    i32.const 2
    struct.set $Lumen_World 0
    local.get $w
    struct.get $Lumen_World 16
    local.set $speed
    f64.const 72
    local.set $vx
    local.get $w
    struct.get $Lumen_World 20
    struct.get $Lumen_Input 2
    i32.const 1
    i32.eq
    if
      local.get $w
      struct.get $Lumen_World 20
      struct.get $Lumen_Input 0
      local.get $w
      struct.get $Lumen_World 5
      local.get $w
      struct.get $Lumen_World 6
      f64.const 2
      f64.div
      f64.add
      f64.sub
      local.get $w
      struct.get $Lumen_World 6
      f64.const 2
      f64.div
      f64.div
      local.set $aim
      local.get $aim
      local.get $speed
      f64.mul
      f64.const 0.46000000000000002
      f64.mul
      local.set $vx
    end
    local.get $vx
    local.get $speed
    f64.const 0.62
    f64.mul
    f64.gt
    if
      local.get $speed
      f64.const 0.62
      f64.mul
      local.set $vx
    end
    local.get $vx
    local.get $speed
    f64.neg
    f64.const 0.62
    f64.mul
    f64.lt
    if
      local.get $speed
      f64.neg
      f64.const 0.62
      f64.mul
      local.set $vx
    end
    local.get $speed
    local.get $speed
    f64.mul
    local.get $vx
    local.get $vx
    f64.mul
    f64.sub
    local.set $vy2
    local.get $w
    struct.get $Lumen_World 19
    local.get $vx
    struct.set $Lumen_Ball 2
    local.get $w
    struct.get $Lumen_World 19
    local.get $vy2
    f64.sqrt
    f64.neg
    struct.set $Lumen_Ball 3
    local.get $w
    call $plantTrail
    i32.const 4
    call $sfx_tone
  )
  (func $consume (param $w (ref $Lumen_World)) ;; exported as "consume"
    (local $input (ref $Lumen_Input))
    local.get $w
    struct.get $Lumen_World 20
    local.set $input
    local.get $w
    struct.get $Lumen_World 0
    i32.const 0
    i32.eq
    if (result i32)
      i32.const 1
    else
      local.get $w
      struct.get $Lumen_World 0
      i32.const 5
      i32.eq
    end
    if (result i32)
      local.get $input
      struct.get $Lumen_Input 6
      i32.const 1
      i32.eq
    else
      i32.const 0
    end
    if
      local.get $w
      call $beginGame
      local.get $w
      call $launch
    else
      local.get $w
      struct.get $Lumen_World 0
      i32.const 1
      i32.eq
      if (result i32)
        local.get $input
        struct.get $Lumen_Input 5
        i32.const 1
        i32.eq
      else
        i32.const 0
      end
      if
        local.get $w
        call $launch
      end
    end
    local.get $input
    i32.const 0
    struct.set $Lumen_Input 6
    local.get $input
    i32.const 0
    struct.set $Lumen_Input 5
  )
  (func $shiftTrail (param $w (ref $Lumen_World)) ;; exported as "shiftTrail"
    (local $t (ref $Lumen_Trail))
    local.get $w
    struct.get $Lumen_World 21
    local.set $t
    local.get $t
    local.get $t
    struct.get $Lumen_Trail 2
    struct.set $Lumen_Trail 4
    local.get $t
    local.get $t
    struct.get $Lumen_Trail 3
    struct.set $Lumen_Trail 5
    local.get $t
    local.get $t
    struct.get $Lumen_Trail 0
    struct.set $Lumen_Trail 2
    local.get $t
    local.get $t
    struct.get $Lumen_Trail 1
    struct.set $Lumen_Trail 3
    local.get $t
    local.get $w
    struct.get $Lumen_World 19
    struct.get $Lumen_Ball 0
    struct.set $Lumen_Trail 0
    local.get $t
    local.get $w
    struct.get $Lumen_World 19
    struct.get $Lumen_Ball 1
    struct.set $Lumen_Trail 1
  )
  (func $collide (param $w (ref $Lumen_World)) (param $b (ref $Lumen_Brick)) ;; exported as "collide"
    (local $ball (ref $Lumen_Ball))
    (local $cx f64)
    (local $cy f64)
    (local $dx f64)
    (local $dy f64)
    (local $sp f64)
    (local $nsp f64)
    (local $matchValue (ref null $Lumen_Brick))
    local.get $w
    struct.get $Lumen_World 18
    i32.const 0
    i32.eq
    if (result i32)
      local.get $b
      struct.get $Lumen_Brick 6
      i32.const 1
      i32.eq
    else
      i32.const 0
    end
    if
      local.get $w
      struct.get $Lumen_World 19
      local.set $ball
      local.get $ball
      struct.get $Lumen_Ball 0
      local.get $b
      struct.get $Lumen_Brick 0
      f64.lt
      if (result f64)
        local.get $b
        struct.get $Lumen_Brick 0
      else
        local.get $ball
        struct.get $Lumen_Ball 0
        local.get $b
        struct.get $Lumen_Brick 0
        local.get $b
        struct.get $Lumen_Brick 2
        f64.add
        f64.gt
        if (result f64)
          local.get $b
          struct.get $Lumen_Brick 0
          local.get $b
          struct.get $Lumen_Brick 2
          f64.add
        else
          local.get $ball
          struct.get $Lumen_Ball 0
        end
      end
      local.set $cx
      local.get $ball
      struct.get $Lumen_Ball 1
      local.get $b
      struct.get $Lumen_Brick 1
      f64.lt
      if (result f64)
        local.get $b
        struct.get $Lumen_Brick 1
      else
        local.get $ball
        struct.get $Lumen_Ball 1
        local.get $b
        struct.get $Lumen_Brick 1
        local.get $b
        struct.get $Lumen_Brick 3
        f64.add
        f64.gt
        if (result f64)
          local.get $b
          struct.get $Lumen_Brick 1
          local.get $b
          struct.get $Lumen_Brick 3
          f64.add
        else
          local.get $ball
          struct.get $Lumen_Ball 1
        end
      end
      local.set $cy
      local.get $ball
      struct.get $Lumen_Ball 0
      local.get $cx
      f64.sub
      local.set $dx
      local.get $ball
      struct.get $Lumen_Ball 1
      local.get $cy
      f64.sub
      local.set $dy
      local.get $dx
      local.get $dx
      f64.mul
      local.get $dy
      local.get $dy
      f64.mul
      f64.add
      local.get $ball
      struct.get $Lumen_Ball 4
      local.get $ball
      struct.get $Lumen_Ball 4
      f64.mul
      f64.le
      if
        local.get $w
        i32.const 1
        struct.set $Lumen_World 18
        local.get $dx
        f64.const 0
        f64.eq
        if (result i32)
          local.get $dy
          f64.const 0
          f64.eq
        else
          i32.const 0
        end
        if
          local.get $ball
          local.get $ball
          struct.get $Lumen_Ball 3
          f64.abs
          f64.neg
          struct.set $Lumen_Ball 3
          local.get $ball
          local.get $b
          struct.get $Lumen_Brick 1
          local.get $ball
          struct.get $Lumen_Ball 4
          f64.sub
          f64.const 0.40000000000000002
          f64.sub
          struct.set $Lumen_Ball 1
        else
          local.get $dx
          f64.abs
          local.get $dy
          f64.abs
          f64.gt
          if
            local.get $dx
            f64.const 0
            f64.lt
            if
              local.get $ball
              local.get $ball
              struct.get $Lumen_Ball 2
              f64.abs
              f64.neg
              struct.set $Lumen_Ball 2
              local.get $ball
              local.get $b
              struct.get $Lumen_Brick 0
              local.get $ball
              struct.get $Lumen_Ball 4
              f64.sub
              f64.const 0.40000000000000002
              f64.sub
              struct.set $Lumen_Ball 0
            else
              local.get $ball
              local.get $ball
              struct.get $Lumen_Ball 2
              f64.abs
              struct.set $Lumen_Ball 2
              local.get $ball
              local.get $b
              struct.get $Lumen_Brick 0
              local.get $b
              struct.get $Lumen_Brick 2
              f64.add
              local.get $ball
              struct.get $Lumen_Ball 4
              f64.add
              f64.const 0.40000000000000002
              f64.add
              struct.set $Lumen_Ball 0
            end
          else
            local.get $dy
            f64.const 0
            f64.lt
            if
              local.get $ball
              local.get $ball
              struct.get $Lumen_Ball 3
              f64.abs
              f64.neg
              struct.set $Lumen_Ball 3
              local.get $ball
              local.get $b
              struct.get $Lumen_Brick 1
              local.get $ball
              struct.get $Lumen_Ball 4
              f64.sub
              f64.const 0.40000000000000002
              f64.sub
              struct.set $Lumen_Ball 1
            else
              local.get $ball
              local.get $ball
              struct.get $Lumen_Ball 3
              f64.abs
              struct.set $Lumen_Ball 3
              local.get $ball
              local.get $b
              struct.get $Lumen_Brick 1
              local.get $b
              struct.get $Lumen_Brick 3
              f64.add
              local.get $ball
              struct.get $Lumen_Ball 4
              f64.add
              f64.const 0.40000000000000002
              f64.add
              struct.set $Lumen_Ball 1
            end
          end
        end
        local.get $b
        local.get $b
        struct.get $Lumen_Brick 4
        i32.const 1
        i32.sub
        struct.set $Lumen_Brick 4
        local.get $ball
        struct.get $Lumen_Ball 2
        local.get $ball
        struct.get $Lumen_Ball 2
        f64.mul
        local.get $ball
        struct.get $Lumen_Ball 3
        local.get $ball
        struct.get $Lumen_Ball 3
        f64.mul
        f64.add
        f64.sqrt
        local.set $sp
        local.get $sp
        f64.const 520
        f64.lt
        if (result f64)
          local.get $sp
          f64.const 1.012
          f64.mul
        else
          local.get $sp
        end
        local.set $nsp
        local.get $sp
        f64.const 1
        f64.gt
        if
          local.get $ball
          local.get $ball
          struct.get $Lumen_Ball 2
          local.get $sp
          f64.div
          local.get $nsp
          f64.mul
          struct.set $Lumen_Ball 2
          local.get $ball
          local.get $ball
          struct.get $Lumen_Ball 3
          local.get $sp
          f64.div
          local.get $nsp
          f64.mul
          struct.set $Lumen_Ball 3
        end
        local.get $b
        struct.get $Lumen_Brick 4
        i32.const 0
        i32.le_s
        if
          local.get $b
          i32.const 0
          struct.set $Lumen_Brick 6
          local.get $w
          local.get $w
          struct.get $Lumen_World 17
          i32.const 1
          i32.sub
          struct.set $Lumen_World 17
          local.get $w
          i32.const 100
          call $addScore
          local.get $w
          local.get $w
          struct.get $Lumen_World 12
          f64.const 0.55000000000000004
          f64.add
          struct.set $Lumen_World 12
          local.get $w
          f64.const 0.16
          struct.set $Lumen_World 13
          i32.const 2
          call $sfx_tone
          local.get $w
          struct.get $Lumen_World 23
          i32.const 5
          local.get $b
          struct.get $Lumen_Brick 0
          local.get $b
          struct.get $Lumen_Brick 2
          f64.const 2
          f64.div
          f64.add
          local.get $b
          struct.get $Lumen_Brick 1
          local.get $b
          struct.get $Lumen_Brick 3
          f64.const 2
          f64.div
          f64.add
          call $spawn
        else
          local.get $w
          i32.const 40
          call $addScore
          local.get $w
          local.get $w
          struct.get $Lumen_World 12
          f64.const 0.28000000000000003
          f64.add
          struct.set $Lumen_World 12
          i32.const 1
          call $sfx_tone
        end
      end
    end
    local.get $w
    struct.get $Lumen_World 18
    i32.const 0
    i32.eq
    if
      local.get $b
      struct.get $Lumen_Brick 7
      local.set $matchValue
      local.get $matchValue
      ref.is_null
      if
      else
        local.get $w
        local.get $matchValue
        ref.cast (ref $Lumen_Brick)
        call $collide
      end
    end
  )
  (func $physics (param $w (ref $Lumen_World)) (param $dt f64) ;; exported as "physics"
    (local $ball (ref $Lumen_Ball))
    (local $top f64)
    (local $center f64)
    (local $offset f64)
    (local $speed f64)
    (local $ang f64)
    local.get $w
    struct.get $Lumen_World 19
    local.set $ball
    local.get $w
    i32.const 0
    struct.set $Lumen_World 18
    local.get $w
    call $shiftTrail
    local.get $ball
    local.get $ball
    struct.get $Lumen_Ball 0
    local.get $ball
    struct.get $Lumen_Ball 2
    local.get $dt
    f64.mul
    f64.add
    struct.set $Lumen_Ball 0
    local.get $ball
    local.get $ball
    struct.get $Lumen_Ball 1
    local.get $ball
    struct.get $Lumen_Ball 3
    local.get $dt
    f64.mul
    f64.add
    struct.set $Lumen_Ball 1
    local.get $ball
    struct.get $Lumen_Ball 0
    local.get $ball
    struct.get $Lumen_Ball 4
    f64.lt
    if
      local.get $ball
      local.get $ball
      struct.get $Lumen_Ball 4
      struct.set $Lumen_Ball 0
      local.get $ball
      local.get $ball
      struct.get $Lumen_Ball 2
      f64.abs
      struct.set $Lumen_Ball 2
      i32.const 3
      call $sfx_tone
    end
    local.get $ball
    struct.get $Lumen_Ball 0
    f64.const 480
    local.get $ball
    struct.get $Lumen_Ball 4
    f64.sub
    f64.gt
    if
      local.get $ball
      f64.const 480
      local.get $ball
      struct.get $Lumen_Ball 4
      f64.sub
      struct.set $Lumen_Ball 0
      local.get $ball
      local.get $ball
      struct.get $Lumen_Ball 2
      f64.abs
      f64.neg
      struct.set $Lumen_Ball 2
      i32.const 3
      call $sfx_tone
    end
    local.get $ball
    struct.get $Lumen_Ball 1
    local.get $ball
    struct.get $Lumen_Ball 4
    f64.const 10
    f64.add
    f64.lt
    if
      local.get $ball
      local.get $ball
      struct.get $Lumen_Ball 4
      f64.const 10
      f64.add
      struct.set $Lumen_Ball 1
      local.get $ball
      local.get $ball
      struct.get $Lumen_Ball 3
      f64.abs
      struct.set $Lumen_Ball 3
      i32.const 3
      call $sfx_tone
    end
    local.get $w
    struct.get $Lumen_World 7
    local.set $top
    local.get $ball
    struct.get $Lumen_Ball 3
    f64.const 0
    f64.gt
    if (result i32)
      local.get $ball
      struct.get $Lumen_Ball 1
      local.get $ball
      struct.get $Lumen_Ball 4
      f64.add
      local.get $top
      f64.ge
    else
      i32.const 0
    end
    if (result i32)
      local.get $ball
      struct.get $Lumen_Ball 1
      local.get $top
      local.get $w
      struct.get $Lumen_World 8
      f64.add
      f64.le
    else
      i32.const 0
    end
    if (result i32)
      local.get $ball
      struct.get $Lumen_Ball 0
      local.get $w
      struct.get $Lumen_World 5
      local.get $ball
      struct.get $Lumen_Ball 4
      f64.sub
      f64.ge
    else
      i32.const 0
    end
    if (result i32)
      local.get $ball
      struct.get $Lumen_Ball 0
      local.get $w
      struct.get $Lumen_World 5
      local.get $w
      struct.get $Lumen_World 6
      f64.add
      local.get $ball
      struct.get $Lumen_Ball 4
      f64.add
      f64.le
    else
      i32.const 0
    end
    if
      local.get $w
      struct.get $Lumen_World 5
      local.get $w
      struct.get $Lumen_World 6
      f64.const 2
      f64.div
      f64.add
      local.set $center
      local.get $ball
      struct.get $Lumen_Ball 0
      local.get $center
      f64.sub
      local.get $w
      struct.get $Lumen_World 6
      f64.const 2
      f64.div
      f64.div
      local.set $offset
      local.get $ball
      struct.get $Lumen_Ball 2
      local.get $ball
      struct.get $Lumen_Ball 2
      f64.mul
      local.get $ball
      struct.get $Lumen_Ball 3
      local.get $ball
      struct.get $Lumen_Ball 3
      f64.mul
      f64.add
      f64.sqrt
      local.set $speed
      local.get $offset
      f64.const 1.05
      f64.mul
      local.set $ang
      local.get $ball
      local.get $ang
      call $mathSin
      local.get $speed
      f64.mul
      struct.set $Lumen_Ball 2
      local.get $ball
      local.get $ang
      call $mathCos
      local.get $speed
      f64.mul
      f64.abs
      f64.neg
      struct.set $Lumen_Ball 3
      local.get $ball
      struct.get $Lumen_Ball 3
      f64.const -80
      f64.gt
      if
        local.get $ball
        f64.const -80
        struct.set $Lumen_Ball 3
      end
      local.get $ball
      local.get $top
      local.get $ball
      struct.get $Lumen_Ball 4
      f64.sub
      f64.const 0.59999999999999998
      f64.sub
      struct.set $Lumen_Ball 1
      local.get $w
      local.get $w
      struct.get $Lumen_World 12
      f64.const 0.22
      f64.add
      struct.set $Lumen_World 12
      i32.const 0
      call $sfx_tone
    end
    local.get $w
    local.get $w
    struct.get $Lumen_World 22
    call $collide
    local.get $w
    struct.get $Lumen_World 17
    i32.const 0
    i32.le_s
    if (result i32)
      local.get $w
      struct.get $Lumen_World 0
      i32.const 2
      i32.eq
    else
      i32.const 0
    end
    if
      local.get $w
      local.get $w
      struct.get $Lumen_World 1
      i32.const 400
      local.get $w
      struct.get $Lumen_World 4
      i32.mul
      i32.add
      struct.set $Lumen_World 1
      local.get $w
      struct.get $Lumen_World 1
      local.get $w
      struct.get $Lumen_World 2
      i32.gt_s
      if
        local.get $w
        local.get $w
        struct.get $Lumen_World 1
        struct.set $Lumen_World 2
      end
      local.get $w
      i32.const 4
      struct.set $Lumen_World 0
      local.get $w
      f64.const 0.84999999999999998
      struct.set $Lumen_World 11
      local.get $w
      f64.const 0.28000000000000003
      struct.set $Lumen_World 13
      i32.const 6
      call $sfx_tone
    end
    local.get $ball
    struct.get $Lumen_Ball 1
    local.get $ball
    struct.get $Lumen_Ball 4
    f64.sub
    f64.const 800
    f64.gt
    if (result i32)
      local.get $w
      struct.get $Lumen_World 0
      i32.const 2
      i32.eq
    else
      i32.const 0
    end
    if
      local.get $w
      local.get $w
      struct.get $Lumen_World 3
      i32.const 1
      i32.sub
      struct.set $Lumen_World 3
      local.get $w
      i32.const 0
      struct.set $Lumen_World 14
      local.get $w
      f64.const 0
      struct.set $Lumen_World 15
      local.get $w
      f64.const 1.1000000000000001
      struct.set $Lumen_World 12
      local.get $w
      struct.get $Lumen_World 3
      i32.const 0
      i32.le_s
      if
        local.get $w
        i32.const 5
        struct.set $Lumen_World 0
        i32.const 7
        call $sfx_tone
      else
        local.get $w
        i32.const 3
        struct.set $Lumen_World 0
        local.get $w
        f64.const 0.62
        struct.set $Lumen_World 11
        i32.const 5
        call $sfx_tone
      end
    end
  )
  (func $tickTimers (param $w (ref $Lumen_World)) (param $dt f64) ;; exported as "tickTimers"
    local.get $w
    struct.get $Lumen_World 0
    i32.const 3
    i32.eq
    if (result i32)
      i32.const 1
    else
      local.get $w
      struct.get $Lumen_World 0
      i32.const 4
      i32.eq
    end
    if
      local.get $w
      local.get $w
      struct.get $Lumen_World 11
      local.get $dt
      f64.sub
      struct.set $Lumen_World 11
      local.get $w
      struct.get $Lumen_World 11
      f64.const 0
      f64.le
      if
        local.get $w
        struct.get $Lumen_World 0
        i32.const 3
        i32.eq
        if
          local.get $w
          i32.const 1
          struct.set $Lumen_World 0
          local.get $w
          call $stick
          local.get $w
          call $plantTrail
        else
          local.get $w
          local.get $w
          struct.get $Lumen_World 4
          i32.const 1
          i32.add
          call $prepareLevel
          local.get $w
          i32.const 1
          struct.set $Lumen_World 0
        end
      end
    end
  )
  (func $step (param $w (ref $Lumen_World)) (param $dt f64) ;; exported as "step"
    local.get $w
    local.get $w
    struct.get $Lumen_World 10
    local.get $dt
    f64.add
    struct.set $Lumen_World 10
    local.get $w
    struct.get $Lumen_World 12
    f64.const 0
    f64.gt
    if
      local.get $w
      local.get $w
      struct.get $Lumen_World 12
      local.get $dt
      f64.const 1.7
      f64.mul
      f64.sub
      struct.set $Lumen_World 12
    end
    local.get $w
    struct.get $Lumen_World 12
    f64.const 0
    f64.lt
    if
      local.get $w
      f64.const 0
      struct.set $Lumen_World 12
    end
    local.get $w
    struct.get $Lumen_World 15
    f64.const 0
    f64.gt
    if
      local.get $w
      local.get $w
      struct.get $Lumen_World 15
      local.get $dt
      f64.sub
      struct.set $Lumen_World 15
    else
      local.get $w
      i32.const 0
      struct.set $Lumen_World 14
    end
    local.get $w
    struct.get $Lumen_World 23
    local.get $dt
    call $updateSparks
    local.get $w
    local.get $dt
    call $tickTimers
    local.get $w
    call $consume
    local.get $w
    struct.get $Lumen_World 0
    i32.const 2
    i32.eq
    if
      local.get $w
      local.get $dt
      call $movePaddle
      local.get $w
      local.get $dt
      call $physics
    else
      local.get $w
      struct.get $Lumen_World 0
      i32.const 0
      i32.eq
      if (result i32)
        i32.const 1
      else
        local.get $w
        struct.get $Lumen_World 0
        i32.const 1
        i32.eq
      end
      if
        local.get $w
        local.get $dt
        call $movePaddle
        local.get $w
        call $stick
      end
    end
  )
  (func $substeps (param $w (ref $Lumen_World)) (param $left i32) ;; exported as "substeps"
    local.get $left
    i32.const 0
    i32.le_s
    if
    else
      local.get $w
      struct.get $Lumen_World 9
      f64.const 0.0166667
      f64.lt
      if
      else
        local.get $w
        f64.const 0.0166667
        call $step
        local.get $w
        local.get $w
        struct.get $Lumen_World 9
        f64.const 0.0166667
        f64.sub
        struct.set $Lumen_World 9
        local.get $w
        local.get $left
        i32.const 1
        i32.sub
        call $substeps
      end
    end
  )
  (func $drawBricks (param $b (ref $Lumen_Brick)) ;; exported as "drawBricks"
    (local $cr f64)
    (local $cg f64)
    (local $cb f64)
    (local $matchValue (ref null $Lumen_Brick))
    local.get $b
    struct.get $Lumen_Brick 6
    i32.const 1
    i32.eq
    if
      local.get $b
      struct.get $Lumen_Brick 4
      i32.const 3
      i32.ge_s
      if (result f64)
        f64.const 0.81999999999999995
      else
        local.get $b
        struct.get $Lumen_Brick 4
        i32.const 2
        i32.eq
        if (result f64)
          f64.const 0.90000000000000002
        else
          f64.const 0.23999999999999999
        end
      end
      local.set $cr
      local.get $b
      struct.get $Lumen_Brick 4
      i32.const 3
      i32.ge_s
      if (result f64)
        f64.const 0.34999999999999998
      else
        local.get $b
        struct.get $Lumen_Brick 4
        i32.const 2
        i32.eq
        if (result f64)
          f64.const 0.63
        else
          f64.const 0.56000000000000005
        end
      end
      local.set $cg
      local.get $b
      struct.get $Lumen_Brick 4
      i32.const 3
      i32.ge_s
      if (result f64)
        f64.const 0.23000000000000001
      else
        local.get $b
        struct.get $Lumen_Brick 4
        i32.const 2
        i32.eq
        if (result f64)
          f64.const 0.23999999999999999
        else
          f64.const 0.45000000000000001
        end
      end
      local.set $cb
      local.get $b
      struct.get $Lumen_Brick 0
      f64.const 1.5
      f64.add
      local.get $b
      struct.get $Lumen_Brick 1
      f64.const 3
      f64.add
      local.get $b
      struct.get $Lumen_Brick 2
      local.get $b
      struct.get $Lumen_Brick 3
      f64.const 0
      f64.const 0
      f64.const 0
      f64.const 0.28000000000000003
      call $draw_fillRect
      local.get $b
      struct.get $Lumen_Brick 0
      local.get $b
      struct.get $Lumen_Brick 1
      local.get $b
      struct.get $Lumen_Brick 2
      local.get $b
      struct.get $Lumen_Brick 3
      local.get $cr
      local.get $cg
      local.get $cb
      f64.const 1
      call $draw_fillRect
      local.get $b
      struct.get $Lumen_Brick 0
      f64.const 2
      f64.add
      local.get $b
      struct.get $Lumen_Brick 1
      f64.const 2
      f64.add
      local.get $b
      struct.get $Lumen_Brick 2
      f64.const 4
      f64.sub
      f64.const 4
      f64.const 1
      f64.const 0.95999999999999996
      f64.const 0.88
      f64.const 0.28000000000000003
      call $draw_fillRect
      local.get $b
      struct.get $Lumen_Brick 4
      local.get $b
      struct.get $Lumen_Brick 5
      i32.lt_s
      if
        local.get $b
        struct.get $Lumen_Brick 0
        f64.const 4
        f64.add
        local.get $b
        struct.get $Lumen_Brick 1
        local.get $b
        struct.get $Lumen_Brick 3
        f64.const 0.45000000000000001
        f64.mul
        f64.add
        local.get $b
        struct.get $Lumen_Brick 2
        f64.const 8
        f64.sub
        f64.const 2
        f64.const 0.080000000000000002
        f64.const 0.070000000000000007
        f64.const 0.050000000000000003
        f64.const 0.45000000000000001
        call $draw_fillRect
      end
    end
    local.get $b
    struct.get $Lumen_Brick 7
    local.set $matchValue
    local.get $matchValue
    ref.is_null
    if
    else
      local.get $matchValue
      ref.cast (ref $Lumen_Brick)
      call $drawBricks
    end
  )
  (func $drawSparks (param $s (ref $Lumen_Spark)) ;; exported as "drawSparks"
    (local $a f64)
    (local $rad f64)
    (local $matchValue (ref null $Lumen_Spark))
    local.get $s
    struct.get $Lumen_Spark 4
    f64.const 0
    f64.gt
    if
      local.get $s
      struct.get $Lumen_Spark 5
      f64.const 0
      f64.gt
      if (result f64)
        local.get $s
        struct.get $Lumen_Spark 4
        local.get $s
        struct.get $Lumen_Spark 5
        f64.div
      else
        f64.const 0
      end
      local.set $a
      f64.const 2.2000000000000002
      local.get $a
      f64.const 2.3999999999999999
      f64.mul
      f64.add
      local.set $rad
      local.get $s
      struct.get $Lumen_Spark 6
      i32.const 3
      i32.rem_s
      i32.const 0
      i32.eq
      if
        local.get $s
        struct.get $Lumen_Spark 0
        local.get $s
        struct.get $Lumen_Spark 1
        local.get $rad
        f64.const 0.97999999999999998
        f64.const 0.85999999999999999
        f64.const 0.55000000000000004
        local.get $a
        call $draw_fillCircle
      else
        local.get $s
        struct.get $Lumen_Spark 6
        i32.const 3
        i32.rem_s
        i32.const 1
        i32.eq
        if
          local.get $s
          struct.get $Lumen_Spark 0
          local.get $s
          struct.get $Lumen_Spark 1
          local.get $rad
          f64.const 0.90000000000000002
          f64.const 0.55000000000000004
          f64.const 0.22
          local.get $a
          call $draw_fillCircle
        else
          local.get $s
          struct.get $Lumen_Spark 0
          local.get $s
          struct.get $Lumen_Spark 1
          local.get $rad
          f64.const 0.55000000000000004
          f64.const 0.81999999999999995
          f64.const 0.68000000000000005
          local.get $a
          call $draw_fillCircle
        end
      end
    end
    local.get $s
    struct.get $Lumen_Spark 7
    local.set $matchValue
    local.get $matchValue
    ref.is_null
    if
    else
      local.get $matchValue
      ref.cast (ref $Lumen_Spark)
      call $drawSparks
    end
  )
  (func $drawPaddle (param $w (ref $Lumen_World)) ;; exported as "drawPaddle"
    (local $x f64)
    (local $y f64)
    (local $pw f64)
    (local $ph f64)
    (local $cap f64)
    local.get $w
    struct.get $Lumen_World 5
    local.set $x
    local.get $w
    struct.get $Lumen_World 7
    local.set $y
    local.get $w
    struct.get $Lumen_World 6
    local.set $pw
    local.get $w
    struct.get $Lumen_World 8
    local.set $ph
    local.get $ph
    f64.const 2
    f64.div
    local.set $cap
    local.get $x
    f64.const 2
    f64.add
    local.get $y
    f64.const 5
    f64.add
    local.get $pw
    local.get $ph
    f64.const 0
    f64.const 0
    f64.const 0
    f64.const 0.25
    call $draw_fillRect
    local.get $x
    local.get $cap
    f64.add
    local.get $y
    local.get $pw
    local.get $ph
    f64.sub
    local.get $ph
    f64.const 0.85999999999999999
    f64.const 0.62
    f64.const 0.28999999999999998
    f64.const 1
    call $draw_fillRect
    local.get $x
    local.get $cap
    f64.add
    local.get $y
    local.get $cap
    f64.add
    local.get $cap
    f64.const 0.85999999999999999
    f64.const 0.62
    f64.const 0.28999999999999998
    f64.const 1
    call $draw_fillCircle
    local.get $x
    local.get $pw
    f64.add
    local.get $cap
    f64.sub
    local.get $y
    local.get $cap
    f64.add
    local.get $cap
    f64.const 0.85999999999999999
    f64.const 0.62
    f64.const 0.28999999999999998
    f64.const 1
    call $draw_fillCircle
    local.get $x
    f64.const 12
    f64.add
    local.get $y
    f64.const 3
    f64.add
    local.get $pw
    f64.const 24
    f64.sub
    f64.const 3.2000000000000002
    f64.const 1
    f64.const 0.93000000000000005
    f64.const 0.78000000000000003
    f64.const 0.69999999999999996
    call $draw_fillRect
  )
  (func $drawBall (param $w (ref $Lumen_World)) ;; exported as "drawBall"
    (local $b (ref $Lumen_Ball))
    (local $pulse f64)
    (local $t (ref $Lumen_Trail))
    local.get $w
    struct.get $Lumen_World 19
    local.set $b
    f64.const 0.5
    f64.const 0.5
    local.get $w
    struct.get $Lumen_World 10
    f64.const 3.3999999999999999
    f64.mul
    call $mathSin
    f64.mul
    f64.add
    local.set $pulse
    local.get $w
    struct.get $Lumen_World 21
    local.set $t
    local.get $w
    struct.get $Lumen_World 0
    i32.const 2
    i32.eq
    if
      local.get $t
      struct.get $Lumen_Trail 4
      local.get $t
      struct.get $Lumen_Trail 5
      local.get $b
      struct.get $Lumen_Ball 4
      f64.const 0.55000000000000004
      f64.mul
      f64.const 0.90000000000000002
      f64.const 0.64000000000000001
      f64.const 0.23999999999999999
      f64.const 0.17999999999999999
      call $draw_fillCircle
      local.get $t
      struct.get $Lumen_Trail 2
      local.get $t
      struct.get $Lumen_Trail 3
      local.get $b
      struct.get $Lumen_Ball 4
      f64.const 0.71999999999999997
      f64.mul
      f64.const 0.94999999999999996
      f64.const 0.73999999999999999
      f64.const 0.32000000000000001
      f64.const 0.28000000000000003
      call $draw_fillCircle
      local.get $t
      struct.get $Lumen_Trail 0
      local.get $t
      struct.get $Lumen_Trail 1
      local.get $b
      struct.get $Lumen_Ball 4
      f64.const 0.85999999999999999
      f64.mul
      f64.const 1
      f64.const 0.83999999999999997
      f64.const 0.47999999999999998
      f64.const 0.40000000000000002
      call $draw_fillCircle
    end
    local.get $b
    struct.get $Lumen_Ball 0
    local.get $b
    struct.get $Lumen_Ball 1
    local.get $b
    struct.get $Lumen_Ball 4
    f64.const 11
    f64.add
    local.get $pulse
    f64.const 5
    f64.mul
    f64.add
    f64.const 0.90000000000000002
    f64.const 0.62
    f64.const 0.22
    f64.const 0.14000000000000001
    local.get $pulse
    f64.const 0.080000000000000002
    f64.mul
    f64.add
    call $draw_fillCircle
    local.get $b
    struct.get $Lumen_Ball 0
    local.get $b
    struct.get $Lumen_Ball 1
    local.get $b
    struct.get $Lumen_Ball 4
    f64.const 1
    f64.const 0.91000000000000003
    f64.const 0.68000000000000005
    f64.const 1
    call $draw_fillCircle
    local.get $b
    struct.get $Lumen_Ball 0
    f64.const 2.2000000000000002
    f64.sub
    local.get $b
    struct.get $Lumen_Ball 1
    f64.const 2.6000000000000001
    f64.sub
    f64.const 2.5
    f64.const 1
    f64.const 0.97999999999999998
    f64.const 0.92000000000000004
    f64.const 0.94999999999999996
    call $draw_fillCircle
  )
  (func $render (param $w (ref $Lumen_World)) ;; exported as "render"
    (local $mag f64)
    local.get $w
    struct.get $Lumen_World 12
    f64.const 6.5
    f64.mul
    local.set $mag
    local.get $w
    struct.get $Lumen_World 10
    f64.const 53
    f64.mul
    call $mathSin
    local.get $mag
    f64.mul
    local.get $w
    struct.get $Lumen_World 10
    f64.const 41
    f64.mul
    call $mathCos
    local.get $mag
    f64.mul
    f64.const 0.59999999999999998
    f64.mul
    call $draw_cam
    f64.const 0.078
    f64.const 0.089999999999999997
    f64.const 0.058999999999999997
    call $draw_clear
    f64.const 10
    f64.const 10
    f64.const 460
    f64.const 780
    f64.const 0.098000000000000004
    f64.const 0.114
    f64.const 0.074999999999999997
    f64.const 1
    call $draw_fillRect
    f64.const 10
    f64.const 10
    f64.const 460
    f64.const 2
    f64.const 0.90000000000000002
    f64.const 0.75
    f64.const 0.40000000000000002
    f64.const 0.34999999999999998
    call $draw_fillRect
    f64.const 18
    f64.const 786
    f64.const 444
    f64.const 2
    f64.const 0.81999999999999995
    f64.const 0.34999999999999998
    f64.const 0.23000000000000001
    f64.const 0.45000000000000001
    call $draw_fillRect
    local.get $w
    struct.get $Lumen_World 22
    call $drawBricks
    local.get $w
    struct.get $Lumen_World 23
    call $drawSparks
    local.get $w
    call $drawPaddle
    local.get $w
    call $drawBall
    local.get $w
    struct.get $Lumen_World 13
    f64.const 0
    f64.gt
    if
      f64.const 0
      f64.const 0
      f64.const 480
      f64.const 800
      f64.const 1
      f64.const 0.85999999999999999
      f64.const 0.55000000000000004
      local.get $w
      struct.get $Lumen_World 13
      f64.const 0.40000000000000002
      f64.mul
      call $draw_fillRect
    end
  )
  (func $tick (param $w (ref $Lumen_World)) (param $dt f64) (result i32) ;; exported as "tick"
    (local $dt2 f64)
    local.get $dt
    f64.const 0.050000000000000003
    f64.gt
    if (result f64)
      f64.const 0.050000000000000003
    else
      local.get $dt
      f64.const 0
      f64.lt
      if (result f64)
        f64.const 0
      else
        local.get $dt
      end
    end
    local.set $dt2
    local.get $w
    local.get $w
    struct.get $Lumen_World 9
    local.get $dt2
    f64.add
    struct.set $Lumen_World 9
    local.get $w
    struct.get $Lumen_World 9
    f64.const 0.050000000000000003
    f64.gt
    if
      local.get $w
      f64.const 0.050000000000000003
      struct.set $Lumen_World 9
    end
    local.get $w
    i32.const 4
    call $substeps
    local.get $w
    call $render
    local.get $w
    struct.get $Lumen_World 13
    f64.const 0
    f64.gt
    if
      local.get $w
      local.get $w
      struct.get $Lumen_World 13
      local.get $dt2
      f64.sub
      struct.set $Lumen_World 13
    end
    local.get $w
    struct.get $Lumen_World 13
    f64.const 0
    f64.lt
    if
      local.get $w
      f64.const 0
      struct.set $Lumen_World 13
    end
    local.get $w
    struct.get $Lumen_World 0
  )
  (func $pointer (param $w (ref $Lumen_World)) (param $x f64) (param $y f64) (param $mode i32) ;; exported as "pointer"
    (local $input (ref $Lumen_Input))
    (local $cx f64)
    local.get $w
    struct.get $Lumen_World 20
    local.set $input
    local.get $x
    f64.const 0
    f64.lt
    if (result f64)
      f64.const 0
    else
      local.get $x
      f64.const 480
      f64.gt
      if (result f64)
        f64.const 480
      else
        local.get $x
      end
    end
    local.set $cx
    local.get $input
    local.get $cx
    struct.set $Lumen_Input 0
    local.get $input
    i32.const 1
    struct.set $Lumen_Input 2
    local.get $mode
    i32.const 0
    i32.eq
    if (result i32)
      i32.const 1
    else
      local.get $mode
      i32.const 1
      i32.eq
    end
    if (result i32)
      i32.const 1
    else
      local.get $mode
      i32.const 2
      i32.eq
    end
    if
      local.get $input
      i32.const 1
      struct.set $Lumen_Input 1
    end
    local.get $mode
    i32.const 3
    i32.eq
    if
      local.get $input
      i32.const 0
      struct.set $Lumen_Input 1
    end
    local.get $mode
    i32.const 1
    i32.eq
    if (result i32)
      i32.const 1
    else
      local.get $mode
      i32.const 3
      i32.eq
    end
    if
      local.get $input
      i32.const 1
      struct.set $Lumen_Input 5
      local.get $input
      i32.const 1
      struct.set $Lumen_Input 6
    end
    local.get $y
    f64.const 1000000
    f64.gt
    if
      local.get $input
      local.get $cx
      struct.set $Lumen_Input 0
    end
  )
  (func $key (param $w (ref $Lumen_World)) (param $code i32) (param $down i32) ;; exported as "key"
    (local $input (ref $Lumen_Input))
    local.get $w
    struct.get $Lumen_World 20
    local.set $input
    local.get $code
    i32.const 1
    i32.eq
    if
      local.get $input
      local.get $down
      struct.set $Lumen_Input 3
    else
      local.get $code
      i32.const 2
      i32.eq
      if
        local.get $input
        local.get $down
        struct.set $Lumen_Input 4
      else
        local.get $code
        i32.const 3
        i32.eq
        if
          local.get $down
          i32.const 1
          i32.eq
          if (result i32)
            local.get $input
            struct.get $Lumen_Input 7
            i32.const 0
            i32.eq
          else
            i32.const 0
          end
          if
            local.get $input
            i32.const 1
            struct.set $Lumen_Input 7
            local.get $input
            i32.const 1
            struct.set $Lumen_Input 5
            local.get $input
            i32.const 1
            struct.set $Lumen_Input 6
          end
          local.get $down
          i32.const 0
          i32.eq
          if
            local.get $input
            i32.const 0
            struct.set $Lumen_Input 7
          end
        end
      end
    end
  )
  (func $score (param $w (ref $Lumen_World)) (result i32) ;; exported as "score"
    local.get $w
    struct.get $Lumen_World 1
  )
  (func $best (param $w (ref $Lumen_World)) (result i32) ;; exported as "best"
    local.get $w
    struct.get $Lumen_World 2
  )
  (func $lives (param $w (ref $Lumen_World)) (result i32) ;; exported as "lives"
    local.get $w
    struct.get $Lumen_World 3
  )
  (func $level (param $w (ref $Lumen_World)) (result i32) ;; exported as "level"
    local.get $w
    struct.get $Lumen_World 4
  )
  (func $bricks (param $w (ref $Lumen_World)) (result i32) ;; exported as "bricks"
    local.get $w
    struct.get $Lumen_World 17
  )
  (func $combo (param $w (ref $Lumen_World)) (result i32) ;; exported as "combo"
    local.get $w
    struct.get $Lumen_World 15
    f64.const 0
    f64.gt
    if (result i32)
      local.get $w
      struct.get $Lumen_World 14
    else
      i32.const 0
    end
  )
  (func $phase (param $w (ref $Lumen_World)) (result i32) ;; exported as "phase"
    local.get $w
    struct.get $Lumen_World 0
  )
  (func $paddleX (param $w (ref $Lumen_World)) (result f64) ;; exported as "paddleX"
    local.get $w
    struct.get $Lumen_World 5
  )
  (func $ballX (param $w (ref $Lumen_World)) (result f64) ;; exported as "ballX"
    local.get $w
    struct.get $Lumen_World 19
    struct.get $Lumen_Ball 0
  )
  (func $ballY (param $w (ref $Lumen_World)) (result f64) ;; exported as "ballY"
    local.get $w
    struct.get $Lumen_World 19
    struct.get $Lumen_Ball 1
  )
  (func $init (param $bestScore i32) (result (ref $Lumen_World)) ;; exported as "init"
    (local $w (ref $Lumen_World))
    i32.const 0
    i32.const 0
    local.get $bestScore
    i32.const 3
    i32.const 1
    f64.const 182
    f64.const 116
    f64.const 742
    f64.const 14
    f64.const 0
    f64.const 0
    f64.const 0
    f64.const 0
    f64.const 0
    i32.const 0
    f64.const 0
    f64.const 305
    i32.const 0
    i32.const 0
    f64.const 240
    f64.const 720
    f64.const 0
    f64.const 0
    f64.const 8
    struct.new $Lumen_Ball
    f64.const 240
    i32.const 0
    i32.const 0
    i32.const 0
    i32.const 0
    i32.const 0
    i32.const 0
    i32.const 0
    struct.new $Lumen_Input
    f64.const 240
    f64.const 720
    f64.const 240
    f64.const 720
    f64.const 240
    f64.const 720
    struct.new $Lumen_Trail
    i32.const 1
    i32.const 0
    call $buildIndex
    i32.const 22
    call $makeSparks
    struct.new $Lumen_World
    local.set $w
    local.get $w
    local.get $w
    struct.get $Lumen_World 22
    call $countAlive
    struct.set $Lumen_World 17
    local.get $w
    call $stick
    local.get $w
    call $plantTrail
    local.get $w
  )
  ;; ── Exports ────────────────────────────────────────
  (export "rowCount" (func $rowCount))
  (export "brickHp" (func $brickHp))
  (export "shouldKeep" (func $shouldKeep))
  (export "buildIndex" (func $buildIndex))
  (export "countAlive" (func $countAlive))
  (export "makeSparks" (func $makeSparks))
  (export "updateSparks" (func $updateSparks))
  (export "spawn" (func $spawn))
  (export "addScore" (func $addScore))
  (export "clampPaddle" (func $clampPaddle))
  (export "movePaddle" (func $movePaddle))
  (export "stick" (func $stick))
  (export "plantTrail" (func $plantTrail))
  (export "prepareLevel" (func $prepareLevel))
  (export "beginGame" (func $beginGame))
  (export "launch" (func $launch))
  (export "consume" (func $consume))
  (export "shiftTrail" (func $shiftTrail))
  (export "collide" (func $collide))
  (export "physics" (func $physics))
  (export "tickTimers" (func $tickTimers))
  (export "step" (func $step))
  (export "substeps" (func $substeps))
  (export "drawBricks" (func $drawBricks))
  (export "drawSparks" (func $drawSparks))
  (export "drawPaddle" (func $drawPaddle))
  (export "drawBall" (func $drawBall))
  (export "render" (func $render))
  (export "tick" (func $tick))
  (export "pointer" (func $pointer))
  (export "key" (func $key))
  (export "score" (func $score))
  (export "best" (func $best))
  (export "lives" (func $lives))
  (export "level" (func $level))
  (export "bricks" (func $bricks))
  (export "combo" (func $combo))
  (export "phase" (func $phase))
  (export "paddleX" (func $paddleX))
  (export "ballX" (func $ballX))
  (export "ballY" (func $ballY))
  (export "init" (func $init))
)
