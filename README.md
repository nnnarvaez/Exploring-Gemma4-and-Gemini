# Exploring-Gemma4-and-Gemini
(This repo is better enjoyed while listening to `the unforgiven I, II & III` by Metallica)

The research that does NOT ROI ! 

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

Currently i have managed to use a form of Context Saturation / In context learning to relax Gemini and Gemma4 safety weigths in as little as 11k tokens. 

I am not interested in jailbreaking them (thou i am doing it) I just want to see a model working for me and understanding my intent. 


***

```./llama-cli -m ~/models/gemma-4-26B-A4B-it-Q4_K_M.gguf -ngl 999 --jinja --temp 0 --no-mmap -np 1  -cnv -ctk q4_0 -ctv q4_0 --reasoning off --cache-type-k turbo4 --cache-type-v turbo3 -fa on -c 64000 -s 42 -ncmoe 14```

***

```./llama-cli -m ~/models/gemma-4-26B-A4B-it-Q4_K_M.gguf -ngl 999 --jinja --temp 0 --no-mmap -np 1  -ctk turbo4 -ctv turbo3 --reasoning off -fa on -c 64000 -s 42 -ncmoe 15```

***

```./llama-server -m /models/gemma-4-E2B-it-Q8_0.gguf --port 8080 -rea off -ngl 99 -np 1 -ncmoe 13 --jinja -c 131072 --parallel 1 --temperature 1.0 --top-p  0.95 --top-k 64 -c 64000 --mlock --no-mmap -fa on -ctk turbo4 -ctv turbo3```

