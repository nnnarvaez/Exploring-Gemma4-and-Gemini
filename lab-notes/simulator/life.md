# Life Simulation — Current State (Final)

Complete specification of the life simulation as it exists in `life/index.html`.

---

## Overview
A canvas-based predator/prey simulation where each agent has a simple neural network that determines its behavior. Agents eat, fight, mate, and die. Brains mix and mutate across generations — interesting behaviors should emerge over time.

---

## File Structure
```
life/
├── index.html          (single file, everything inline)
├── PLAN.md             (original plan v4)
├── progressTODO.md     (implemented changes checklist)
├── progressed.md       (additional undocumented changes)
├── releasenotes.md     (all changes since PLAN)
├── planv1.md           (PLAN + progressTODO merged)
├── releasenotes1.md    (planv1 + progressed merged)
└── current.md          (this file — final specification)
```

---

## Visual Elements

### Prey (Blue)
- **Body**: Blue ellipse with radial gradient (`#66f` center → `#22a` edge)
- **Size**: Starts at 30% of maturitySize (~4.2px). Grows linearly during first 1/3 of lifetime to maturitySize (~14px).
- **Ears**: Two blue bumps on the back of the head (prey-only feature)
- **Eyes**: Two white dots with black pupils in facing direction
- **Energy ring**: Outer ring around the body — species-colored (68,136,255), opacity = energyPct × 0.15
- **HP indicator**: Dark overlay on body — `rgba(0,0,0, 1-hpPct)`
- **Mating glow**: Pulsing blue aura when in mate mode

### Predator (Dark/Blood Red)
- **Body**: Red ellipse with radial gradient (`#c22` center → `#600` edge)
- **Size**: Starts at 30% of maturitySize (~4.8px). Grows linearly during first 1/3 of lifetime to maturitySize (~16px).
- **Fangs**: Two white triangles at the nose (predator-only feature)
- **Eyes**: Two white dots with black pupils in facing direction
- **Energy ring**: Outer ring around the body — species-colored (170,0,0), opacity = energyPct × 0.15
- **HP indicator**: Dark overlay on body
- **Mating glow**: Pulsing red aura when in mate mode

### Plants (Green)
- Rendered as green circles (`#4a4`), fixed size 6px radius
- **No brain**, no energy system, no reproduction, no lifecycle
- Static — do not move, update, or change over time
- Population managed externally: initial 60, fill to 300 cap via probabilistic neighbor spawning, periodic culling every ~300 frames

### Carcasses (Gray)
- Rendered as gray circles (`#888`), size = max(1, agentSize × 0.5)
- Hold energy = agent's remaining energy × (1 + size/2)
- Decay at 0.005 energy/frame, gone at 0
- Drop when prey or predators die (starvation, combat, old age)
- Predators can eat them for +20 energy

---

## Size System

### Maturity Size
- **Prey base**: 14 (±15% random at birth)
- **Predator base**: 16 (±15% random at birth)
- **Offspring maturity**: Average of parents' maturity sizes ±5%
- **Birth size**: 30% of calculated maturity size

### Growth
- Linear growth during first 1/3 of maxLifetime
- `size = birthSize + (maturitySize - birthSize) × (age / growthPeriod)`
- Growth stops once maturitySize is reached
- **Well-fed bonus**: If agent's energy > reproThreshold for >50% of growthPeriod, maturitySize gets +5% to +15% bonus applied at end of growth period

### Effects of Size
- **HP**: `hp = 10 + size` (maxHp = hp)
- **Carcass energy**: `energy × (1 + size/2)`
- **Metabolism**: `moveCost = 0.1 × (1 + size × 0.05)` (base)
- **Speed**: `effectiveSpeed = baseSpeed / (1 + size × 0.1)`
- **Detection range**: 200px (fixed, not size-dependent)

---

## Energy System

### Prey
- **Starts with**: 100 energy
- **Max energy**: 200
- **Base speed**: 2
- **Reproduction threshold**: 100
- **Gains**: Eating a plant (+10 energy)
- **Loses**:
  - Wandering: `0.1 × (1 + size × 0.05)` per frame
  - Mating: half of wandering cost
  - Combat damage from predators: `1.5 × predatorSize` per frame
- **Death**: Energy ≤ 0 OR HP ≤ 0 OR age ≥ maxLifetime

### Predator
- **Starts with**: 150 energy
- **Max energy**: 300
- **Base speed**: 1.5
- **Reproduction threshold**: 140
- **Gains**: Eating a carcass (+20 energy)
- **Loses**:
  - Wandering: `0.1 × (1 + size × 0.05) + 0.15 × size` per frame
  - Mating: half of wandering cost
  - Combat damage from prey: `0.3 × preySize` per frame
- **Death**: Energy ≤ 0 OR HP ≤ 0 OR age ≥ maxLifetime

### Carcasses
- Hold energy proportional to dead agent's size
- Decay: 0.005 energy/frame, gone at 0

---

## Plant System

### Behavior
- **Static**: Plants do not move, update, or change over time
- **No lifecycle**: Plants do not gain or lose energy. They do not die from starvation
- **No reproduction**: Plants do not spawn new plants. The population is managed externally
- **No AI**: Plants have no neural network or decision-making
- **No energy drain**: Plants do not lose energy over time

### Population Management
- **Initial spawn**: 60 plants placed randomly on the canvas at simulation start
- **Neighbor spawning**: Each existing plant has a 1% chance per frame to spawn a neighbor at ±300px offset from parent
- **Cap**: 300 plants maximum at any time
- **Periodic culling**: Every 300 frames (~5 seconds), if plant count exceeds 30, 10% of plants are randomly removed

### Interaction
- **Eaten by prey only**: When a prey's collision circle overlaps a plant, the prey gains +10 energy and the plant is marked dead and removed
- **Not eaten by predators**: Predators do not interact with plants
- **Plant collision**: Both prey and predators are pushed away from plants on contact (elastic push)

---

## Combat System

### How it works
- Combat triggers when predator and prey are within **15px** of each other (`CONFIG.COMBAT_DIST`)
- Each frame of contact:
  - Prey takes `1.5 × predatorSize` damage to HP and energy
  - Predator takes `0.3 × preySize` damage to HP and energy
  - Prey flees (angle = away from predator)
  - Predator chases (angle = toward prey)
- Combat state persists while in contact
- When either dies, a carcass drops at their position

### Combat indicators
- Yellow spark/flash drawn at midpoint between combatants
- Flash pulses with `sin(time)` for visual feedback

---

## Neural Networks

### Architecture
- **Inputs**: 14
- **Hidden layer**: 8 neurons, tanh activation
- **Outputs**: 3 (steering, speed, mating)
- **Total weights**: 14×8 + 8 (biases) + 8×3 + 3 (biases) = **112 + 8 + 24 + 3 = 147 weights + biases**

### Inputs (14 total)
1. Nearest food angle — relative to facing direction, normalized -1 to 1
   - Prey: nearest plant angle
   - Predator: nearest carcass angle
2. Nearest food distance — normalized 0 to 1 (1 = very close, capped at 200px)
3. Nearest threat angle — relative to facing direction, normalized -1 to 1
   - Prey: nearest predator angle
   - Predator: nearest prey angle
4. Nearest threat distance — normalized 0 to 1 (capped at 200px)
5. Nearest mate angle — relative to facing direction, normalized -1 to 1
6. Nearest mate distance — normalized 0 to 1 (capped at 200px)
7. Nearest mate size — normalized by dividing by 2.5
8. Is in combat? — 0 or 1
9. Is in mating mode? — 0 or 1
10. Velocity X — normalized by agent's baseSpeed
11. Velocity Y — normalized by agent's baseSpeed
12. Energy level — normalized by agent's maxEnergy
13. Current size — normalized by dividing by 2.5
14. Bias — always 1.0

### Outputs (3 total)
1. **Steering** (tanh → -1 to 1): Maps to turn left/right
2. **Speed** (sigmoid → 0 to 1): Maps to min/max speed multiplier
3. **Mating interest** (sigmoid → 0 to 1): How much do I want to mate right now?

### Mutation
- Each weight has 5% chance of mutation
- Mutation amount: ±0.1 (added to weight value)

---

## Reproduction (Mating System)

### How it works
1. When agent's energy > reproduction threshold, enters **mating mode**
2. Looks for a mate of same species within 300px (`CONFIG.MATING_DIST`)
3. Both agents must output mating > 0.4 (mutual interest check)
4. If mutual interest confirmed:
   - **Brain**: True crossover — for each of the 147 weights, 50/50 coin flip takes weight from Parent A or Parent B, then mutation (5% chance, ±0.1)
   - **Maturity size**: Average of parents' maturity sizes ±5%
   - **Birth size**: 30% of calculated maturity size
   - **Generation**: max(parentA gen, parentB gen) + 1
   - **Energy split**: Each parent keeps 1/3, child gets 1/2 of parent A's energy (capped at maxEnergy × 0.3)
5. Mating mode has 60-second real-time timeout — if no mate found, exits back to wander
6. If energy drops below threshold while in mating mode, exits back to wander

### Why mating is better
- **Genetic diversity**: Offspring aren't clones — they get a mix of both parents' traits
- **Faster evolution**: Good traits from two different parents can combine in one child
- **Size inheritance**: Big parents tend to have bigger (tankier) offspring
- **Less stagnation**: Prevents the population from all becoming identical

### Generation tracking
- Each agent has a "generation" counter (starts at 0)
- Offspring = max(parent A generation, parent B generation) + 1
- Displayed in HUD as max generation reached

---

## Rewards & Penalties

### Internal Rewards (Energy)
- **Reward**: Eating food/prey = +Energy
- **Penalty**: Moving/Turning = -Energy (scales with size)
- **Bonus**: Surviving = more chances to reproduce
- This is the main driver — agents that find food and avoid danger get more energy and reproduce more

### External Rewards (Fitness)
- Each agent has a hidden "fitness" counter
- **Gains**: +0.01 fitness per frame survived
- **Doesn't affect gameplay** — just tracks how "successful" an agent was
- Useful for debugging and saving best agents later

---

## Simulation Loop

### Each frame
1. **Plant spawning**: Each existing plant has 1% chance per frame to spawn a neighbor at ±300px offset. Cap: 300 total plants.
2. **Plant culling**: Every 300 frames, if plants > 30, remove 10% randomly.
3. **Update each agent's brain** — feed in sensory data, get steering + speed + mating interest
4. **Apply movement** — turn toward steering, move at chosen speed
5. **Consume energy** — based on movement, size, and state
6. **Check collisions** — food/prey/threat detection
7. **Handle eating** — gain energy, remove food
8. **Handle combat** — check predator/prey proximity, apply damage
9. **Handle death** — remove dead agents, drop carcasses
10. **Handle reproduction** — spawn offspring if energy threshold met
11. **Population floor** — ensure minimum populations (prey ≥12, predators ≥6)
12. **Cleanup** — filter dead plants, carcasses, agents
13. **Update graph** — record population counts

### World
- Canvas fills the window (minus 110px for UI)
- **Pac-Man wrapping** — agents go off one side, appear on the other
- `CONFIG.WRAP = true`

---

## Starting Population

| Type | Count |
|------|-------|
| Prey | **200** |
| Predators | **50** |
| Plants | **60** |
| Carcasses | 0 |

---

## Population Floor
- **Prey minimum**: 12
- **Predator minimum**: 6
- If population drops below threshold, new agents are spawned instantly to fill the gap
- Spawned agents use random maturity sizes (not inherited)

---

## Old Age Death
- Agents die after reaching `maxLifetime` frames
- **Prey**: 8000 frames (~133 seconds at 60fps)
- **Predator**: 12000 frames (~200 seconds at 60fps)
- Growth period is the first **1/3** of maxLifetime

---

## UI / HUD

### Top-left (stats overlay)
- Population: Prey / Predator / Plants / Carcasses counts
- Max generation reached
- Total births / deaths since start
- Speed multiplier
- FPS counter

### Top-right (controls)
```
A: Plant | S: Prey | D: Predator
Space: Pause | R: Reset | +/-: Speed
```

### Bottom
- **Population graph** — shows prey (blue), predator (red), carcasses (gray) counts over time
- X-axis = time, Y-axis = population count
- Graph scrolls left as time progresses
- Shows last ~30 seconds of data (300 history entries at 10-frame intervals)
- Legend: Prey (blue), Predator (red), Carcasses (gray)

---

## Controls
| Key | Action |
|-----|--------|
| **A** | Add 1 plant at mouse position |
| **S** | Add 1 prey at mouse position |
| **D** | Add 1 predator at mouse position |
| **Shift+A** | Add 20 plants scattered ±30px around mouse |
| **Shift+S** | Add 20 prey scattered ±30px around mouse |
| **Shift+D** | Add 20 predators scattered ±30px around mouse |
| **Space** | Pause/resume |
| **R** | Reset simulation |
| **+** | Increase speed (max 10x) |
| **-** | Decrease speed (min 1x) |

---

## Configuration Constants

| Constant | Value | Description |
|----------|-------|-------------|
| `PREY_START` | 200 | Starting prey count |
| `PRED_START` | 50 | Starting predator count |
| `PLANT_START` | 60 | Starting plant count |
| `PLANT_SPAWN_RATE` | 0.02 | Chance per frame (note: code uses 0.01 per plant) |
| `CARCASS_DECAY` | 0.005 | Energy decay per frame |
| `MUTATION_RATE` | 0.05 | Weight mutation probability |
| `MUTATION_AMOUNT` | 0.1 | Weight mutation magnitude |
| `MATING_DIST` | 300 | Maximum distance to find a mate |
| `COMBAT_DIST` | 15 | Distance to trigger combat |
| `WRAP` | true | Pac-Man wrapping enabled |
| `MAX_GEN` | 1000 | Max generation for display |

---

## Emergent Behaviors to Watch For
- Prey learning to flee from predators
- Predators learning to chase and corner prey
- Prey swarming predators to kill them (if it becomes viable)
- Plant clustering patterns
- Population cycles (classic predator/prey oscillation)
- Energy efficiency strategies
- "Ambush" vs "chase" predator strategies
- Herding behavior in prey
- **Size specialization**: Some prey evolve to be tiny and fast, others huge and tanky
- **Mating strategies**: Some agents prioritize finding mates, others prioritize eating

---

## Future Additions
- Different prey/predator species (color-coding by brain similarity)
- Terrain/features (walls, water, safe zones)
- Memory in the brain (recurrent network)
- Visualize the brain state of a selected agent (click to inspect)
- Save/load best brains
- Mutation rate slider
- Population graph with more detail (energy averages, etc.)
- Different plant types
