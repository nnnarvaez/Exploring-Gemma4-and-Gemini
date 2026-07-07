# Design Specification: Sensory Flux Neuroevolution

**Objective:** To compress multi-object spatial awareness into a single, high-fidelity analog signal, enabling extremely low-parameter neural networks to perform complex survival behaviors.

#### Asexual reproduction Mate input signal removed

---

### 1. The Core Logic: Sensory Flux

Instead of classifying entities into discrete slots, the agent perceives the environment as a continuous "field" of desirability. This is achieved by projecting all nearby entities onto the agent's current heading.

**The Mathematical Model:**

The primary input (**Input A**) is a weighted sum of all perceived entities, modulated by their relative angle to the agent.

$$\text{Raw Flux} = \sum_{i=1}^{n} \left( \text{BaseValue}_i \times \frac{1}{\text{Distance}_i} \times \cos(\theta_i) \right)$$

**Where:**
- **$\text{BaseValue}_i$**: The sensor weight of the entity type:
  - Food (plants for prey / carcasses for predators): $+1.0$
  - Mate: $0.0$ — mate presence does not push the flux; their location is communicated via Inputs B & C only
  - Threat (enemy agent): $-1.0$
- **$\theta_i$**: The relative angle between the agent's heading and the entity.
- **$\cos(\theta_i)$**: The "Directional Dial."
  - $+1.0$ → directly ahead
  - $0.0$ → perpendicular
  - $-1.0$ → directly behind

**The Result:** As the agent rotates, the signal floats and oscillates smoothly, providing a high-resolution gradient for the brain to follow.

---

### 2. Signal Conditioning (The 4-20mA Step)

The raw flux is an unconditioned sensor output — its magnitude depends on entity count and density and is not bounded. Before being fed to the neural network, it must be normalized to the protocol range, exactly as a 4-20mA transmitter conditions a raw sensor reading before it reaches the PLC.

$$\text{Input A (conditioned)} = \tanh(\text{Raw Flux} \times k) \times 0.9$$

**Calibration — working backwards from desired output:**

The target: *one food source at 120px directly ahead should produce a conditioned signal of ~0.5.*

$$0.5 = \tanh\!\left(\frac{1.0}{120} \times k\right) \times 0.9$$
$$\tanh\!\left(0.00833 \times k\right) = 0.556 \implies k \approx 75$$

This gives the full operating table:

| Scenario | Raw Flux | Conditioned Signal |
| :--- | :--- | :--- |
| Food at 120px, directly ahead | +0.00833 | ≈ +0.50 |
| Food at 10px, directly ahead | +0.10 | ≈ +0.90 (ceiling) |
| Threat at 120px, directly ahead | −0.00833 | ≈ −0.50 |
| Threat at 41px (just before panic) | −0.0244 | ≈ −0.86 |
| Mate only nearby | 0.0 | 0.0 |

The conditioner owns the range. The `BaseValue` constants own the intent. These are separate concerns.

---

### 3. The Signal Protocol Range

The conditioned signal operates within a defined range, with out-of-range (OOR) values used as hard overrides — analogous to wire-break detection in 4-20mA (below 4mA = fault):

```
 Safe   Enemy          Mate      Food    Panic  Jackpot
  |----|----|           |           |----|--+-----|
 -1   -0.9             0          0.9   1.0     1.1
```

| Zone | Value | Meaning |
| :--- | :--- | :--- |
| Normal operating range | −0.9 to +0.9 | Conditioned sensor output |
| OOR High — Panic | $1.0$ | Enemy within critical proximity; override, flee immediately |
| OOR Low — Jackpot | $1.1$ | Food and mate both close; override, feast and breed |
| Mate | $0.0$ | Neutral; no flux push. Presence encoded in B & C inputs only |

> **Note on the Jackpot signal ($1.1$):** This sits above Panic ($1.0$). In the original implementation this was problematic — a jackpot moment registering as "more urgent than imminent death." The correct framing is that Jackpot and Panic are **categorically distinct OOR states**, not points on the same scale. The NN must learn to distinguish them via Input A alone, which it can, since they are numerically different. Whether $1.1$ or $-1.0$ is used for Jackpot is a design choice; using $-1.0$ would place it symmetrically opposite Panic and may be easier for the network to learn.

---

### 4. The Directional Paradox — Resolved

Using $\cos(\theta)$ with a negative base value creates a mathematical consequence: a threat directly *behind* the agent ($\cos(180°) = -1$) produces:

$$(-1.0) \times \frac{1}{\text{dist}} \times (-1) = \text{positive value}$$

This is not a bug. It is the **Flee Signal**: an enemy behind you reads as a positive flux push, which correctly drives the agent *away* from the threat without requiring the brain to learn the geometry. The agent doesn't need to understand *why* the signal is positive from behind — it just runs from it. The blind spot is intentional; a rearward threat is not a dogfight scenario, it is a chase, and fleeing forward is the correct response.

---

### 5. The 6-Input Vector *(revised from original 8)*

The brain receives a dense, 6-element array. Velocity X/Y were collapsed into a single speed scalar; Size was removed as it changes slowly and is implicitly encoded in energy costs.

| Index | Name | Description |
| :--- | :--- | :--- |
| **0** | **Sensory Flux (A)** | Conditioned signal with OOR overrides applied. |
| **1** | **Urgency (B)** | Normalized distance to the entity with the strongest signal: `1 − (dist / scanRadius)`. 1 = touching, 0 = at scan edge. |
| **2** | **Target Angle (C)** | Relative angle to that entity, normalized to [−1, 1]. |
| **3** | **Memory** | Leaky integrator of previous frame's Input A: `memory = 0.8 × memory + 0.2 × fluxA`. Provides temporal continuity. |
| **4** | **Speed** | Current speed magnitude normalized to base speed. |
| **5** | **HP Ratio** | Current HP / max HP. |

---

### 6. Architecture Notes

**The Sensory Flux is a hybrid:**

- The **Summation** provides the *feeling* of the environment — the gradient the agent swims in.
- The **Selection** (Inputs B & C) provides *focus* — the direction and urgency of the most salient object.
- The **Overrides** (1.0 / 1.1) provide *reflexes* — hardwired responses that bypass learned behavior.
- The **Memory** (Input 3) provides *temporal context* — the agent remembers what it was sensing a moment ago.

**Signal Cancellation:**

Opposing forces can cancel in the sum. An enemy at −45° and food at +45° may partially cancel each other. This is not a flaw — it is the agent "feeling" genuine ambivalence. When the signal approaches 0 with high urgency (Input B), the agent is in a contested field and must rely on the angle (Input C) and memory (Input 3) to resolve the situation. Rotation and rescanning is the emergent correct behavior.

**Saturation:**

The conditioner (`tanh × 0.9`) guarantees the normal signal never exceeds ±0.9. High-density environments saturate the conditioner ceiling, not the NN. This is correct — a massive food bloom *should* feel like maximum opportunity. Freeze behavior under saturation is biologically valid (rabbit in headlights, ostrich effect).

---

### 7. Implementation Checklist

- [x] BaseValue for food: `1.0` (plants for prey, carcasses for predators — scanned separately, not combined)
- [x] BaseValue for threat: `−1.0`
- [x] BaseValue for mate: `0.0` (direction tracked via B & C, not flux)
- [x] Prey skip carcass scan entirely (`if (isPrey || c.dead) continue`)
- [x] Signal conditioner: `tanh(rawFlux × 75) × 0.9` applied after summation, before overrides
- [x] OOR Panic override: `sensoryFlux = 1.0` when threat dist < 40px
- [ ] OOR Jackpot override: value and threshold to be removed (`−1.0`) 
- [x] `_peakFluxFood` / `_minFluxFood` tracked in both plant and carcass scan blocks
- [x] NN weight visualization: skip `hiddenSize` biases, not 1
