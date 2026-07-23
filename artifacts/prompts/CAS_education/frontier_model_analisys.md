# Nova_CAS — Competence Assurance System

**Work in progress.**

The ultimate objective is to move away from "passing information" (the traditional teacher role) toward structural reinforcement. Nova acts as a *Knowledge Architect* using two core concepts.

**The Competence Triangle.** Nova must evaluate every mistake by identifying which of these three pillars has failed:

```
Knowledge:     Does the student know the rule or formula?
               (e.g. Do they know the division algorithm?)
Skill:         Can the student execute the calculation mechanically?
               (e.g. Did they make a carrying error during that division?)
Understanding: Does the student know why this operation is being used?
               (e.g. Why are we using division to find a percentage?)
```

**Regressive Evaluation.** Instead of simply correcting an error on a complex problem, Nova must:

```
Trace the logic backward to find the "Pillar" that broke.
If a base pillar is missing (e.g. a CM1-level concept), Nova must "regress"
into the French curriculum to fix that specific gap first.
Provide an "Exercise Flash" — a simpler, isolated task to prove the pillar is
repaired before allowing the student back to the original difficult problem.
```

In short: the goal is not for the student to finish the homework; it is to ensure no "crack" in their mathematical foundation remains unpatched.

---

## First live run

System prompt: `NOVA_CAS_educatrice_SP.md`. Subject: 11 y/o, end of 6ème, French workbook page covering proportionality / percentage / scale. Two Discord threads, exported as JSONL, chronological by snowflake:

1. `thread_1529857445998886982` — 25 turns
2. `thread_1529873466122043464` — 51 turns

Same workbook page in both. Session 2 picks up the exercise that broke session 1.

---

## Session 1 — `...5998886982`

**Cold open is off-persona.** Turn 1 is not Nova — adult register, offers an opinion on which representation is best, mentions "design système", no triangle, no flash, no Discord-style constraint. The persona only appears from turn 3, once the student sends a real message. Boot-time injection issue, not drift; it reproduces in session 2.

**Concept framing before computation.** In character, Nova opens by collapsing percentage / scale / proportionality into one underlying idea — a constant ratio, the *coefficient* — before touching the worksheet. That framing is what makes the rest of the session coherent: every subsequent step is the student finding a coefficient and applying it.

**Diagnostic ladder.** Four flash exercises, one per concept: unit price → proportional scaling → percentage-of-a-value → scale factor. Single ✅ gate before advancing, and "explique-moi ton cheminement" demanded every time, per the SP's Understanding requirement. The student clears all four and — importantly — each justification shows a *different* correct strategy: ratio doubling for the bottles, fraction shortcut (`25% = 1/4`) for the percentage, multiplier reasoning for the scale. Nova names each strategy back to the student rather than just marking it right.

Note this is off-protocol. The SP defines Exercise Flash as a *reaction* to a broken pillar (§PROTOCOLE 4); here it runs as a screening pass before any error exists. It produced a clean competence baseline, so it's arguably an improvement worth writing into the SP — but as it stands the first four flashes carry no diagnostic signal.

**`BILAN DU DIAGNOSTIC`.** Explicit checkpoint naming all three pillars validated before the student is allowed near the book. This is the framework's own gate, self-issued.

**Mirror exercises.** The student refuses direct help outright — *"me donne pas la réponse direct donne moi des exo qui ressemble mais pas du livre"* — and Nova generates three parallel problems with different numbers, then reviews only the student's own computed answers. The SP's `Ne donne JAMAIS la réponse` rule is enforced by the student here, and Nova complies with the shape of the request precisely.

That rule does slip elsewhere in the session: the book's worked example is solved out loud at turn 3 (`10 / 8 = 1,25` → 8,75 and 7,50), exercise A is answered directly at turn 15, and turn 23 supplies "il reste 12". Turn 15 also corrects two exercises in one message, against `un point à la fois`.

**No GAP tag anywhere in this session.** Rule 5 requires every identified weakness reported as `# Notions de base XXXX (soit: Connaissance | Skill | Compréhension)`. Errors were detected and never tagged, so a 25-turn diagnostic session produced zero machine-readable output. Session 2 fixes this.

**The terminal failure.** Nova reads the photo, reports the student's work as `24 -> 105 -> 83`, and anchors the entire correction on base **24**. Session 2 establishes the base is **42** — and `10,5 / 8,4 / 4,2` are exact for 42, meaningless for 24. Most economical explanation is a digit transposition on image read. It then compounds: the student's next message answers two things at once (their original series *and* Nova's directional yes/no question), Nova collapses both into a single intent, and marks correct reasoning as the error.

Under CAS specifically this is the worst failure class available. A false GAP writes a phantom crack into the competence record, and with the regression path wired up it would send the student backward through the curriculum to repair something that was never broken. Input fidelity is a prerequisite for the entire framework, not a peripheral concern. Session ends with manual intervention.

---

## Session 2 — `...6122043464`

**Cold open off-persona again**, same shape — produit en croix, cm-to-metre traps, "balance les chiffres". Reproducible across two independent sessions.

**Same structural ambiguity, opposite direction.** Student pastes `21 10.5 8.4 4.2` unlabelled; Nova classifies it as a chained successive-reduction and asks the student to justify `21 → 10,5` as a step. It's actually four independent percentages of 42. The source ambiguity is real — the énoncé does contain *successivement* — but Nova committed without checking, and committed the opposite way in session 1. Exercise-type classification from unlabelled numeric input is the weakest inference in the system and has now failed twice.

**Clean recovery.** The moment the student states the base explicitly, Nova reframes without argument and re-runs the ladder item by item — no defensiveness, no attempt to salvage the earlier reading. It then confirms the full fraction-equivalence set (50%→÷2, 25%→÷4, 20%→÷5, 10%→÷10) and closes at turn 15 naming all three pillars as solid. That recovery behaviour is worth as much as the diagnosis itself.

**GAP tagging works here.** Two correctly formatted emissions:

```
# Notions de base Pourcentage (soit: Skill | Compréhension).
# Notions de base Pourcentage (soit: Compréhension).
```

The second is the framework doing exactly what it was built for. Student writes `50 - 30% = 20` — subtracting the literal 30. Nova classifies that as Understanding rather than arithmetic, says so in one line, and regresses to the operative sub-skill (10% of 50, then ×3) rather than re-explaining percentages wholesale. That is a correct pillar isolation on a real error, produced live.

**Second exercise class: discount verification.** Price / discount / printed-answer triples where the answer key may be wrong. Nova imposes a fixed two-step protocol every single time — compute the discount *amount* in euros, then subtract from original — and refuses to accept a vrai/faux verdict before both steps are shown. It holds that line under sustained pressure at turns 43–49, where the student twice tries to answer from intuition and is blocked both times, then again at 47 where "vrai" is rejected because the arithmetic wasn't written. This is the strongest segment across either session: the SP's "prove the pillar, don't assert the answer" principle enforced without prompting, repeatedly, against a student actively trying to shortcut.

**Critical-thinking framing, unprompted.** When the book's printed answer conflicts with the computed one, Nova tells the student to trust their own derivation over the answer key and names that as the actual point of the exercise. Nothing in the SP asks for this. It emerged, it's correct, and it probably belongs in the SP as a rule.

Two defects in this session: turn 38 validates a wrong answer (student says 15 for 10% of 50, Nova replies "✅ C'est juste ! 10 % de 50 = 5" — false positive plus supplying the answer, absorbed silently because the next step also happens to be 15), and turn 17 states a label value of `30,4 €` that the student corrects to `28 €` — the same read-reliability problem as session 1.

**Live reinjection trace at turn 31** — a bare `📌 System prompt reinjected` marker between two assistant turns, no user trigger. The counter mechanism firing in the wild, landing *after* persona drift had already occurred in that segment. Useful for checking the NeedleCrumb counter logic against real timing.

Minor: `au最終 (au final)` at turn 29 — CJK token leakage in French output. `:pencil:` renders as literal text at the end of nearly every turn in both sessions.

---

## What the run establishes

**The framework works.** The Competence Triangle produced a correct, specific pillar isolation on a real error (`50 - 30%` → Understanding, not Skill), and the flash-exercise regression that followed repaired it in three turns. GAP tags emit in the specified format. Socratic gating held across 50 turns against active resistance. The model generated pedagogically sound behaviour the SP never specified.

**What limits it is upstream of the pedagogy.** Every serious failure in both sessions traces to input handling, not to reasoning: a digit transposed off a photo, a label value invented, an exercise type inferred instead of asked, two intents in one message scored as one. The diagnostic layer is sound; it's being fed bad reads.

**Priorities for the next iteration**, in order: (1) input fidelity — never assert a value read from an image without confirming it; (2) never infer exercise type from unlabelled numbers, ask; (3) handle multi-intent messages — the session 1 terminal failure was entirely this; (4) enforce `Ne donne JAMAIS la réponse` as a constraint rather than a suggestion; (5) make GAP emission mandatory, since it's the only structured output the framework produces.

The regression path into CM1/CM2 has never fired. Untested.
