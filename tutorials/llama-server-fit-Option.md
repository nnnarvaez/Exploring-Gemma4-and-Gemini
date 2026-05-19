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

**Why Use It?**  
• **Convenience:** No more guessing layer counts or manually splitting tensors.  
• **Performance:** Optimizes placement for faster inference, sometimes doubling speed over generic manual configs.  
• **Accessibility:** Lets lower-VRAM setups run larger models by intelligently spilling weights/context to system RAM.  
• **Override Friendly:** Respects manually set flags like `--n-gpu-layers` or `--tensor-split`, only automating the remaining parameters.
