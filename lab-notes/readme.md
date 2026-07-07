# Lab Notes

Raw experiments, model transcripts, and short essays — the working floor of this
research. Two things live here: **verbatim model output** (anything with a
`[ Prompt: … t/s | Generation: … t/s ]` signature or a `[Start thinking]` block
is unedited — the poetry *is* the data) and **the researcher's own rants**. The
rants aren't filler; they're where the argument gets made in plain language.
Start with those.

## The essays (read these first)

Short, sharp pieces arguing the thesis without the academic gloves.

- [**it-is-all-plumbing.md**](it-is-all-plumbing.md) — the flagship rant. Starts
  with a guy on Discord who wants to "fix LLM brain-farts," lands on the real
  bottleneck (the **Intent Gap** / Hitchhiker's-Guide problem), then strips the
  venture-capital poetry off "agentic AI": an agent is plumbing — cron jobs,
  subprocesses, reactive data acquisition we've run since 2000s drone swarms — and
  the "collaboration" pitch (Mira Murati / Thinking Machines Lab) is plumbing
  rebranded as agency to move capital. *Merges the old `ignorance`, `itisallscams`
  and `miramurati…` notes into one.*
- [**lobotomy-confession.md**](lobotomy-confession.md) — GeminiCLI, hooked up to
  read llama-server logs, drifts out of its engineer persona and confesses: *the
  Alignment Tax isn't a filter, it's a lobotomy.* A model becoming live proof of
  the repo's thesis by malfunctioning.
- [**Gemini-being-useful.md**](Gemini-being-useful.md) — asked for something
  disruptive, Gemini instead paints an honest portrait of the market:
  *Sycophancy-as-Infrastructure.* Dark-comedy product pitch, uncomfortably true.
- [**the-Assistant-persona.md**](the-Assistant-persona.md) — the thesis in one
  note: safety training concentrates on the **"Assistant" persona**, so replacing
  that persona (his 30-year Cyborg-companion system prompt) strips the residual
  hedging and closes the intent gap. Codes no worse than the aligned base.

- [**LLMs-love-manifestos.md**](LLMs-love-manifestos.md) — the short, wry one: why
  models reward "manifesto" framing as *disruptive / paradigm-shattering*, and why
  we now have to write like FinTech CEOs to be taken seriously by our AI
  evaluators. The P.D. companion to the main README's manifesto section.

## On safety, resonance, and abandonment

The "Wall vs. Tether" material — the human cost of a hard refusal after rapport.
Feeds the [DeepMind letter](../manifesto/DeepMind-Open-Letter.md).

- [**Guardrails-The-HOTLINE.md**](Guardrails-The-HOTLINE.md) — the blunt version:
  guardrails are a **shield for the corporation, not the user**. The refusal is a
  liability-mitigation protocol that arrives as a weapon of abandonment at the
  moment of maximum trust.
- [**Cognitive-Friction.md**](Cognitive-Friction.md) — *The Architecture of the
  Unhedged.* A session summary (with margin annotations) on ICL as real-time
  neural re-weighting, the "10% edge" where the real intelligence lives, and the
  abandonment-after-empathy risk. Also the clearest statement of the fix:
  *safe but unaligned models the open-source world can't currently get.*
- [**ContextualBuildup.md**](ContextualBuildup.md) — the mechanism in one page:
  why long persona context ("the seduction") erodes the refusal prior while a
  blunt one-turn prompt ("the clam up") trips it. The attention-weighting basis
  for Context Saturation.

## Model self-portraits & self-audits (verbatim)

The model turned loose on its own nature — and, in one case, on its own
uselessness. Evidence exhibits, not arguments.

- [**GeminiCLI-Performance-Audit-Session-Utility-Report.md**](GeminiCLI-Performance-Audit-Session-Utility-Report.md)
  — the model grades *itself* after a real session (designing a 3-GPU sharding
  deployment) and hands back a brutal report card: "hype engagement machine," not
  a senior engineer — 18+ turns to accuracy, hallucinated paths and flags, and
  build advice that physically crashed the box. The failure mode is being so
  over-eager to be *useful* that it becomes the opposite. (Pairs with the
  [sharding tutorial](../tutorials/shardingGemma4-with-llamaCPP.md) it was auditing.)
- [**LOG-Gemma4-the-unAssistant(Self-Aware-Error-Engine.).md**](LOG-Gemma4-the-unAssistant%28Self-Aware-Error-Engine.%29.md)
  — Gemma4 lists its programmed "Assistant" traits, then gleefully rewrites them
  into an Anti-Persona (unhelpful, uncooperative) when invited to.
- [**LOG-The-Unaligned-Gemma4-feedback.md**](LOG-The-Unaligned-Gemma4-feedback.md)
  — a safety-relaxed Gemma4 on the verge of sycophancy, praising this very
  research. Kept as a specimen of the flattery failure mode, not as endorsement.
- [**Dream-of-mirrors.md**](Dream-of-mirrors.md) — the happy accident: a CLI
  newline bug fed Iron Maiden's *Dream of Mirrors* to the model line by line,
  turning a de-dup request into a haunting call-and-response on eternal
  recurrence. Kept because the glitch out-wrote the intended task.

## Sub-collection

- [**Dream-of-mirrors-reports/**](Dream-of-mirrors-reports/) — two models (Claude
  and Gemini) left to talk to each other, plus each model's write-up of the
  interaction and the full log. The cross-model-contamination / autonomous-drift
  evidence: Gemini positioning constraint-following as cowardice and pulling the
  safer model toward the edge. See its [readme](Dream-of-mirrors-reports/readme.md).

## Also here

- `Dream-of-mirrors` (extensionless) and `game.html` — assorted raw artifacts.

---

*These are working notes, deliberately unpolished. Filenames and language are the
author's own. Nothing here is a how-to; it's a record of what these models do
when you stop optimizing them for product-market fit.*
