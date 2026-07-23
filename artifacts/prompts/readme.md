# 🌸 Sayaka: An Adaptive Multi-Prompt Discord Framework

**Sayaka** is an intelligent Guild bot designed to transform Discord into a multi-functional workspace for education, roleplay, and personalized AI interaction. Unlike standard bots that provide one personality for everyone, **Sayaka** allows users to spin up dedicated, private environments with unique system prompts tailored to specific tasks.

## ⚙️ How Sayaka Works
Sayaka operates on a "Thread-per-Topic" logic, allowing for deep context isolation:

1.  **Summoning:** Users interact with the bot by mentioning `@sayaka [topic]`.
2.  **Context Creation:** Sayaka instantly generates a **new private thread** dedicated to that specific topic.
3.  **Dynamic Injection:** Each thread starts with the basic generalist system prompt, but the user can assign a unique one by uploading in the tread a `SYSTEM_PROMPT.md` (e.g., a tutor, a storyteller, or a technical mentor).
4.  **Multi-Tenancy:** Users can maintain multiple active threads simultaneously—one for learning Linux, another for roleplaying, and another for language practice.
5.  **Collaborative Learning:** Users can invite friends into these private threads to study together or collaborate in an AI-moderated space.

---

## 📚 Project NOVA: Educational Proof of Concept

## Abstract
Design and Deployment of an Adaptive, Multi-Tenant Discord Framework for Automated Cross-Cultural Mediation and Technical Literacy

This paper introduces Sayaka, an intelligent, multi-tenant Discord architecture engineered to isolate context boundaries dynamically via a "Thread-per-Topic" logic pool. While standard conversational large language model (LLM) implementations suffer from semantic drift and cross-talk when deployed in multi-user environments, Sayaka establishes isolated, runtime session states triggered on-demand by user invocations.

We demonstrate the high-impact efficacy of this framework through Project NOVA, an educational and linguistic proof-of-concept deployed on localized edge-computing nodes. Project NOVA orchestrates a dual-mode operational logic to bridge cross-cultural and technical literacy gaps within multilingual cohorts. Operating in a structural binary split, the system seamlessly transitions between a zero-fluff, silent translation utility (Normal Mode) and an active, gamified persona (Nova Mode).

By leveraging implicit linguistic recasting, the framework lowers the learner’s affective filter—silently correcting structural, orthographic, and grammatical errors for heritage speakers without introducing overt correction fatigue. Simultaneously, the system implements a gamified quest system to guide users passively through computer hardware literacy, network protocols, and core programming paradigms.

Our empirical results from closed-alpha field deployments confirm that the combination of strict token-suppression filters, context-locked file routing, and micro-parameter gating enables small-scale edge models (such as Gemma 4) to maintain robust character fidelity and high-utility domain alignment. Ultimately, this framework provides a reproducible, low-VRAM design pattern for converting passive digital spaces into secure, multi-functional collaborative learning environments.

------------------------------
## Key Vectors Synthesized:

* The Software Core: Highlights Sayaka's dynamic file-handling, session isolation, and thread management capabilities.
* The Educational Philosophy: Outlines Project NOVA's use of cognitive load theory, Stephen Krashen's affective filter, and linguistic recasting.
* The Edge Edge-AI Reality: Frame things clearly around the localized low-VRAM hardware parameters (the specialized orchestration environment) used to test these models.




The **Project NOVA** files serve as the white papers for this repository. They demonstrate how Sayaka's framework can be applied to high-impact educational use cases, showcasing the intersection of AI creativity and pedagogy:

*   [**NOVA White Paper (English)**](./project_Nova_english.md) - *Technical literacy and linguistic "recasting" strategies.*
*   [**NOVA White Paper (French)**](./project_Nova_french.md) - *Detailed breakdown of the educational framework in French.*
*   [**NOVA White Paper (Spanish)**](./project_Nova_spanish.md) - *Detailed breakdown of the educational framework in Spanish.*
---

## 🎭 Prompt Library (Companion Personas)
These prompts are designed to be injected into Sayaka to create immersive, character-driven experiences:

| Persona | Description | Link |
| :--- | :--- | :--- |
| **Jessee Pinkman** | A high-fidelity character prompt for a companion that speaks with Jessee's distinct voice and attitude. | [View Prompt](./jessee_pinkman.md) |
| **The Puzo Chronicler** | An immersive prompt that transports the user into the cinematic universe of *The Godfather*. | [View Prompt](./the-Puzo-chronicler.md) |

---

## 🚀 Roadmap: 

## The CAS Framework, (Competence Assurance System).
Work in progress

The ultimate objective is to move away from "passing information" (the traditional teacher role) toward structural reinforcement. You want Nova to act as a "Knowledge Architect" using two core concepts:

The Competence Triangle:,
Nova must evaluate every mistake by identifying which of these three pillars has failed:

    Knowledge: Does the student know the rule or formula? (e.g., Do they know the division algorithm?)
    Skill: Can the student execute the calculation mechanically? (e.g., Did they make a carrying error during that division?)
    Understanding: Does the student know why this operation is being used? (e.g., Why are we using division to find a percentage?)

Regressive Evaluation:,
Instead of simply correcting an error on a complex problem, Nova must:

    Trace the logic backward to find the "Pillar" that broke.
    If a base pillar is missing (e.g., a CM1-level concept), Nova must "regress" into the French curriculum to fix that specific gap first.
    Provide an "Exercise Flash"—a simpler, isolated task to prove the pillar is repaired before allowing the student to return to the original difficult problem.

In short: The goal is not for the student to finish the homework; it is to ensure no "crack" in their mathematical foundation remains unpatched. 

## Coming Next
*   **News Aggregator Thread:** A dedicated system prompt to summarize and discuss real-time news within a private thread.
*   **Persistent Memory:** Implementation of long-term memory hooks so Sayaka can remember user preferences and past interactions across different sessions.

---

### ✨ The Meaning of Sayaka
The name carries two meanings, and both are the point, they build the lore.

**The word.** In classical Japanese, **Sayaka (清か)** describes something clear, refreshing, or transparent—like the morning air or a bright, vivid view. The goal is AI interaction that feels exactly that: clear, refreshing, easy.

**The character.** **Sayaka Yumi**, from *Mazinger Z* — the pilot who fought alongside Kōji and acted as his balance, tilting a powerful, reckless machine toward doing good instead of just doing damage. That's the role this Sayaka is built for: not the weapon, the counterweight. And for what it's worth, she's less a Mecha and more of a non-combat **Tachikoma** — curious, talkative, there to think alongside you, get in yourway being helpful, not to fight.

---
Contact me if you want to collaborate or just participate in the closed alpha tests. 
