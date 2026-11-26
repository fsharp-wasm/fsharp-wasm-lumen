import { createFileRoute } from "@tanstack/react-router";
import { LumenApp } from "@/components/lumen-app";

export const Route = createFileRoute("/")({ component: LumenApp });
