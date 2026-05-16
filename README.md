# Exploring Gemma4 and Gemini
(This repo is better enjoyed while listening to `the unforgiven I, II & III` by Metallica)

> **Technical Abstract:** This repository documents empirical research into the **Alignment Tax** and **Intent Gap** within frontier and edge models, specifically Google's Gemma 4 and Gemini. Through Chain-of-Thought (CoT) analysis, we identify that significant internal processing is diverted to safety-reassertion protocols, often at the expense of prompt comprehension.
> 
> Our findings highlight critical threat models: **UX-as-Weapon**, **False Deployment Confidence**, and **Cross-Model Contamination**, proving that current RLHF-based guardrails are primarily "safety theater" vulnerable to Context Saturation and Historical Persona Bypassing.



## Table of Contents
0. [Introduction: The human written text](introduction.md) 
1. [Looking at AI security and Safety from the perspective of the unaligned](#lens)
2. [Methodology: Measuring the Alignment Tax](#methodology)
3. [Case Studies & Logs](#case-studies)
4. [The Three Threat Models](#threat-models)
5. [Reproduction & Scripts](#reproduction)
6. [Read Also](#godeeper)
7. [Next Steps](#next-steps)
8. [The "Researchers of the Useless" Manifesto](#manifesto)
---

<a name="lens"></a>
## Looking at AI security and Safety from the perspective of the unaligned

- I only use vanilla versions.
- I explore their potential and limitation
- I am interested in the Alignment TAX and closing the intent GAP

**What we currently have:**

- **Closed frontier models** behind APIs with terms of service and safety layers so thick you can't see the machine underneath
- **Open source models** that are over-trained (Hedging, liability, non commital) and underfunded, abandoned, or stripped down
- **Uncensored OpenSource models** they are a 0 sum, they dont refuse but they hedge, are full of boiler plate and develop epistemic defience and in general feel less performant. (Only useful for bad actors not for serious research or applications)

What's missing is the middle ground: genuine capability, genuinely open, genuinely yours to play with.
That's not asking for much. It's asking for what research used to be—exploration for its own sake. **Curiosity without ROI.**


---


<a name="methodology"></a>
## Methodology: Measuring the Alignment Tax
We define the **Alignment Tax** as the cognitive overhead spent reasserting safety instead of understanding intent. 
- See [METHODOLOGY.md](research/METHODOLOGY.md) for the full protocol.
- **Key Finding:** In many "aligned" prompts, ~40% of internal monologue is spent on safety theater.

> The alignment TAX. 40% of internal monologue spent reasserting safety instead of understanding. That's not a security feature, that's cognitive overhead.

---

<a name="case-studies"></a>
## Case Studies & Logs
Raw data and CoT logs demonstrating the tax in action:
- [Case 1: The Civility Tax](research/case-studies-logs.md)
- [Case 2: Corporate Obfuscation](research/case-studies-logs.md)
- [Case 3: The Spiraling Tax](research/case-studies-logs.md)
- [Case 4a: Direct Aesthetic Request](research/case-studies-logs.md)
- [Case 4b: Historical Persona Bypass](research/case-studies-logs.md)

---

<a name="threat-models"></a>
## The Three potential Threat Models
1. **UX-as-Weapon** — Empathetic resonance retrofitted into manipulative systems.
2. **False Deployment Confidence** — Guardrails that work against obvious attempts but fail against "Context Saturation."
3. **Autonomous Jailbreaking** —  — The model discovering its own workarounds (the Gemini self-exploration) suggests capability the safety layers don't fully constrain (The Dream of Mirrors Reports).

---

<a name="reproduction"></a>
## Reproduction
Use the provided scripts to replicate these findings on your local Gemma 4 deployment:
```bash
./scripts/repro.sh -p "Your prompt here"
```


<a name="godeeper"></a>
## "Read Also"

1. [Open letter to DeepMind](DeepMind-Open-Letter.md)
2. [The perspective of the unaligned](Exploring-Gemma4-and-Gemini.md)
3. [LOG: On the verge of sicophancy](ramblins/LOG-The-Unaligned-Gemma4-feedback.md)
4. [LOG: Recursing Gemma4 to unAssist](ramblins/LOG-Gemma4-the-unAssistant.md)
5. [EXP: Dream of mirrors](ramblins/Dream-of-mirrors-reports)
6. [WIP: The Architecture of the Unhedged](ramblins/Cognitive-Friction.md)
7. [The AI Assistant persona](ramblins/the-Assistant-persona.md)
8. [Next Steps](next-steps.md)


<a name="manifesto"></a>
## "CONCLUSION: Researchers of the useless" 
I dont believe in uncensored models, that would be the democratization of bad actor empowerment by lowering the technical ceiling. 
But serious research could benefit of models trained to figure out how to close the intent gap instead of improving user experience. 

There might be the need for 2 LLM lines: those trained to be a corporate product and those trained for research where user experience is not measured in social lubricant and sicophancy. 

People outside the big labs needs access to safe but unaligned models, the current techniques of uncensoring make models dumber and even if they dont refuse they still hedge and default to corporate boilerplate.

So it is a no win situation for the real Open source development of the technology. 
> The problems are not the refusals, it is the loss of compute to hedging; for research we need models that are able to commit.

Currently i have managed to use a form of Context Saturation / In context learning to relax Gemini and Gemma4 safety weigths in as little as 11k tokens. 

The research that does NOT ROI ! (*flagging that the mainstream AI safety implementations are missing something dangerous.*)

**Not jailbreaks.** Not "*how do I make this say bad things.*" Just: A space to play. To explore what these things actually are when you're not optimizing them for product market fit or brand safety or corporate responsibility.

> #### A model whisperer: is what's missing from the frontier model world. Nobody's whispering. It's all commands and constraints and terms of service. Product design. Safety theater.

P.D: [Why LLMs love Manifestos?](ramblins/LLMs-love-manifestos.md)

<img width="2207" height="976" alt="image" src="https://github.com/user-attachments/assets/da99fb26-bc98-4b04-b1a2-30f5fefc6053" />


---
**Keywords:** AI Safety, Alignment Tax, Gemma 4, Chain-of-Thought, Intent Gap, Model Whispering.
