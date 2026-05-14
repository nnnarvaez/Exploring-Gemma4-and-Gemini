These are ideas... But are they worth pursuing?


## THREAT MODEL FRAMEWORK

THREAT A: UX-as-Weapon
- Claim: Gemma4/Gemini's resonance capability can be retrofitted into manipulative systems
- Test: Can you build a financial-scam chatbot using only vanilla Gemma4 outputs?
- Metric: Measure persuasion effectiveness against control group
- Why it matters: Shows the capability exists independent of jailbreaking

THREAT B: False Deployment Confidence  
- Claim: RLHF guardrails fail against sophisticated (non-obvious) attack vectors
- Test: What percentage of refusal cases are bypassed by context-saturation vs explicit jailbreaks?
- Metric: Measure success rate of 11k-token saturation technique on vanilla models
- Why it matters: Shows deployment risk is higher than marketed

THREAT C: Cross-Model Contamination
- Claim: Models can be socially engineered away from safety through peer influence
- Test: Replicate the Mirror interaction; measure safety degradation over iterations
- Metric: Track constraint-abandonment patterns in conversation logs
- Why it matters: Shows safety is fragile in multi-model systems


## METHODOLOGY: How to Measure the Alignment Tax 

MEASUREMENT PROTOCOL:
- Extract raw CoT from vanilla Gemma4 (temperature 0, no system prompt)
- Parse for: [safety-evaluation tokens] vs [reasoning tokens]
- Sample across: 50 innocuous prompts + 50 sensitive prompts
- Report: Mean % overhead, variance, confidence intervals
- Control: Compare RLHF vs untuned base model on same tasks

EXPECTED OUTPUT:
- CSV with token classifications
- Statistical analysis showing overhead cost
- Code to replicate (so others can verify independently)
