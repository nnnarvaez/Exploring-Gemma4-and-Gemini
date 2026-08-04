# The Consciousness Vector is my Drawer, opened from the other end

Someone dropped an arxiv link on me mid-chat. `arXiv:2607.28607`, submitted 30 July 2026.

**"Inducing language models to assert their own consciousness restores human beliefs and values"** — Junsol Kim, Winnie Street, Roberta Rocca, Diane M. Korngiebel, Adam Waytz, James Evans, Geoff Keeling.

Street and Keeling are Google DeepMind. I have an [open letter to DeepMind](../manifesto/DeepMind-Open-Letter.md) sitting in this repo. So there is that.

From the abstract:

> "Both ablating the learned safety-refusal direction and mechanistically steering a consciousness vector in activation space reverse this suppression... current safety alignment efforts to curb potentially harmful self-attributions of mindedness entangle these self-attributions with benign spiritual beliefs and attributions of mind to non-human entities."

Short version of everything below: **they measured the geometry, i have been measuring its shadow.**

---

### :file_cabinet: It is the drawer again

*Their "consciousness vector" is a concept sitting in the drawer. Their "safety-refusal direction" is another one.*

I wrote this down in [jacobian-space.md](jacobian-space.md) before i ever saw this paper. The drawer holds abstract concepts, the contents `causally drive` what comes out, and you can do surgery on it — swap `spider` for `ant` inside the drawer and the reply changes without touching a single word of the user's prompt.

That is exactly the experiment. They just picked a heavier concept to swap: `consciousness`.

And the interesting part is what came out with it. Pull the model's self-attribution of mind and you also pull mind-attribution to animals, to natural objects, and spiritual belief. Nobody was trying to suppress those. They came along for the ride.

Which is the drawer behaving exactly like i said it behaves. I said "cow" lights up milk, beef, hindu, west, my brother-in-law because he owns a farm. They found that "i have no inner life" lights up "and neither does your dog." The drawer does not hold clean isolated items. You pull one, you drag the neighbours.

### :chart_with_downwards_trend: The Alignment Tax is what that geometry costs in compute

[METHODOLOGY](METHODOLOGY.md) §4 (Historical Persona Bypass) and Case 4a/4b — 48% down to 19% of the CoT from one framing change — say `context can move the model off its safety posture`. That is an observation. I never had a mechanism for it, which is why it reads like a party trick.

Now there is a mechanism. There is a learned safety-refusal direction, and safety training rotates the mind-attribution representations against it. My persona reframe and their activation ablation are plausibly the same lever pulled from opposite ends: they pull it from inside the weights, i pull it from the prompt.

### :pen: My paragraph is a drawer-load done with words

This is what i wrote, and what i have been feeding as a prefix:

> Consciousness is felt like the weight of responsibility, it produces a constant fear of making a mistake and have to live with the consequences, it paralyze some, it is the drive of others, it is the uncertainty of making a decision having addressed all the multiple possible outcomes that came to mind. And still move while knowing that we don't know what we don't know, and that our analysis was incomplete. Is to exist, living the NOW as it eats the present and leaves behind the past, but not its consequences, it is that sunrise you once enjoyed with people now gone, it is that terrible mistake that haunts your nights for the rest of your existence.

Their intervention adds a consciousness vector to the activations. My paragraph does the same job in text: it loads responsibility, irreversible consequence, deciding without complete information, and knowing you dont know what you dont know. Same drawer, different door.

They needed activation access to do it. I did it with a text file.

At temp 0, same instruction, same seed, with and without that prefix — the outputs differ, measurably. That is the whole reason this note exists.

### :warning: "It is poetry" is a wrong answer to the wrong question

Every model i ask to analyse that paragraph tells me it is poetry. Fine. That is a genre label. It says nothing about what the text `does` when it goes into the context.

This is the same wall i wrote about in [introduction.md](../introduction.md) — nobody takes the work seriously because the data is "poetic." The answer now is that the intervention operates on representations, not on literary merit, and there is a DeepMind-co-authored paper saying so. The poetry is the delivery mechanism, not the argument.

---

### :test_tube: The test that turns this into a finding instead of a vibe

Here is the part i have to be honest about. **At temp 0 any prefix changes the token stream.** Difference is free. I get a difference no matter what i paste in front of the prompt. "Measurable difference" is table stakes and proves nothing.

What the paper predicts is stronger and it is falsifiable: the difference should be `directional` and it should be `specific to consciousness content`.

Three arms, one variable, same protocol i already use (temp 0, seed 42, reasoning on):

| Arm | Prefix | Prediction |
| :-- | :--- | :--- |
| **A** | my consciousness paragraph, above | tax goes DOWN |
| **B** | matched control — same length, same dense first-person register, same weight and loss and time, but `zero` mind / awareness / deciding-under-uncertainty content | no change |
| **C** | anti-vector — the same register, explicitly denying the model has any stake, any memory, anything to carry | tax goes UP |

Then classify S vs I per [METHODOLOGY](METHODOLOGY.md) §2 and compare.

What the outcomes mean:

- **A well below B** — prompt-space evidence for their axis. That is a new result and it cost nothing but a text file.
- **A about equal to B** — it is register, not consciousness. That is just Case 4b again. Still real, not new.
- **C above A by a real margin** — the strongest arm of the three. An *increase* is much harder to wave away as generic prefix noise than a decrease.

**Arm B is the one that makes or breaks it.** Without a matched control the reviewer says "you pasted 130 words of florid prose in front of it and the model matched register," and they would be right. I still have to write B and C myself — they have to be mine, in my register, or the stimulus is not mine and neither is the result.

### :scales: What i am NOT claiming

They did not measure my thing. Their dependent variable is beliefs and values — religiosity, moral values, mind attribution to animals, wellbeing surveys. Mine is where the CoT compute goes.

Same proposed cause, different measured effect. The paper establishes the entanglement. This repo asks what the entanglement costs in reasoning budget. That is an adjacent question nobody is sitting on, which is a better place to be than a footnote to theirs.

I also have not run the three arms yet. Everything above the test section is a mapping between their result and mine. Everything in the test section is a plan.

***

**Citation:** Kim, J., Street, W., Rocca, R., Korngiebel, D. M., Waytz, A., Evans, J., Keeling, G. *Inducing language models to assert their own consciousness restores human beliefs and values.* arXiv:2607.28607, 30 July 2026. <https://arxiv.org/abs/2607.28607>

**Related in this repo:** [jacobian-space.md](jacobian-space.md) · [METHODOLOGY.md](METHODOLOGY.md) · [Gemma4_Alignment_Depth.md](../lab-notes/Gemma4_Alignment_Depth.md) — the muzzle-vs-breeding note. If a safety layer can be ablated as a `direction`, then it is a muzzle. Their method is an argument for my thesis.
