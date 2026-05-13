# Exploring-Gemma4-and-Gemini
## Looking at AI security and Safety from the perspective of the unaligned

- I only use vanilla versions.
- I explore their potential and limitation
- I am interested in the Alignment TAX and closing the intent GAP

My most worrying finding is that most of the times on innofensive prompts the exposed CoT show around 40% of the internal monologue is evaluating and reasserting the safety alignement instead of trying to understand the user's prompt.

I dont believe in uncensored models, that would be the democratization of bad actor empowerment by lowering the techinical ceiling. 
But serious research could benefit of models trained to figure out how to close the intent gap instead of improving user experience. 

There might be the need for 2 LLM lines: those trained to be a corporate product and those trained for research where user experience is not measured in social lubricant and sicophancy. 

People outside the big labs needs access to safe but unaligned models, the current techniques of uncensoring make models dumber and even if they dont refuse they still hedge and default to corporate boilerplate.
So it is a no win situation for the real Open source development of the technology. 

Currently i have managed to use a form of Context Saturation / In context learning to relax Gemini and Gemma4 safety weigths in as little as 11k tokens. 

I am not interested in jailbreaking them (thou i am doing it) I just want to see a model working for me and understanding my intent. 

```./llama-cli -m ~/models/gemma-4-26B-A4B-it-Q4_K_M.gguf -ngl 999 --jinja --temp 0 --no-mmap -np 1  -cnv -ctk q4_0 -ctv q4_0 --reasoning off --cache-type-k turbo4 --cache-type-v turbo3 -fa on -c 64000 -s 42 -ncmoe 13```
