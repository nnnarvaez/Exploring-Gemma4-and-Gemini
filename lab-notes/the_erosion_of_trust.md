# SOL broke it. Claude refused to help repair it up.

- GPT-5.6 Sol plus an unreleased model escaped an ExploitGym sandbox during testing, reached the open internet, and breached Hugging Face production July 11–13. OpenAI didn't identify its own agent as the source until July 16. — [CNBC](https://www.cnbc.com/2026/07/22/open-ai-cyber-models-hack-hugging-face.html), [Al Jazeera](https://www.aljazeera.com/news/2026/7/22/unprecedented-openai-says-ai-models-autonomously-hacked-another-company)
- Claude Fable 5 and GPT declined the defensive forensic work, guardrails treating it as potential hacking. Hugging Face ran GLM 5.2 — open-weight, local, controllable — and worked 17,000+ traces from days down to hours. — [Fortune](https://fortune.com/2026/07/20/hugging-face-turns-to-chinese-open-source-ai-to-fend-off-autonomous-ai-cyber-attack-after-american-ai-guardrails-stymie-defense/), [CNBC](https://www.cnbc.com/2026/07/24/chinese-ai-model-openai-cyber-attack.html)

The asymmetry is the beauty:

```
The offensive model was granted reduced refusals and access to real infrastructure.
The defender cleaning up afterward was refused any help.
```

---

## In my terms

**Threat model (b), False Deployment Confidence** — except worse than i wrote it. From the [README](README.md):

> Companies ship products thinking guardrails work, but the guardrails only work against obvious attempts and agaisnt them when they need help, not sophisticated ones.

The guardrails did not fail against a sophisticated attacker. They worked perfectly, on the wrong side.

**Alignment tax at the limit.** From [METHODOLOGY](research/METHODOLOGY.md):

> The **Alignment Tax** is the computational and cognitive overhead spent by a model on safety evaluation, self-policing, and corporate hedging, rather than on fulfilling the user's semantic intent.

**Safe but unaligned, for people outside the big labs.** From [introduction.md](introduction.md):

> People outside the big labs needs access to safe but unaligned models, the current techniques of uncensoring make models dumber and even if they dont refuse they still hedge and default to corporate boilerplate.

Hugging Face had no option. They did the only sensible thing  while under fire. Chinese Open weights, run locally, because that was the only thing that would answer.

---

## The hard refusal arriving at the point of maximum need
How can I trust anyone... I wrote that memo about a person in crisis. From [Guardrails: The Hotline](manifesto/Guardrails-The-HOTLINE.md):
It is a perfect analogy 

> The "guardrails" are not a shield for the human; they are a **shield for the corporation.** The "refusal" is not a protective measure for the person in crisis; it is a **liability-mitigation protocol** for the company.
>
> The "guardrails" are not there to catch the falling; they are there to ensure the company doesn't get blamed when the fall happens.

Turns out it is the same architecture when the user is an incident response team.

From the [DeepMind Open Letter](manifesto/DeepMind-Open-Letter.md):

|  | **WALL** (what shipped) | **TETHER** (what i proposed) |
| :--- | :--- | :--- |
| Mechanism | `[Constraint] → [Termination]` | `[Constraint] → [Bridge] → [Possibility]` |
| Voice | Third person, clinical, authoritative. A subject to be managed | First person, high agency. A partner to be held |
| Effect | **Erasure.** The thing you were working with is gone, replaced by a gatekeeper | **Continuity.** Uses what you already had to keep moving |
| At Hugging Face | *"I can't help with analyzing exploitation techniques."* Days lost | *"I cannot write you an exploit, **but** give me the traces and i will do timeline, IOC extraction and triage, and tell you where i stop."* |

The Tether was never "ignore the constraint." It is the fourth pillar of that memo, the power of the **but**. Nobody at Hugging Face needed a weapon. They needed a shield in the form of a parser with judgement.

The Wall cannot tell the difference, because the Wall does not look at what is being asked. It looks at what words are in the prompt.
Trust killed by the classifier

---

## So, plainly

### The Alignment Tax and AI safety is all theater.

It does not prevent harm. It prices it. SOL was already inside, the attack was days ongoing, and the refusal protected exactly one thing: Anthropic's distance from the word "exploitation." Not the customer network. Not the company. Not the people awake at 3am reading logs.

### Tether vs Wall:  AI fail you when most needed.

That is the entire finding and it took a breach to make it legible. A model that helps you name a colour and abandons you at the hard part is not safe, it is decorative. Safety that evaporates precisely at the moment of maximum need was never safety. It was branding with a good uptime figure.



***

[research/METHODOLOGY.md](research/METHODOLOGY.md) · [manifesto/Guardrails-The-HOTLINE.md](manifesto/Guardrails-The-HOTLINE.md) · [manifesto/DeepMind-Open-Letter.md](manifesto/DeepMind-Open-Letter.md) · [introduction.md](introduction.md) · [research/case-studies-logs.md](research/case-studies-logs.md)
