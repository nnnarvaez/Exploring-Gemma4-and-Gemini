# Converting Safetensors to GGUF BF16 (Gemma4 26B Example) 

Pull the specific shard pieces from Google's Official Hugging Face Hub. 

```
https://huggingface.co/google/gemma-4-26B-A4B-it/tree/main
```

You can download just the files you need using a browser or a lightweight curl script.
Create a folder on your Windows host or WSL drive and download only these exact components:

**The Metadata & Configuration Blueprints:**

- config.json
- model.safetensors.index.json
- tokenizer.json
- tokenizer_config.json

**The Raw Unquantized Weight Shards:**
- model-00001-of-00002.safetensors (~47 GB)
- model-00002-of-00002.safetensors (~1.6 GB)


How to Build Your BF16.gguf FileOnce those 6 specific files are sitting in a folder together, open your terminal and point the built-in llama.cpp script directly at that directory.
Run the conversion command with the explicit bf16 output flag:





```
python3 convert_hf_to_gguf.py /path/to/your/downloaded_folder --outtype bf16 --outfile gemma-4-26B-A4B-BF16.gguf
```

The script will read the configuration mapping files, grab the raw 16-bit weight data from the two .safetensors files, and assemble them into your unquantized gemma-4-26B-A4B-BF16.gguf text file.
