# Add the brain toggle in LMStudio to 3rd party Models

<img width="2546" height="964" alt="image" src="https://github.com/user-attachments/assets/4117f03b-6745-4e64-add6-13e32d2d4126" />

LMStudio wants you to download the Models from their page to give you the full interface experience. 
But you can have the toggle thanks to the community and beleive me after a lot of google searches, and head scratching, and adding stuff to the Jinja template, finally in HauhauCS's discord server, our friend Luffythefox (a finetuner that always wants to help) finally gave me the secret!

## Here is the How to:

Go to this repo [
Yaml-model-files-for-LMS
](https://github.com/griefertroll101/Yaml-model-files-for-LMS)
Download the repo as ZIP open the zip file.
**ALSO READ THEIR README So you have a clue of what they did to help us**

Go to `C:\Users\<YOURUSERNAME>\` find the folder:  `\.lmstudio\hub\models\` 
You can just replace your `\.lmstudio\hub\models\` with the contents of the repo `models` folder.

Since i only use many quants and versions of QWEN3.6 and Gemma4 i only dropped those folders. 

Then I had 1 rebel model because i had just downloaded a fresh finetune from: [@LuffyTheFox](https://huggingface.co/LuffyTheFox)
And their repo is not updated yet, but Luffy himself provided an updated file, I just copied his File to the `model.yaml` in `hub\models\` folder.

in case something happens to you and you can't call a friend here is what you do:
Open the `models.yaml` file in the model folder in `hub` and add an entry for your finetune: 

```
  - key: "LuffyTheFox/Qwen3.6-35B-A3B-Uncensored-Genesis-V2-APEX-MTP-GGUF"
    sources:
      - type: huggingface
        user: "LuffyTheFox"
        repo: "Qwen3.6-35B-A3B-Uncensored-Genesis-V2-APEX-MTP-GGUF"
```

You can fill the info from the Hugginfface repo of the model here for reference:

<img width="1607" height="451" alt="image" src="https://github.com/user-attachments/assets/7870367f-700f-468b-b40d-130e1275553b" />

- Key: is the user / HF repo name
- Type: huggingface
- User: the creator
- repo: the repo... 

---
## Enjoy your brains...
This reddit post took me like 80% of the way [Tutorial - How to Toggle On/OFf the Thinking Mode Directly in LM Studio for Any Thinking Mode](https://www.reddit.com/r/LocalLLaMA/comments/1sc9s1x/tutorial_how_to_toggle_onoff_the_thinking_mode/) but a few things have changed and now we have the repo i linked.

