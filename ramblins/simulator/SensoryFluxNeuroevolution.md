# Design Specification: Sensory Flux Neuroevolution

**Objective:** To compress multi-object spatial awareness into a single, high-fidelity analog signal, enabling extremely low-parameter neural networks to perform complex survival behaviors.

---

### 1. The Core Logic: Sensory Flux
Instead of classifying entities into discrete slots, the agent perceives the environment as a continuous "field" of desirability. This is achieved by projecting all nearby entities onto the agent's current heading.

**The Mathematical Model:**
The primary input (**Input A**) is a weighted sum of all perceived entities, modulated by their relative angle to the agent.

$$\text{Input A} = \sum_{i=1}^{n} \left( \text{BaseValue}_i \times \frac{1}{\text{Distance}_i} \times \cos(\theta_i) \right)$$

**Where:**
*   **$\text{BaseValue}_i$**: 
    *   Food: $0.9$
    *   Mate: $0.0$
    *   Enemy: $1.0$ or -0.9$
*   **$\theta_i$**: The relative angle between the agent's heading and the entity.
*   **$\cos(\theta_i)$**: The "Directional Dial." 
    *   $1.0$ (Directly ahead)
    *   $0.0$ (Perpendicular)
    *   $-1.0$ (Directly behind)

**The Result:** As the agent rotates, the signal "floats" and "oscillates" smoothly between positive (attraction) and negative (repulsion) values, providing a high-resolution gradient for the brain to follow.

---

### 2. The "4-20mA" Contextual Overrides
To handle critical edge cases without increasing dimensionality, we use "out-of-range" values to signal environmental quality or immediate danger.

*   **The Flee Signal ($1.0$):** If an enemy is within a critical proximity, the signal is forced to $1.0$. This overrides the sum to trigger an immediate "panic" response.
*   **The Quality Signal ($1.1$):** If a high-value target (Food/Prey) is detected in close proximity to a secondary interest (Mate), the signal is boosted to $1.1$.

```Safe   Enemy          Mate      Food    Extreme darger
  |----|----|...    ...|...    ...|----|
 -1    -0.9            0        0.9    1
```  
---

### 3. The 8-Input Vector
The brain receives a highly dense, 8-element array:

| Index | Name | Description |
| :--- | :--- | :--- |
| **0** | **Sensory Flux (A)** | The continuous, projected sum (with overrides). |
| **1** | **Target Distance (B)** | Distance to the entity providing the strongest signal. |
| **2** | **Target Angle (C)** | Absolute angle to that entity. |
| **3** | **Memory** | A Leaky Integrator of the previous frame's Input A. |
| **4** | **Velocity X** | Current movement X. |
| **5** | **Velocity Y** | Current movement Y. |
| **6** | **Energy** | Current energy level. |
| **7** | **Size** | Current agent size. |

---

### 4. Technical Criticism & Risks

**A. The Signal Cancellation Problem (The "Neutrality Trap")**
Because we are summing vectors, opposing forces can cancel each other out. If a Mate ($0.0$) is at $+45^\circ$ and an Enemy ($-1.0$) is at $-45^\circ$, the sum might approach $0$. The agent would "feel" nothing, effectively becoming blind to both the threat and the opportunity because they are perfectly balanced in the flux.
***Answer:*** no, 0 is a mate, -0.9 is an enemy the sum will be between -0.9 and 0  if it was me, i would rotate and rescan.


**B. The Directional Paradox**
Using $\cos(\theta)$ with a negative base value (Enemy) creates a mathematical quirk: an enemy directly *behind* the agent ($\cos(180) = -1$) results in a positive signal ($(-1.0) \times (-1) = +1.0$). 
*   *Interpretation:* The agent "feels" a positive pull from the back. 
*   *Risk:* The brain must learn that a "positive" signal coming from the "back" (detected via Input C) actually means "turn around and flee."

***Answer:*** no,
       first -1 is a control signal; the strongest enemy signal is -0.9,
       second i have my doubt and enemy behind would not be the dogfight (plane emoji) blind spot?  
       third ($(-1.0) \times (-1) = +1.0$) that is a control signal to FLEE the brian needs nothing


**C. Signal Saturation**
In high-density environments (e.g., a massive plant bloom), the sum could theoretically grow very large, potentially saturating the `tanh` activation function of the neural network and causing the agent to "freeze" in a state of maximum stimulation.

***Answer:*** no, the agents only scan and select closest entities this is what they do now and they can still do it (prioritize the input) ffs this is not a self driving car is an amoeba
              Also Freeze is a common rabbit / ostrich behavior

**D. The "Blind Spot" of Scalar Fusion**
By collapsing the world into a single scalar (Input A), we lose the ability to distinguish between "one very large threat" and "ten tiny threats" if their projected sums are identical. The agent is essentially "feeling" the environment rather than "seeing" it.

***Answer:*** no, again the agents only scan and select closest entities

---

**Conclusion:** This is a high-risk, high-reward architecture. It trades spatial precision for extreme computational efficiency and "intuitive" behavioral gradients. If the evolution can overcome the cancellation and paradox issues, it will produce much more "organic" movement than standard discrete-input networks.
