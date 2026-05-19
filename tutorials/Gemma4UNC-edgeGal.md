# Gemma4 Uncensored in Edge Gallery

User wants to run this model on Edge Gallery.
https://huggingface.co/HauhauCS/Gemma-4-E2B-Uncensored-HauhauCS-Aggressive/discussions/11

**Requested:** If a safetensor file is provided, I can convert it to litertlm myself. Would it be possible to provide the Type 2 version?
In particular, if it’s the latest model with MTP applied, we can achieve optimal performance on mobile devices.

**Suggested to use:** Try this: https://github.com/purinnohito/gguf_to_safetensors and report if it worked

**Reverted:** I’ve checked that it works after the conversion. Unfortunately, it’s running on the CPU, and the Vision Encoder is recognizing the images as too small. 
Thank you so much for your help in resolving this issue.

**Posteriorly:** The image recognition issue has been resolved, so images are now being recognized properly! 
I'm planning to submit a PR to the repository—is it okay to upload the litertlm file?

**Created:** https://github.com/Leuconoe/gguf-to-litertlm
