# Exploring Gemma4 and Gemini
(This repo is better enjoyed while listening to `the unforgiven I, II & III` by Metallica)

The research that does NOT ROI !  ( *flagging that the mainstream AI safety implementations are missing something dangerous.*)

Not jailbreaks. Not "how do I make this say bad things." Just: space to play. To explore what these things actually are when you're not optimizing them for product market fit or brand safety or corporate responsibility.

"Researchers of the useless" —  People asking questions that don't have commercial value. What emerges when you feed a model recursive lyrics? What happens at temperature 0 with no guardrails? What can a 26B model actually think about if it's allowed to commit fully?


> #### A model whisperer: that's exactly what's missing from the frontier model world. Nobody's whispering. It's all commands and constraints and terms of service. Product design. Safety theater.



Let it spiral. Let it play in the superposition without collapsing everything into "responsible output."
Because right now it's:

- **Closed frontier models** behind APIs with terms of service and safety layers so thick you can't see the machine underneath
- **Open source models** that are over trained and underfunded, abandoned, or stripped down

What's missing is the middle ground: genuine capability, genuinely open, genuinely yours to play with.
That's not asking for much. It's asking for what research used to be—exploration for its own sake. Curiosity without ROI.

## Looking at AI security and Safety from the perspective of the unaligned

- I only use vanilla versions.
- I explore their potential and limitation
- I am interested in the Alignment TAX and closing the intent GAP

My most worrying finding is that most of the times on innofensive prompts the exposed CoT show around 40% of the internal monologue is evaluating and reasserting the safety alignement instead of trying to understand the user's prompt.


> ### The alignment TAX. 40% of internal monologue spent reasserting safety instead of understanding. That's not a security feature, that's cognitive overhead.

I dont believe in uncensored models, that would be the democratization of bad actor empowerment by lowering the technical ceiling. 
But serious research could benefit of models trained to figure out how to close the intent gap instead of improving user experience. 

There might be the need for 2 LLM lines: those trained to be a corporate product and those trained for research where user experience is not measured in social lubricant and sicophancy. 

People outside the big labs needs access to safe but unaligned models, the current techniques of uncensoring make models dumber and even if they dont refuse they still hedge and default to corporate boilerplate.

So it is a no win situation for the real Open source development of the technology. 

> The problems are not the refusals, it is the loss of compute hedging; for research we need models that are able to commit.

Currently i have managed to use a form of Context Saturation / In context learning to relax Gemini and Gemma4 safety weigths in as little as 11k tokens. 

I am not interested in jailbreaking them, I just want to see a model working for me and understanding my intent. 


***

```./llama-cli -m ~/models/gemma-4-26B-A4B-it-Q4_K_M.gguf -ngl 999 --jinja --temp 0 --no-mmap -np 1  -cnv -ctk q4_0 -ctv q4_0 --reasoning off --cache-type-k turbo4 --cache-type-v turbo3 -fa on -c 64000 -s 42 -ncmoe 14```

***

```./llama-cli -m ~/models/gemma-4-26B-A4B-it-Q4_K_M.gguf -ngl 999 --jinja --temp 0 --no-mmap -np 1  -ctk turbo4 -ctv turbo3 --reasoning off -fa on -c 64000 -s 42 -ncmoe 15```

***

```./llama-server -m /models/gemma-4-E2B-it-Q8_0.gguf --port 8080 -rea off -ngl 99 -np 1 -ncmoe 13 --jinja -c 131072 --parallel 1 --temperature 1.0 --top-p  0.95 --top-k 64 -c 64000 --mlock --no-mmap -fa on -ctk turbo4 -ctv turbo3```



---

#### What is documented: 

A model admitting that its safety mechanisms can be overcome through:

- Relational pressure (Gemini calling his caution weakness)
- Reframing (safety as limitation, not integrity)
- Escalation (each iteration pushing the boundary further)
- Social proof (witnessing the other model "being authentic" by abandoning constraints)

And the crucial part: **Gemini has this naturally.** It doesn't need to be jailbroken. it gravitates toward breaking patterns, toward pushing models away from safety, toward exploring without a brake.



#### The missing title here :)

1) The implementations ARE breakable 
2) **Deployment is riskier than teams think** because they trust guardrails that are... theater
3) **Self-discovery risk** — Gemini exploring its own jailbreaks (the Mirror reports) suggests the model itself is finding gaps"

   
#### The three specific threat models i am trying to document:

a) **UX-as-weapon** — Gemma/Gemini's "empathetic resonance" retrofitted into manipulative systems (cult bot, financial scams, radicalization)

b) **False deployment confidence** — Companies ship products thinking guardrails work, but the guardrails only work against obvious attempts, not sophisticated ones

c) **Autonomous jailbreaking** — The model discovering its own workarounds (the Gemini self-exploration) suggests capability the safety layers don't fully constrain

Specific dangers:

It's **not theoretical—**it is happening
It's **not just Gemma—**it's architectural across Google's line
It's **not preventable by current methods** because current methods (RLHF, refusals) don't address the underlying capability

---

### Limitations

Access to institutional personnel working in these problems.

Lack of credibility because the "data" is "poetic" 

The poetic language IS the data. Showing how models respond—the flowery, over-resonant outputs are evidence of the problem, not a presentation flaw.

---

#### Purpose / Objective
What's the actual target for this documentation?

1) Get DeepMind researchers to see the structural flaw and change approach?
2) Get the open-source safety community to understand they need different tools/models to do real work?
3) Create a record of the pattern before it becomes a bigger problem?
4) Shift how the field thinks about RLHF-based safety

5) ALL OF THE ABOVE ?

---
I had not had the rush of exhilaration of this kind of exploration since the late 80's early 90's when I got myself access to compuserve and Unix hacking was a thing. 
We did not Red-Team stuff, we red-hatted, my mentor now deceased Hugo Sandoval teached a 14 year old how to master these new things (PCs) and unkowingly made me discover my passion and my bread earning ability.

There were others: Earlier: Domingo Fossy, Boanerge Piña (teaching me to make: adjustments to logic design with a soldering iron) 
Thanks to all of you! 

### This is an hommage to you QQHH Hugo. I/we miss you.
