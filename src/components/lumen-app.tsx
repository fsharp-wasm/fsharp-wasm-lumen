import { useEffect, useRef, useState } from "react";
import { Flame } from "lucide-react";
import { mountLumen, type LumenHandle, type LumenStats } from "@/game/lumen-host";

const LEVEL_NAMES = ["Kindling", "Checker", "Cloister", "Diamond", "Hearth"];

function levelName(level: number): string {
  const i = (((level - 1) % 5) + 5) % 5;
  return LEVEL_NAMES[i] ?? "Kindling";
}

function formatScore(n: number): string {
  return n.toLocaleString("en-US");
}

export function LumenApp() {
  const canvasRef = useRef<HTMLCanvasElement>(null);
  const scoreRef = useRef<HTMLSpanElement>(null);
  const bestRef = useRef<HTMLSpanElement>(null);
  const comboRef = useRef<HTMLSpanElement>(null);
  const api = useRef<LumenHandle | null>(null);
  const [phase, setPhase] = useState(-1);
  const [lives, setLives] = useState(3);
  const [level, setLevel] = useState(1);
  const [error, setError] = useState("");

  useEffect(() => {
    const canvas = canvasRef.current;
    if (!canvas) return;
    let dead = false;
    let handle: LumenHandle | null = null;
    let seen = "";
    mountLumen(canvas, (s: LumenStats) => {
      if (scoreRef.current) scoreRef.current.textContent = formatScore(s.score);
      if (bestRef.current) bestRef.current.textContent = formatScore(s.best);
      if (comboRef.current) {
        comboRef.current.textContent = s.combo > 1 ? `×${s.combo}` : "";
      }
      const key = `${s.phase}:${s.lives}:${s.level}`;
      if (key !== seen) {
        seen = key;
        setPhase(s.phase);
        setLives(s.lives);
        setLevel(s.level);
      }
    })
      .then((next) => {
        if (dead) {
          next.stop();
          return;
        }
        handle = next;
        api.current = next;
      })
      .catch((err: unknown) => {
        if (dead) return;
        setPhase(-2);
        setError(err instanceof Error ? err.message : "The court could not start.");
      });
    return () => {
      dead = true;
      handle?.stop();
      api.current = null;
    };
  }, []);

  const serve = () => api.current?.serve();
  const showCard = phase === 0 || phase === 5 || phase === -1 || phase === -2;

  return (
    <main className="flex h-dvh flex-col overflow-hidden bg-bg text-fg select-none">
      <header className="flex items-end justify-between gap-3 px-4 py-3 sm:px-6">
        <div className="min-w-0">
          <p className="flex items-center gap-1.5 text-xs tracking-widest text-muted uppercase">
            <Flame className="size-3.5 text-accent" aria-hidden="true" strokeWidth={2.25} />
            Lumen
          </p>
          <p className="flex items-baseline gap-2">
            <span ref={scoreRef} className="font-display text-3xl leading-none sm:text-4xl">
              0
            </span>
            <span ref={comboRef} className="font-display text-lg text-accent" />
          </p>
        </div>
        <div className="text-center">
          <p className="text-xs text-muted">Level {Math.max(1, level)}</p>
          <p className="font-display text-base leading-tight">{levelName(level)}</p>
        </div>
        <div className="text-right">
          <p className="text-xs text-muted">Best</p>
          <span ref={bestRef} className="block font-display text-lg leading-none">
            0
          </span>
          <div className="mt-2 flex justify-end gap-1.5" aria-label={`${lives} lives`}>
            {[0, 1, 2].map((i) => (
              <span
                key={i}
                className={
                  "size-2.5 rounded-full " + (i < lives && phase !== 0 ? "bg-accent" : "bg-line")
                }
              />
            ))}
          </div>
        </div>
      </header>

      <div className="relative min-h-0 flex-1">
        <canvas
          ref={canvasRef}
          className="absolute inset-0 h-full w-full touch-none"
          aria-label="Lumen court"
        />
        <div className="pointer-events-none absolute inset-0 flex items-center justify-center px-4">
          {showCard ? (
            <div className="pointer-events-auto w-full max-w-sm rounded-3xl border border-line bg-hud px-6 py-8 text-center">
              {phase === -1 ? (
                <>
                  <p className="font-display text-3xl">Lighting the court</p>
                  <p className="mt-2 text-sm text-muted">Loading the F# WebAssembly module.</p>
                </>
              ) : null}
              {phase === -2 ? (
                <>
                  <p className="font-display text-3xl">The court stayed dark</p>
                  <p className="mt-2 text-sm text-muted">{error}</p>
                  <p className="mt-2 text-sm text-muted">Lumen needs WebAssembly GC, which current Chrome, Edge, and Firefox have.</p>
                </>
              ) : null}
              {phase === 0 ? (
                <>
                  <p className="font-display text-5xl leading-none">Lumen</p>
                  <p className="mt-3 text-base text-muted">Keep the lantern aloft. Clear the glass.</p>
                  <button
                    type="button"
                    onClick={serve}
                    className="mt-6 h-12 rounded-full bg-accent px-8 text-base font-medium text-bg"
                  >
                    Serve
                  </button>
                </>
              ) : null}
              {phase === 5 ? (
                <>
                  <p className="font-display text-4xl leading-none">Out</p>
                  <p className="mt-3 text-base text-muted">Best score stays on this device.</p>
                  <button
                    type="button"
                    onClick={serve}
                    className="mt-6 h-12 rounded-full bg-accent px-8 text-base font-medium text-bg"
                  >
                    Serve again
                  </button>
                </>
              ) : null}
            </div>
          ) : null}
          {phase === 1 ? (
            <p className="absolute inset-x-4 bottom-5 text-center text-sm text-fg">
              Click, tap, or press space to serve
            </p>
          ) : null}
          {phase === 4 ? (
            <p className="font-display text-4xl text-fg">Cleared</p>
          ) : null}
        </div>
      </div>

      <p className="px-4 py-3 text-center text-xs text-muted sm:text-sm">
        Mouse, finger, or A and D. Space serves. The court itself is F# on WebAssembly GC.
      </p>
    </main>
  );
}
