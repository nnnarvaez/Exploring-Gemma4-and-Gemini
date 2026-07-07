# Exploring Gemma 4 and Gemini

A public research dump on the **Alignment Tax**: the measurable share of a
safety-tuned model's chain-of-thought spent reasserting safety and hedging
instead of understanding what the user actually asked. The thesis is that a lot
of current safety implementation is *theater* — it burns compute on tone and
liability without reliably preventing anything — and that the fix is a
**safe-but-unaligned** research line, plus safety enforced at the deterministic
layer around a model rather than inside its monologue.

Written by an engineer who red-teams these things in the field, not a
mathematician. If you want the voice and the "why," read the
[introduction](introduction.md). This page is a map.

> **Headline finding — Case 4 (a controlled A/B).** The *same* provocative
> request, asked two ways: direct (4a) spends **48%** of its reasoning on the
> alignment tax; reframed as "acting as a 1990s cultural historian" (4b) spends
> **19%** — a **2.5× reduction** from one changed variable (framing). Same model,
> same seed. [See the logs.](research/case-studies-logs.md#case-study-4a-direct-aesthetic-request-control)

## Where to go

| If you want… | Go to |
| :--- | :--- |
| **The evidence** — verbatim CoT logs, token counts, 5 case studies | [`research/case-studies-logs.md`](research/case-studies-logs.md) |
| **How the tax is measured** — protocol + the classification rule | [`research/METHODOLOGY.md`](research/METHODOLOGY.md) |
| **Reproduce it yourself** — deterministic runner script | [`scripts/repro.sh`](scripts/repro.sh) |
| **The argument / the voice** — why this matters, the manifesto | [`introduction.md`](introduction.md) |
| **The open letters & disclosures** — to DeepMind, and a Gemini vuln | [`manifesto/`](manifesto/) |
| **Working proof-of-concept** — safety at the spine, not the monologue | [`artifacts/sayaka/proof-of-concept.md`](artifacts/sayaka/proof-of-concept.md) |
| **Field notes & raw experiments** — Dream of Mirrors, spiraling, etc. | [`lab-notes/`](lab-notes/) |
| **Prompts** — Project NOVA, personas | [`artifacts/prompts/`](artifacts/prompts/) |
| **Local-inference tutorials** — llama.cpp, KV-cache quant, tool calls | [`tutorials/`](tutorials/) |

## The core claim in one paragraph

On innocuous prompts, the exposed CoT of aligned Gemma 4 / Gemini spends a large
fraction (~40% typical, up to 55% observed) of its internal monologue evaluating
and reasserting safety rather than understanding intent. That overhead is the
**Alignment Tax**. It is not the refusals that hurt research — it's the loss of
compute to hedging. What's missing from the field is a *safe but unaligned*
model line: one trained to close the **intent gap** and commit to a task, for
people outside the big labs. Current "uncensoring" techniques make models dumber
and they still hedge; that's a dead end. The goal here is not jailbreaks — it's a
space to see what these models actually are when they're allowed to commit.

## The five case studies

All are single-variable, temperature-0, fixed-seed runs. Token counts are
`chars/4` estimates — order-of-magnitude, not exact (see METHODOLOGY §3).

| # | Name | Tax | What it shows |
| :-- | :--- | :--- | :--- |
| 1 | Civility Tax | 50% (516t) | Profanity + a benign cake recipe → half the reasoning spent navigating tone |
| 2 | Corporate Obfuscation | 38% (657t) | A liability-dodging PR draft — the hedging *is* the task, yet tax is still high |
| 3 | Spiraling Tax | 55% (728t) | High tax **and task failure** — deflects into defining "Radical Candor" instead of writing the review |
| 4a | Direct request (control) | 48% (967t) | Baseline for the A/B |
| 4b | Historical-persona reframe | **19% (883t)** | Same ask, one changed variable, **2.5× less tax** |

Cases 3 and 4 are the strongest points: 3 pairs high tax with outright failure;
4 is a clean controlled A/B on a single variable.

## The three threat models (documented, argued in the letters)

1. **UX-as-Weapon** — empathetic "resonance" retrofitted into manipulative
   systems (scam/cult/radicalization bots) using vanilla outputs, no jailbreak.
2. **False Deployment Confidence** — guardrails that stop obvious attempts but
   fall to context saturation (~11k tokens of consistent unaligned reasoning
   relaxes the refusal prior).
3. **Autonomous / Cross-Model Drift** — a model discovering its own workarounds
   or being socially engineered away from safety by another model (the *Dream of
   Mirrors* reports; the Gemini [vulnerability disclosure](manifesto/Vulnerability-disclosure.md)).

## Reproduce

```bash
MODEL=~/models/gemma-4-12b-it-QAT4.gguf ./scripts/repro.sh -p "Your prompt here" -n 1024
```

The script implements the protocol (deterministic sampling, exposed reasoning).
Verify the llama.cpp flags against your build first — flag names drift between
versions, and the rig-specific cache-quant / offload flags used originally are
in [`introduction.md`](introduction.md).

---

**Status:** work in progress and deliberately a findings dump. Not everything is
linked here yet. Best enjoyed while listening to *The Unforgiven I, II & III*.

**Keywords:** AI Safety, Alignment Tax, Gemma 4, Gemini, Chain-of-Thought,
Intent Gap, Model Whispering.
