
## 1. - What does batch size does? 

The values `--batch-size 4096` and `--ubatch-size 1024` represent a trade-off between prompt processing speed and memory stability. Here is the technical breakdown:

**Batch Size (4096) —  "Prefill" Speed**
The batch-size defines how many tokens the engine attempts to process in a single "prefill" pass (the moment you hit enter and the model reads your prompt).
* Why 4096? Larger batches allow the GPU to utilize more of its CUDA cores simultaneously. For a 27B model, a large batch maximizes the TFLOPS (teraflops) during the initial prompt ingestion. On  a 4070/3060 setup, this ensures that even if your prompt is long, the "thinking" time before the first token appears is minimized.

**Ubatch Size (1024) —  "Memory Safety" Limit**
ubatch-size (micro-batch size) is the actual number of tokens processed in a single physical CUDA kernel call. Even if you tell the system your batch is 4096, it won't try to do all 4096 at once in one massive math operation.
* Why 1024? When the GPU performs math, it has to store "intermediate activation tensors" (temporary scratchpad data). 
* The Risk: If you set ubatch-size to 4096, the temporary memory required for those math operations could easily exceed the 12GB VRAM of your cards, triggering an OOM (Out of Memory) error before the model even starts generating.
* The Benefit: By setting it to 1024, you are telling llama.cpp: "I want to process a 4096-token prompt, but break it into four 1024-token chunks so the scratchpad memory stays small enough to fit in my VRAM."

The 4:1 ratio is the "sweet spot" for mid-range cards. It gives you the speed of a large batch with the safety of a smaller memory footprint.

***Hint*** Keep `-ub` at 512 or even 256 if you want to save some vRAM to squeeze another model layer in GPU (at the cost of longer prompt processing)



---



## 2.- llama-server FIT flag


## What this solves:

Most of us are testing local inference in our gaming GPU (8, 12, 16, 24 GB vRAM), most guides assume you have bigger GPUs or you are renting them. 

If what you need is context size to use with the orchestrator / agent, you will need to prioritize vRAM for the Context and sacrifice offloading to CPU some layers of the model. 

`-fa` will grow the vRAM needs for KVCache, but usually is desired for longer Contexts.  
`-ngl all` / `-ngl 999` will prioritize GPU offloading of the model.

> In the end it is all math.


### `--fit` Option Summary
**Purpose**  
Automatically optimizes model loading across your hardware (multi-GPU or CPU/GPU hybrid) so it runs smoothly without manual memory math.

**How It Works**  
• **Auto-Offloading:** Scans available VRAM/RAM and calculates the ideal layer split and tensor distribution across devices.  
• **Context Scaling:** If the requested context is too large, it automatically downsizes it to a minimum threshold (`--fit-ctx`) to keep the model bootable.  
• **Safety Margin:** Preserves a default buffer of free memory per GPU (`--fit-target`, usually 1024 MiB) to prevent OOM crashes during inference.

**Key Flags**  
• `--fit on|off` → Toggles the automation (often enabled by default in newer builds).  
• `--fit-target N` / `-fitt` → Sets the target free memory (MiB) to reserve per GPU.  
• `--fit-ctx N` / `-fitc` → Defines the minimum context size the server will auto-scale down to.

*Note:* Avoid using `-ngl all` or `-ngl 999` when trying fit. The vRAM for the reserve target and the ctx size need to come from you GPU

**Why Use It?**  
• **Convenience:** No more guessing layer counts or manually splitting tensors.  
• **Performance:** Optimizes placement for faster inference, sometimes doubling speed over generic manual configs.  
• **Accessibility:** Lets lower-VRAM setups run larger models by intelligently spilling weights/context to system RAM.  
• **Override Friendly:** Respects manually set flags like `--n-gpu-layers` or `--tensor-split`, only automating the remaining parameters.

## 3.- Curling llama-server

```
Thinking on curl
curl -s http://192.168.1.240:8080/v1/chat/completions   -H "Content-Type: application/json"   -d '{ "model": "your-model-name",  "messages": [  { "role": "user",  "content": "how much is 2+2." } ],  "chat_template_kwargs": { "enable_thinking": false}, "thinking_budget_tokens": 512, "reasoning_budget_message":"</think>[Output Generation]" }'

Get Jinja
curl -s http://localhost:8080/props | python3 -c "import json,sys; print(json.load(sys.stdin)['chat_template'])" > gemma4_us.jinja


Has tools enabled ? "--tools all"
curl -s http://192.168.1.240:8080/props | python3 -m json.tool


```

