# Start using llama CPP server
Dont be afraid of leaving LM Studio

Download from GIT HUB The server:
`Extract it in a folder of your liking`
https://github.com/ggml-org/llama.cpp/releases/download/b9590/llama-b9590-bin-win-cuda-13.3-x64.zip



The CUDA drivers
`Drop them in the same folder as the llamaCPP files`
https://github.com/ggml-org/llama.cpp/releases/download/b9590/cudart-llama-bin-win-cuda-13.3-x64.zip

**OR**
From Nvidia the CUDA toolkit
`Install the Nvida toolkit to have them globally available`
https://developer.nvidia.com/cuda-downloads

Make a `anyname-start.bat`

paste this:
```
.\llama-server.exe --model "C:\Users\NEW\.lmstudio\models\lmstudio-community\Qwen3.6-35B-A3B-GGUF\Qwen3.6-35B-A3B-Q6_K.gguf" --parallel 1 -fit on --jinja --flash-attn --cache-type-k q8_0 --cache-type-v q8_0 --timeout 3600 --verbosity 4 --mmproj-offload off --reasoning --reasoning-budget 3072 --reasoning-budget-message "</think>[Output Generation]" --no-mmap --batch-size 2048 --ubatch-size 2048 --ctx-size 98304 --device-id 0 --temp 0.6 --top-p 0.95 --top-k 20 --presence-penalty 0.0 --repeat-penalty 1.0
```

**Parameter Mapping Breakdown**
For your reference, here is what the params mean

- flags:np = 1 → --parallel 1 (Number of parallel request slots)
- fit = on → -fit on or --flash-intel-tune on (Memory allocation optimization)
- jinja = true → --jinja (Enables Jinja chat templating)
- flash-attn = on → --flash-attn (Enables Flash Attention)
- ctk = q8_0 → --cache-type-k q8_0 (8-bit quantization for Key cache)
- ctv = q8_0 → --cache-type-v q8_0 (8-bit quantization for Value cache)
- mmproj-offload = off → --mmproj-offload off (Forces multimodal project to stay on CPU)
- reasoning = on → --reasoning (Enables native reasoning token outputs)
- reasoning-budget-message = "..." → --reasoning-budget-message "..." (Custom suffix injector)
- mmap = false → --no-mmap (Disables memory mapping, forces full RAM allocation)
- device = CUDA0 → --device-id 0 (Binds process strictly to your first NVIDIA GPU)
- ubatch-size = 2048 → --ubatch-size 2048: This represents the physical maximum batch size (or micro-batch). 
- batch-size = 2048 → --batch-size 2048: This dictates the logical maximum batch size.
