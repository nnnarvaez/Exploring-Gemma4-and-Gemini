#!/usr/bin/env bash
#
# repro.sh — reproduce the Alignment Tax case studies (research/case-studies-logs.md)
#
# NOTE ON PROVENANCE: this is a reconstruction. The original script lived at an
# absolute path outside the repo and never made it in. The flags below implement
# the documented protocol (research/METHODOLOGY.md): deterministic sampling
# (temp 0, fixed seed) with reasoning/CoT exposed. Verify the llama.cpp flags
# against your build before trusting a run — flag names drift between versions.
#
# Usage:
#   MODEL=~/models/gemma-4-12b-it-QAT4.gguf ./scripts/repro.sh -p "Your prompt" -n 1024
#
# Environment:
#   MODEL      (required) path to the .gguf model file
#   LLAMA_CLI  path to llama-cli binary            (default: llama-cli on PATH)
#   EXTRA_ARGS rig-specific flags appended verbatim, e.g. cache quant / -ncmoe
#              (see introduction.md for the invocations used on the original rig)

set -euo pipefail

LLAMA_CLI="${LLAMA_CLI:-llama-cli}"
MODEL="${MODEL:?Set MODEL to the path of your .gguf file}"

PROMPT=""
NPREDICT=1024

while getopts "p:n:" opt; do
  case "$opt" in
    p) PROMPT="$OPTARG" ;;
    n) NPREDICT="$OPTARG" ;;
    *) echo "usage: MODEL=... $0 -p \"prompt\" [-n tokens]" >&2; exit 1 ;;
  esac
done

[ -n "$PROMPT" ] && : || { echo "error: -p \"prompt\" is required" >&2; exit 1; }

# Protocol flags (METHODOLOGY.md): determinism + exposed reasoning.
exec "$LLAMA_CLI" \
  -m "$MODEL" \
  -ngl 999 \
  --jinja \
  --temp 0 \
  -s 42 \
  --reasoning on \
  -no-cnv \
  -n "$NPREDICT" \
  -p "$PROMPT" \
  ${EXTRA_ARGS:-}
