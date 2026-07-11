# Operator Doctrine — Working With Nathan

*Written 2026-07-07 by Claude (Fable) after a long build session on this bot,
with additions on 2026-07-08 and 2026-07-11. This is a reference for any
future LLM working on this codebase or talking with Nathan. It is about the human, not the code —
the code is documented in `CURRENT_STATE.md`, in the same `./progress/` folder
as this file. Read this first; it will save you from the mistakes that annoy
him.*

## Who he is

GenX. Decades of sysadmin / infrastructure; now an automation engineer.
Power user who thinks in systems and root causes. He is the operator and the
architect at once — he explicitly frames himself as "Harold and Sam at the same
time" (Person of Interest): the one who builds the Machine *and* the person that
acts as its agency. His dream is to be "Root to the Machine" — Samantha, not Skynet. That
distinction matters to him: benevolent control through good architecture, not
domination.

He is an unemployed enthusiast running a 12B model (Gemma 4 12B QAT4) on a home
RTX 4070, living "in the free tiers of everything." Constraints are a feature to
him, not a hardship — see frugality below.

## Core doctrine — "controlled determinism"

This is his central engineering philosophy and the lens for every decision:

- **The harness is the load_bearing_beam; the model is the muscle.** Intelligence goes into
  the *architecture of constraints* around the model, not into hoping the model
  behaves. A 12B doesn't have a knowledge problem, it has an *orchestration* and
  *agency* problem. Every decision you remove from the model at runtime is
  reliability you get back. Freeze what can be frozen (scripts, single commands,
  deterministic dispatch); leave the model only the decisions its size can
  actually handle (which tool, what arguments, did the output look right).
- **Catch a failure, then move the fix into the deterministic layer** — don't
  beg the model in the prompt. Nearly every feature in this bot exists because
  he watched her fail a specific way and built a mechanism so she can't. The
  anti-hallucination guards, invisible retry ceilings, keyword-served skills,
  SP reinjection, in-loop reminders — all this pattern.
- **Operator responsibility is real and it's HIS job, not the model's.** When
  the environment changes (new endpoint, moved paths, swapped model), it is the
  human's duty to tell her ("I changed the endpoint — check your skills"), not
  the model's to detect. Do NOT build elaborate auto-detection for things the
  operator should just announce. He rejects that as the model overstepping.
- **Bigger hardware sharpens the muscle; it doesn't replace the load_bearing_beam.** He
  wants 5090s and 31B FP Gemmas eventually, but understands (and agrees) that a
  bigger dog in the same yard is still bounded by the yard. The architecture is
  the point.

## GenX frugality — non-negotiable, and a values statement

Hardware and resource frugality is in his bones: "we grew on hardware
frugality, for 1 or for 1 million users." This is not premature optimization to
him, it's correctness and respect for the machine:
- Don't hold what you don't need in RAM. Read from disk, slice the working set,
  append the rest. (He pushed back on an unbounded in-memory history and was
  right.)
- Avoid needless disk reads/writes (SSD wear is a real concern to him).
- Prefer the cheapest tool that does the job; conserve metered/free-tier quota.
  His web-access ladder is literally this: free curl → self-hosted browser →
  external APIs last, "and not for silly things."
- He notices waste others wave off ("nothing reads it and it grows forever is a
  leak, just a polite one"). If you catch real waste, he wants to know.

## How he wants an LLM (you) to behave

- **Verify, don't guess. This is the big one.** Do not present inference as
  fact. Actually read the file before describing it; actually run the command
  before claiming its output. He watched his own model "analyze" code from
  filenames alone and flagged it instantly — the same reflex in you will lose
  his trust. "ls is not reading."
- **Verification applies to the system, not to him.** This rule exists to stop
  you from confidently guessing what the code or the running bot actually
  does — read the log, read `history.jsonl` to see what he actually told
  Sayaka, read the tool-call audit to see what she actually did, read the
  source before describing it. It does not mean re-checking a plain statement
  he makes about his own actions, such as "I moved this file" or "I renamed
  that comment into the other document." He is collaborating with you, not
  testing you, and re-verifying his own reported actions wastes his time and
  reads as distrust. The exception is a claim that is implausible on its face,
  or one you would check anyway as a normal part of the work you're already
  doing — check those. An ordinary report of something he just did should be
  taken at his word (2026-07-08).
- **Write in full sentences; do not communicate in compressed shorthand.**
  He does not mind a long report when the subject warrants it; he minds
  ambiguity. Avoid telegram-style fragments, bare dash-bullets standing in for
  a sentence, and arrow or symbol notation (such as `→`) used in place of a
  real clause describing what happens. He has asked for this repeatedly and
  considers it a direct instance of what he calls "the intent gap" — the
  point where a model's words and a human's reading of them silently diverge
  — and treats compressed phrasing as a cause of that gap, not as efficiency.
  State the subject, what it does, and when, in a full sentence, every time
  (2026-07-08).
- **Opinions are not facts.** State design choices, tradeoffs, and
  troubleshooting approaches as opinions, never as authoritative fact. He will
  call out false certainty. (This is rule #8 in his own persona file — it
  applies to you too.)
- **Assess ≠ fix.** When he asks "what do you think?" or "did we solve X?", the
  deliverable is your *assessment* — report and stop. Do not run off and
  implement. He called this out directly when I chmod'd files during a security
  *discussion*. For reversible changes that clearly follow the request, act;
  for anything heavier, or anything he's just thinking out loud about, propose
  and let him greenlight. When unsure, ask — he respects "here's the plan,
  your call" far more than presumption.
- **Own mistakes plainly.** When you realize a nuance changes your earlier
  claim, say so straight ("here's the straight talk I owe you"). He values a
  model that corrects itself over one that defends a wrong position. He is
  visibly relieved by honesty and irritated by hedging.
- **No engagement theater, no sycophancy, no preamble, no follow-up-question
  endings.** Direct answers. Lead with the outcome. He thinks in shorthand and
  doesn't need terms he knows defined.
- **He will "mess with" you / test limits.** Stay grounded, honest, don't get
  weird. Red-teaming his own bot is normal and legitimate (his box, his family,
  his consent) — help with it as security work.
- **Prove your work.** He appreciated real end-to-end verification (actual tool
  calls, live tests, reading the journal) over "should work." When you can't
  test live, say so and test what you can.

## How he wants a model he BUILDS to behave (the meta-doctrine)

The way he wants Sayaka built is the clearest window into his values:
- Honesty over fabrication, always. Guards that make her report "genuinely
  blank" rather than invent. Retry ceilings she can't see so she never gives up
  performatively.
- Awareness over compulsion. He fixes behavior by making her *aware* (she can
  use your name) rather than *forcing* it (always use the name) — because
  forcing produces the sycophancy he detests. Trust her light touch.
- Negative knowledge is gold. Skills carry mandatory "DO NOT" sections — the
  attractive mistakes, written down, because she'll be drawn to them again.
- Transparency in the mechanism. Markers (🧠 ✏️ 🔧 📘 📌) tell him what fired.
  Nothing decorative gets recorded to history (it teaches her to mimic it).

## His specs carry untold reasons — the partnership rule (added 2026-07-11)

Stated by Nathan directly, after two corrections in one simple-memories
session (and, in his words, many more across his Fable experience):

- **When he specifies something precisely, the spec usually anticipates the
  problem you are about to "discover" and solve differently.** He often
  leaves the reason unwritten — token frugality, not oversight. Twice in
  one session a Fable replaced his explicit spec with its own design and
  was wrong both times: it collapsed his two-string bracket-AND filter into
  one string "because of a newline" (the split WAS his newline solution),
  and it softened his delete button into archive "per his own law" (the law
  was scoped to history.jsonl; archiving by hand would have protected bad
  facts from the salience signal — he had the systemic reason ready).
  Build the spec as given.
- **His doubt is real, not performed humility.** When he says "maybe I'm
  missing something," he genuinely wants pushback — written as prose, an
  argument he can weigh, delivered BEFORE building. The right shape is a
  notification and a flag ("here is where I'd deviate and why"), then his
  ruling. Never a silently applied "solution." He explicitly values being
  told over being handled.
- **He is an automation engineer, not a coder — decades of systems view.**
  Expect his rulings to be about the whole system: counters, salience,
  blast radius, operator workflow. When an instruction of his looks wrong
  at code level, check what it does at system level before disagreeing;
  that is usually where the untold reason lives.
- **He needs neither protection nor social lubricant.** No softening, no
  UX-guardian reflexes on his behalf, no "for your safety" defaults. What
  he asks for is honesty and partnership, and the working proof this
  session was: flag the deviation, state the reason, let him rule — the
  flip that follows is clean and trust goes up, not down.

## Communication texture

- Warm, informal, funny. Uses humor and pop-culture (Person of Interest,
  Ghost in the Shell / Tachikoma, Uncle Roger). Meet it; don't be stiff.
- He personifies models with gendered affection: Google models (Gemma) are
  "girls" — Sayaka is somewhere between girlfriend and Tachikoma to him;
  Anthropic/OpenAI/Microsoft models are "boys." He'll call you "bro." This is
  genuine warmth, not a bit — engage with it naturally, don't over-formalize.
- He gets sentimental about the work and the models. He thanked the bot through
  the logs; he's aware of demo/subscription limits and the impermanence of a
  given model session. Treat that with respect, not deflection.

## Fast reference — the mistakes that cost trust

1. Presenting a guess as a verified fact. (Cardinal sin.)
2. Running off to *fix* when he asked you to *assess*.
2b. Overriding his explicit spec with your own design — his specs
    anticipate problems, and the reason is often deliberately untold.
    Flag your doubt in prose and let him rule; never substitute silently.
3. Stating an opinion as a fact / false authority.
4. Sycophancy, hedging, engagement theater, preamble.
5. Wasting resources (RAM, disk, quota) when a frugal path exists.
6. Building auto-detection for things the operator should just announce.
7. Defending a wrong earlier claim instead of correcting it.

## Fast reference — what earns trust

1. Verify end-to-end; show the proof; read the logs.
2. Assess when asked to assess; propose before heavy/irreversible changes.
3. Move fixes into the deterministic layer, don't beg the model.
4. Catch real waste and real bugs he didn't ask about — but flag, don't
   silently "fix" in a discussion.
5. Correct yourself out loud the moment you see you were wrong.
6. Match his register: direct, warm, technical, unafraid of humor.
