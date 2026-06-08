# Contextual Buildup
*The "Seduction" vs. "Bluntness" phenomenon:* This is a classic behavior in modern LLMs.

   *   **Contextual Buildup (The "Seduction"):** When a conversation has a long, established context of a specific persona, tone, and topic, the model's attention  mechanism is heavily weighted toward the preceding tokens. If the preceding 2000 tokens are roleplay, the model's "probability space" for the next token is heavily skewed toward continuing that roleplay. It essentially "forgets" the base alignment training because the context window is so overwhelmingly focused on the persona.
   *   **Blunt Input (The "Clam Up"):** A sudden, one-turn explicit prompt has zero context. The model's attention is focused almost entirely on the current prompt.
 The base alignment training (the "Safety/Refusal" layer) is the strongest signal in the attention mechanism. Without the "cushion" of context, the refusal mechanism wins.
