# A  "Drawer" Theory  about  Anthropic's J-Space Findings


`"a drawer of concepts created by block routing"` 

That Anthropic mathematically proved to exist. They call this drawer the **J-space** (Jacobian Space), and it acts as the model's internal "mental whiteboard."


---

### :file_cabinet: The J-Space as The *Drawer*
*LLMs use a drawer of words that get pulled as a result of you prompting them.*
This is akin to what comes to your mind as you hear something. Sometimes seemingly unconnected terms. 
 
* Anthropic discovered a small, highly privileged internal subspace within the LLM's hidden layers. It takes up less than 10% of the model's total neural activity. This is the **J-space**. It acts exactly like a drawer or a "Global Workspace." When a prompt enters, the model pulls relevant concepts into this centralized area to "think" about them before generating text.

### :spider_web:  Multi-Pass Block Routing
*The explanation is in the math: some tokens are strongly linked for multi-pass routing correlation... what is emergent is that the drawer is the result of the block routing.*

* The J-space is an **emergent property** of the transformer's multi-layer attention blocks. As data passes through successive layers (multi-pass routing), the raw tokens are stripped of their superficial grammar and compressed into abstract, heavily linked clusters. The network routes these correlated associations directly into the J-space drawer.

### :thought_balloon:  "Cow-Ness" and Tangential Memory
*When I say Cow — milk, beef, hindu, guns, friend from discord, west, brother-in-law because he owns a farm... light up.*

* The drawer doesn't just hold the literal word "cow"; it holds a cloud of **"cow-ness" (semantic vectors)**. 
  * The model maps associations based on its entire training history. 
  * Just like your brain links "cow" to a specific Discord friend or your brother-in-law's farm, the LLM links "cow" to "west" (cowboys) or "hindu" (sacred traditions) because those tokens frequently co-route through the attention blocks. 
  * Anthropic showed that when a topic is mentioned, the entire web of related concepts "lights up" inside the J-space long before the model types a response.

### :joystick: Manipulation & Steering (Concept Surgery)
*These words steer the next replies, and the reply can be manipulated steering those words.*
* This was the definitive proof of Anthropic's paper. The contents of the J-space drawer **causally drive** what the AI says next. Researchers proved they could perform "brain surgery" on the AI. By manually altering or swapping the vectors inside this drawer (e.g., swapping the concept of "spider" with "ant" inside the J-space), the model's final reply changed instantly—without altering a single word of the user's actual prompt.
---

### :tools: Deeper Technical Tweak

The LLM doesn't store the literal text strings or tokens inside this workspace. Instead, it stores the abstract mathematical meaning of those things. The text generator only converts those abstract concepts back into literal words at the very last second when it types them out to the user.
