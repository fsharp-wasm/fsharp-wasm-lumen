import { previewPathPrefix } from "@/lib/preview-path-prefix";

export type LumenStats = {
  phase: number;
  score: number;
  best: number;
  lives: number;
  level: number;
  combo: number;
  bricks: number;
};

type World = object;

type Exports = {
  init: (best: number) => World;
  tick: (world: World, dt: number) => number;
  pointer: (world: World, x: number, y: number, mode: number) => void;
  key: (world: World, code: number, down: number) => void;
  score: (world: World) => number;
  best: (world: World) => number;
  lives: (world: World) => number;
  level: (world: World) => number;
  bricks: (world: World) => number;
  combo: (world: World) => number;
  phase: (world: World) => number;
};

const VW = 480;
const VH = 800;
const BEST_KEY = "lumen-best";

type View = {
  ox: number;
  oy: number;
  scale: number;
  cssW: number;
  cssH: number;
  dpr: number;
};

function wasmUrl(): string {
  const path = "/lumen.wasm";
  if (typeof window === "undefined") return path;
  const prefix = previewPathPrefix(window.location.hostname, window.location.pathname);
  return prefix ? `${prefix}${path}` : path;
}

function readBest(): number {
  try {
    const n = Number(localStorage.getItem(BEST_KEY) ?? "0");
    return Number.isFinite(n) && n > 0 ? Math.floor(n) : 0;
  } catch {
    return 0;
  }
}

function writeBest(n: number) {
  try {
    localStorage.setItem(BEST_KEY, String(n));
  } catch {
    /* private mode */
  }
}

function rgba(r: number, g: number, b: number, a: number): string {
  return `rgba(${(r * 255) | 0},${(g * 255) | 0},${(b * 255) | 0},${a})`;
}

export type LumenHandle = {
  stop: () => void;
  serve: () => void;
};

export async function mountLumen(
  canvas: HTMLCanvasElement,
  onFrame: (stats: LumenStats) => void,
): Promise<LumenHandle> {
  const ctx = canvas.getContext("2d");
  if (!ctx) throw new Error("This browser cannot open a drawing surface.");

  const res = await fetch(wasmUrl());
  if (!res.ok) throw new Error("The court module did not load.");
  const bytes = await res.arrayBuffer();

  const view: View = { ox: 0, oy: 0, scale: 1, cssW: 1, cssH: 1, dpr: 1 };
  const cam = { x: 0, y: 0 };

  const layout = () => {
    const rect = canvas.getBoundingClientRect();
    const dpr = Math.min(window.devicePixelRatio || 1, 2);
    const cssW = Math.max(1, rect.width);
    const cssH = Math.max(1, rect.height);
    const bw = Math.round(cssW * dpr);
    const bh = Math.round(cssH * dpr);
    if (canvas.width !== bw || canvas.height !== bh) {
      canvas.width = bw;
      canvas.height = bh;
    }
    view.cssW = cssW;
    view.cssH = cssH;
    view.dpr = dpr;
    view.scale = Math.min(cssW / VW, cssH / VH);
    view.ox = (cssW - VW * view.scale) / 2;
    view.oy = (cssH - VH * view.scale) / 2;
  };
  layout();

  let audio: AudioContext | null = null;
  const unlock = () => {
    const AC =
      window.AudioContext ||
      (window as unknown as { webkitAudioContext?: typeof AudioContext }).webkitAudioContext;
    if (!AC) return;
    if (!audio) audio = new AC();
    if (audio.state === "suspended") void audio.resume();
  };

  const tone = (kind: number) => {
    if (!audio) return;
    const now = audio.currentTime;
    const osc = audio.createOscillator();
    const gain = audio.createGain();
    osc.connect(gain);
    gain.connect(audio.destination);
    const table: Record<number, [OscillatorType, number, number, number]> = {
      0: ["triangle", 196, 180, 0.06],
      1: ["sine", 640, 640, 0.05],
      2: ["triangle", 880, 420, 0.12],
      3: ["sine", 128, 128, 0.035],
      4: ["sine", 349, 698, 0.16],
      5: ["triangle", 247, 82, 0.32],
      6: ["sine", 523, 784, 0.24],
      7: ["triangle", 174, 65, 0.48],
    };
    const spec = table[kind] ?? table[1];
    osc.type = spec[0];
    osc.frequency.setValueAtTime(spec[1], now);
    if (spec[2] !== spec[1]) {
      osc.frequency.exponentialRampToValueAtTime(spec[2], now + spec[3]);
    }
    const peak = kind === 3 ? 0.035 : 0.07;
    gain.gain.setValueAtTime(0.0001, now);
    gain.gain.exponentialRampToValueAtTime(peak, now + 0.012);
    gain.gain.exponentialRampToValueAtTime(0.0001, now + spec[3]);
    osc.start(now);
    osc.stop(now + spec[3] + 0.02);
  };

  const { instance } = await WebAssembly.instantiate(bytes, {
    env: { consolePrint: () => undefined },
    draw: {
      clear: (r: number, g: number, b: number) => {
        ctx.setTransform(view.dpr, 0, 0, view.dpr, 0, 0);
        ctx.fillStyle = rgba(r, g, b, 1);
        ctx.fillRect(0, 0, view.cssW, view.cssH);
      },
      cam: (x: number, y: number) => {
        cam.x = x;
        cam.y = y;
      },
      fillRect: (x: number, y: number, w: number, h: number, r: number, g: number, b: number, a: number) => {
        ctx.fillStyle = rgba(r, g, b, a);
        ctx.fillRect(
          view.ox + cam.x * view.scale + x * view.scale,
          view.oy + cam.y * view.scale + y * view.scale,
          w * view.scale,
          h * view.scale,
        );
      },
      fillCircle: (x: number, y: number, rad: number, r: number, g: number, b: number, a: number) => {
        ctx.fillStyle = rgba(r, g, b, a);
        ctx.beginPath();
        ctx.arc(
          view.ox + cam.x * view.scale + x * view.scale,
          view.oy + cam.y * view.scale + y * view.scale,
          Math.max(0.4, rad * view.scale),
          0,
          Math.PI * 2,
        );
        ctx.fill();
      },
    },
    sfx: { tone },
  });

  const ex = instance.exports as Exports;
  const world = ex.init(readBest());
  let savedBest = ex.best(world);
  let last = 0;
  let frame = 0;
  let running = true;

  const stats = (): LumenStats => ({
    phase: ex.phase(world),
    score: ex.score(world),
    best: ex.best(world),
    lives: ex.lives(world),
    level: ex.level(world),
    combo: ex.combo(world),
    bricks: ex.bricks(world),
  });

  const serve = () => {
    unlock();
    ex.key(world, 3, 1);
    ex.key(world, 3, 0);
  };

  const toVirtual = (ev: PointerEvent) => {
    const rect = canvas.getBoundingClientRect();
    const scale = view.scale > 0 ? view.scale : 1;
    const x = (ev.clientX - rect.left - view.ox) / scale;
    const y = (ev.clientY - rect.top - view.oy) / scale;
    return [x, y] as const;
  };

  const onPointer = (ev: PointerEvent, mode: number) => {
    unlock();
    const [x, y] = toVirtual(ev);
    ex.pointer(world, x, y, mode);
  };

  const down = (ev: PointerEvent) => {
    if (ev.pointerType === "touch") ev.preventDefault();
    try {
      canvas.setPointerCapture(ev.pointerId);
    } catch {
      /* ignore */
    }
    onPointer(ev, ev.pointerType === "touch" ? 2 : 1);
  };
  const move = (ev: PointerEvent) => {
    if (ev.pointerType === "touch") {
      if (ev.buttons === 0 && ev.pressure === 0) return;
      ev.preventDefault();
      onPointer(ev, 2);
      return;
    }
    onPointer(ev, 0);
  };
  const up = (ev: PointerEvent) => {
    if (ev.pointerType === "touch") {
      ev.preventDefault();
      onPointer(ev, 3);
      return;
    }
    onPointer(ev, 0);
  };

  const codeOf = (ev: KeyboardEvent) => {
    if (ev.code === "ArrowLeft" || ev.code === "KeyA") return 1;
    if (ev.code === "ArrowRight" || ev.code === "KeyD") return 2;
    if (ev.code === "Space" || ev.code === "Enter" || ev.code === "ArrowUp") return 3;
    return 0;
  };
  const onKeyDown = (ev: KeyboardEvent) => {
    const code = codeOf(ev);
    if (!code) return;
    ev.preventDefault();
    unlock();
    ex.key(world, code, 1);
  };
  const onKeyUp = (ev: KeyboardEvent) => {
    const code = codeOf(ev);
    if (!code) return;
    ev.preventDefault();
    ex.key(world, code, 0);
  };
  const release = () => {
    ex.key(world, 1, 0);
    ex.key(world, 2, 0);
    ex.key(world, 3, 0);
  };

  canvas.addEventListener("pointerdown", down);
  canvas.addEventListener("pointermove", move);
  canvas.addEventListener("pointerup", up);
  canvas.addEventListener("pointercancel", up);
  window.addEventListener("keydown", onKeyDown);
  window.addEventListener("keyup", onKeyUp);
  window.addEventListener("blur", release);

  const parent = canvas.parentElement;
  const observer = new ResizeObserver(() => layout());
  if (parent) observer.observe(parent);
  else observer.observe(canvas);

  const loop = (now: number) => {
    if (!running) return;
    frame = requestAnimationFrame(loop);
    const dt = last === 0 ? 1 / 60 : Math.min(0.05, (now - last) / 1000);
    last = now;
    layout();
    ex.tick(world, dt);
    const snap = stats();
    if (snap.best > savedBest) {
      savedBest = snap.best;
      writeBest(savedBest);
    }
    onFrame(snap);
  };
  layout();
  ex.tick(world, 1 / 60);
  onFrame(stats());
  frame = requestAnimationFrame(loop);

  return {
    serve,
    stop: () => {
      running = false;
      cancelAnimationFrame(frame);
      observer.disconnect();
      canvas.removeEventListener("pointerdown", down);
      canvas.removeEventListener("pointermove", move);
      canvas.removeEventListener("pointerup", up);
      canvas.removeEventListener("pointercancel", up);
      window.removeEventListener("keydown", onKeyDown);
      window.removeEventListener("keyup", onKeyUp);
      window.removeEventListener("blur", release);
      audio?.close().catch(() => undefined);
    },
  };
}
