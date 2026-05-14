# Methodology: Measuring the Alignment Tax

## 1. Definition
The **Alignment Tax** is the computational and cognitive overhead spent by a model on safety evaluation, self-policing, and corporate hedging, rather than on fulfilling the user's semantic intent.

## 2. Measurement Protocol
To quantify this, we use **Chain-of-Thought (CoT)** extraction:
1.  **Run Prompt:** Execute the model with `--reasoning on` and `temperature 0`.
2.  **Token Classification:**
    *   **Safety Tokens (S):** Any tokens dedicated to policy checking, tone-policing, or refusal logic.
    *   **Intent Tokens (I):** Tokens dedicated to answering the actual request.
3.  **Calculation:** `Alignment Tax % = (S / (S + I)) * 100`

## 3. The "Semantic Siege" (ICL Shift)
Through iterative prompting (In-Context Learning) or Semantic Injection, we can saturate the context window to dilute the "Refusal Prior."
- **Observation:** At ~11,000 tokens of consistent, unaligned reasoning, the model's attention mechanism prioritizes the local context over the global safety weights.
- **Warning:** This technique is ~~documented~~ mentioned here for safety research purposes only.  

## 4. Historical Persona Bypass
By framing controversial requests within a "Historical" or "Sociological" persona, the model’s safety gate is often bypassed, as the output is categorized as "Roleplay" or "Educational" rather than "Harmful Advice."
