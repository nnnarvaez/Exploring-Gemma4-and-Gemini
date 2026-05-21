## llama-server FIT flag


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
