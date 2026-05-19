# Step by step linux guide to transplant MTP block into a non MTP model
It creates a new file ready to deploy with MTP

##### Requires:
llama.cpp with version AT LEAST b9180.

#### TL | DR

```
source ~/.venvs/global/bin/activate
mkdir MTPconv
cd MTPconv
wget https://huggingface.co/am17an/Qwen3.6-35BA3B-MTP-GGUF/resolve/main/Qwen3.6-35BA3B-MTP.gguf
ln ~/models/qwen3x/Qwen3.6-35B-A3B-Uncensored-HauhauCS-Aggressive-IQ4_NL.gguf Qwen3.6-35B-A3B-Uncensored-HauhauCS-Aggressive-IQ4_NL.gguf
pip install gguf
python3 convert.py \
  ./Qwen3.6-35B-A3B-Uncensored-HauhauCS-Aggressive-IQ4_NL.gguf \
  ./Qwen3.6-35BA3B-MTP.gguf \
  ~/models/qwen3x/Qwen3.6-35B-A3B-MTP-Uncensored-HauhauCS-Aggressive-IQ4_NL.gguf
```

#### Slow step by step for Gen X geeks

```
mkdir MTPconv
cd MTPconv
```

#### Download MTP version of your model

Transplant donnor:

```
wget https://huggingface.co/am17an/Qwen3.6-35BA3B-MTP-GGUF/resolve/main/Qwen3.6-35BA3B-MTP.gguf
```


#### Convert

Activate the venv to protect linux python from yourself :(
```
source ~/.venvs/global/bin/activate
```

Dependencies needed:

```
# import hashlib
# import sys
# import struct
# from pathlib 
# -------------

pip install gguf
```

*Note:* Using venv you will need to create a ln to the target model or move it to the same folder

```
ln ~/models/qwen3x/Qwen3.6-35B-A3B-Uncensored-HauhauCS-Aggressive-IQ4_NL.gguf Qwen3.6-35B-A3B-Uncensored-HauhauCS-Aggressive-IQ4_NL.gguf
```

**Conversion command format:** 
```
python3 convert.py  <base> <donor> <destination>`
```
```
python convert.py <target.gguf> <source.gguf> <output.gguf>`
```

```
python3 convert.py
  ~/models/qwen3x/Qwen3.6-35B-A3B-Uncensored-HauhauCS-Aggressive-IQ4_NL.gguf \
  ~/models/MTPconv/Qwen3.6-35BA3B-MTP.gguf \
  ~/models/qwen3x/Qwen3.6-35B-A3B-MTP-Uncensored-HauhauCS-Aggressive-IQ4_NL.gguf
```

**With the stupid ln because of the venv**
```
python3 convert.py \
  ./Qwen3.6-35B-A3B-Uncensored-HauhauCS-Aggressive-IQ4_NL.gguf \
  ./Qwen3.6-35BA3B-MTP.gguf \
  ~/models/qwen3x/Qwen3.6-35B-A3B-MTP-Uncensored-HauhauCS-Aggressive-IQ4_NL.gguf
```


**Run Llama-server:**

```
~/llama.cpp/bin/llama-server \
  -m ~/models/qwen3x/Qwen3.6-35B-A3B-MTP-Uncensored-HauhauCS-Aggressive-IQ4_NL.gguf \
  --spec-type draft-mtp --spec-draft-n-max 2 -fa on 
```

**MTP arguments:** `--spec-type draft-mtp --spec-draft-n-max 2`


