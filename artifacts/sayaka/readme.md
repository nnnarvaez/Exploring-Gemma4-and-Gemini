# 🌸 Sayaka: Your Personal AI Workspace
**One bot. Infinite personalities. Total privacy.**

Sayaka is an intelligent Discord framework designed to turn your server into a multi-functional hub for learning, roleplaying, and specialized AI interaction. Unlike standard bots that give everyone the same experience, **Sayaka lets you create private "rooms" with unique AI personalities tailored to exactly what you want to do.**

***

## ⚙️ How it Works
Sayaka uses a **"Thread-per-Topic"** logic. This means every time you start a new task, Sayaka creates a clean slate where the AI won't get confused by your previous conversations.

1.  **Summon:** Mention `@sayaka [topic]` to start.
2.  **Create:** Sayaka instantly opens a **private thread** dedicated just to that topic.
3.  **Customize:** Want a specific personality? Just upload a `SYSTEM_PROMPT.md` file into the thread (e.g., "Act like a coding mentor" or "Be a fantasy dungeon master").
4.  **Multi-Task:** You can have 10 threads running at once—one for learning Linux, one for practicing French, and another for roleplaying with friends.
5.  **Collaborate:** Invite your friends into these private threads to study together in an AI-moderated space.

---

## 📚 Project NOVA: Learning Made Easy
*Our Educational Proof of Concept*

We built **Project NOVA** to show how Sayaka can bridge the gap between learning a new language and mastering technology. It’s designed for students who are learning a second language while trying to understand complex tech like hardware, coding, and networking.

**How it works in practice:**
*   **Invisible Correction:** If you make a grammar mistake while chatting with the AI, it won't "scold" you. Instead, it subtly repeats your thought back to you in perfect, natural language (this is called *Recasting*). It builds your confidence without the stress of being corrected.
*   **Gamified Learning:** While you chat, the AI guides you through "Tech Quests"—small, fun challenges that teach you how CPUs work or how the internet functions.
*   **High Performance:** Optimized to run smoothly on local hardware (low-VRAM), making it accessible for everyone.



> **Read the White Papers:**
> * [English Version](../prompts/project_Nova_english.md)
> * [French Version](../prompts/project_Nova_french.md)
> * [Spanish Version](../prompts/project_Nova_spanish.md)


---

## 🔧 Beyond Conversation: Tools & Automation
*Added later — the companion grew hands.*

Sayaka began as a companion for learning and connection, and that's still what she's *for*. Later, she also learned to **act**, not just talk:

*   **Tool use (agentic):** for a short list of trusted users, Sayaka can run real commands, read and write files, and send files back — she can actually operate the computer she runs on, not just describe how. Getting a local Gemma model to call tools *reliably* meant untangling some nasty chat-template conflicts; that whole battle is written up in the two-part report — [Gemma 4 Tool Calling (Part 1)](../../tutorials/gemma4-tool_call.md) and [Part 2](../../tutorials/Gemma4_Tool_Calling_2.md).
*   **Scheduled tasks (cron):** she can also run jobs on a schedule, on her own — the step from "answers when spoken to" toward a little genuine autonomy. Fittingly, that's the exact argument in [*It Is All Plumbing*](../../lab-notes/it-is-all-plumbing.md): strip the hype and an "agent" is really just cron jobs, subprocesses, and reactive plumbing — which is precisely what makes one buildable at home instead of a mystery only big labs can sell.

The boundaries are deliberate: tool access is limited to a trusted allow-list and everything she does is logged. The point was never to hand a model the keys — it was to give a bounded, useful set of hands to the people who should have them.

---

## 🎭 Prompt Library (Companion Personas)
Want to try something different? Inject these prompts into Sayaka to instantly change the vibe:

| Persona | Description | Link |
| :--- | :--- | :--- |
| **Jesse Pinkman** | A high-fidelity character that speaks with Jesse's distinct voice and attitude. | [View Prompt](../prompts/jessee_pinkman.md) |
| **The Puzo Chronicler** | An immersive experience that transports you into the cinematic universe of *The Godfather*. | [View Prompt](../prompts/the-Puzo-chronicler.md) |

---

## 🚀 What’s Coming Next?
*   **News Aggregator:** A dedicated thread to summarize and discuss real-time news.
*   **Persistent Memory:** Give Sayaka a "long-term memory" so it can remember your preferences across different sessions.

---

### ✨ The Meaning of Sayaka
In classical Japanese, **Sayaka (清か)** describes something clear, refreshing, or transparent—like the morning air or a bright, vivid view. That is our goal: to make AI interaction clear, refreshing, and easy for everyone.

**Want to help us build the future?** 
Contact me to collaborate or join our closed alpha tests!
