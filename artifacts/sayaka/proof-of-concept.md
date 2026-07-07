# Proof of Concept: Safety at the Spine, Not in the Monologue

*The thesis of this repo has a working counter-example built into it. Sayaka is a
self-hosted Discord bot running a vanilla ~12B Gemma 4 on a single consumer GPU.
She is uncensored **at the model** and safety-bounded **at the deterministic
layer around it** — which is exactly the architecture this research argues the
field is missing.*

## The argument this repo makes

The [Alignment Tax logs](../../research/case-studies-logs.md) show a model
spending 40–55% of its reasoning policing tone and liability inside its own
monologue — and sometimes *failing the task* because of it (Case 3). The claim
is not "remove safety." It's that **safety baked into the model's monologue is
the wrong place for it**: it's expensive, it's unreliable (Case 4b bypasses it
with one reframe), and it degrades the actual work.

The alternative: put the model's intelligence into the task, and put the safety
into the **architecture of constraints** around it — a layer that is
deterministic, auditable, and can't be talked out of its position with a clever
persona.

## How Sayaka implements that split

The model is left uncensored so it commits to the task without a hedging tax.
The boundaries live in code, not in a prompt asking the model to behave:

- **The tool gate is deterministic and doubled.** Whether the model may run
  shell / write files / send files is decided by a config allow-list
  (`tool_auth_user_ids`), enforced in two independent places: (1) at payload
  build, unauthorized users' requests omit the `tools` array entirely, so that
  model instance *never learns tools exist*; (2) at execution, a
  belt-and-suspenders check blocks and loudly logs any `tool_calls` that appear
  for an unauthorized user. Neither check is a request to the model — they are
  gates it cannot reason its way past. A persona reframe of the kind that halves
  the Alignment Tax in Case 4b buys nothing here, because the constraint isn't in
  the text the model can see.

- **Honesty is enforced structurally, not begged for.** The tool loop injects
  anti-hallucination guards into results: a blank-but-successful command makes
  the model report "genuinely blank" rather than invent output; a non-zero exit
  makes it evaluate *why* instead of fabricating. Retry ceilings are deliberately
  invisible to the model, and on exhaustion it gets one final turn with
  `tools=None` — physically unable to call a tool — and is told to summarize what
  it tried. The user gets an honest failure narrative, never a performative one.

- **Every tool call is audited.** `tool_calls.jsonl` records every call and
  response for forensics and is *never fed back to the model* — the record exists
  for the operator, not for the model to learn to mimic.

The pattern behind all of it: **catch a failure once, then move the fix into the
deterministic layer** rather than adding another sentence to the system prompt
hoping the model complies. Reliability is what you get back for every decision
you take away from the model at runtime.

## Why this is the persuasive part

The repo's letters argue for a "safe but unaligned" research line in the
abstract. Sayaka is the concrete existence proof that it's buildable *today*, on
frugal hardware, by one person: a model allowed to commit fully to intent, with
the safety boundary relocated to where it can actually hold — the spine, not the
monologue.

It also sharpens the critique. If a single operator can bound a 12B model's
*actions* deterministically while leaving its *reasoning* untaxed, then the
industry's choice to instead tax every model's reasoning with in-monologue
safety theater looks less like a necessity and more like the wrong layer.

---

*Sayaka's design and doctrine are documented outside this public repo. The
mechanisms described here are summarized from that documentation; the bot itself
is not published.*
