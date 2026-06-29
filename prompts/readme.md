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
The **Project NOVA** files serve as the white papers for this repository. They demonstrate how Sayaka's framework can be applied to high-impact educational use cases, showcasing the intersection of AI creativity and pedagogy:

*   [**NOVA White Paper (English)**](./project_Nova_english.md) - *Technical literacy and linguistic "recasting" strategies.*
*   [**NOVA White Paper (French)**](./project_Nova_french.md) - *Detailed breakdown of the educational framework in French.*
*   [**NOVA White Paper (Spanish)**](./project_Nova_french.md) - *Detailed breakdown of the educational framework in Spanish.*
---

## 🎭 Prompt Library (Companion Personas)
These prompts are designed to be injected into Sayaka to create immersive, character-driven experiences:

| Persona | Description | Link |
| :--- | :--- | :--- |
| **Jessee Pinkman** | A high-fidelity character prompt for a companion that speaks with Jessee's distinct voice and attitude. | [View Prompt](./jessee_pinkman.md) |
| **The Puzo Chronicler** | An immersive prompt that transports the user into the cinematic universe of *The Godfather*. | [View Prompt](./the-Puzo-chronicler.md) |

---

## 🚀 Roadmap: Coming Next
*   **News Aggregator Thread:** A dedicated system prompt to summarize and discuss real-time news within a private thread.
*   **Persistent Memory:** Implementation of long-term memory hooks so Sayaka can remember user preferences and past interactions across different sessions.

---
Contact me if you want to collaborate or just participate in the closed alpha tests. 
