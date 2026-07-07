# Report: Gemma 4 12b KV Cache Quantization Analysis
TL|DR
Q8 seems to work well with 12GB vRAM, No quality degradation observed speed drop similar to Q4 and 0.8 gb vRAM freed. 

LLAMA-SERVER started with the following:

```
    "%BASE_FOLDER%%EXEC_FOLDER%llama-server" ^
    -m "%BASE_FOLDER%%MODEL_FOLDER%gemma-4-12B-it-qat-UD-Q4_K_XL.gguf" ^
    -md "%BASE_FOLDER%%MODEL_FOLDER%gemma-4-12B-it-Q4_0-MTP.gguf" ^
    --mmproj "%BASE_FOLDER%%MODEL_FOLDER%mmproj-F32.gguf" ^
    --spec-type draft-mtp --spec-draft-n-max 3 -ngl 999 -fa on ^
    --ctx-size 98304 --temperature 0.6 --top_k 64 --top_p 0.9 --min_p 0.05 ^
    --repeat_penalty 1.1 --host 0.0.0.0 --mmproj-offload ^
    --tools all --webui-mcp-proxy --jinja --log-file "%LOG_PATH%" ^
    --cache-type-k q8_0 --cache-type-v q8_0 --threads-batch 6 --parallel 1 --kv-unified ^
    -ag --alias "Gemma4 12B QAT4 Unsloth" --reasoning-budget 3072 ^
    --reasoning-budget-message "</think>[Output Generation]" &
```


## 1. Context & Objectives
This report evaluates the impact of **Key-Value (KV) Cache Quantization** on the **Gemma 4 12b** model. 
Test rig: I5 12th gen, 32gb ddr 5 5600, RTX4070 super 12gB.

### What is being measured?
Just as model weights can be quantized to reduce size at the cost of precision, the **Context KV Cache** can also be quantized. The primary goal of this testing was to measure the trade-off between:
*   **VRAM Capacity:** How much memory we can "free up" to fit larger context windows on consumer hardware (e.g., 12GB GPUs).
*   **Inference Speed:** Whether quantization overhead slows down token generation ($tg$).
*   **Model Coherence:** The risk of the model becoming "dumber" or losing coherence by sacrificing precision for size.

---

## 2. Test Methodology & Configurations
Three scenarios were tested to determine the viability of different KV cache strategies:

| Scenario | Configuration | Technical Goal |
| :--- | :--- | :--- |
| **Scenario A** | **Full Q4 Quantization** | Maximum memory savings for long context. |
| **Scenario B** | **Default F16 Cache** | Baseline performance (High precision). |
| **Scenario C** | **Asymmetric Cache** | Testing $V$ at Q4 and $K$ at f16 (based on TurboQuant research). |

---

## 3. Data Analysis & Findings

### 3.1 Performance Metrics (Speed)
The table below illustrates the performance impact of each configuration.

| Configuration | Avg. $tg$ (tokens/s) | Eval Time (ms/token) | Observation |
| :--- | :--- | :--- | :--- |
| **Default F16** | ⚡ ~123.96 t/s | ~8.20 ms | **Fastest.** High precision, high memory cost. |
| **Q4 V and K** | 🟢 ~105.67 t/s | ~9.32 ms | **Balanced.** Slight speed drop for significant VRAM savings. |
| **Asymmetric (V Q4, K f16)** | 🐌 ~13.11 t/s | ~76.68 ms | **Failure State.** Extreme overhead due to recalculation. |

### 3.2 Memory Utilization
Visual evidence from system captures confirms the VRAM footprint:

*   **F16 KV Cache:** 9.4 / 12.0 GB Dedicated Memory Used (High overhead).
*   **Q4 KV Cache:** 8.3 / 12.0 GB Dedicated Memory Used (**~1.1 GB Saved**).

---

## 4. Technical Deep Dive: Asymmetric Quantization
The "Asymmetric" test was designed based on research (e.g., **TurboQuant**) suggesting that the Value ($V$) component can be quantized more aggressively than the Key ($K$) component without catastrophic precision loss.

**Key Finding:** In non-turbo quantization environments, if one component is defined asymmetrically, the system often suffers from a massive overhead penalty. The GPU must frequently recalculate the KV pairs back to f16 for inference, which "fucks" the inference speed (dropping it from ~100+ t/s to ~13 t/s).

<img width="1893" height="948" alt="image" src="https://github.com/user-attachments/assets/9b4a6c6b-cd21-451a-9ef1-a42ef74a3aef" />

### Probably worth retesting now or using this compile option: 

<img width="1311" height="123" alt="image" src="https://github.com/user-attachments/assets/94402383-5690-41ce-a4aa-486840447562" />

---

## 5. Developer Perspective & Recommendations

### 💡 Key Takeaways:
1.  **Quantization is not a Speed Boost:** It is important to note that quantizing the KV cache does **not** make the model run faster; it makes it "smaller and dumber." The goal is to free up VRAM, not to increase tokens per second.
2.  **The "Party Trick" Warning:** While Q4 KV quants are useful for squeezing large context windows into 12GB GPUs, they represent a trade-off in model coherence. They should be used as a last resort for hardware limitations rather than a general optimization.
3.  **Precision First:** For most use cases, running the highest possible quant (e.g., Q8) is preferred to maintain model intelligence.

### 🏆 Final Recommendation:
*   **For High-End Hardware:** Stick to **Default F16**. It provides the best coherence and fastest speed.
*   **For Memory-Constrained Hardware (12GB VRAM):** Use **Full Q4 Quantization**. It successfully frees up ~1.1 GB of VRAM with only a manageable impact on generation speed.
*   **Avoid:** Asymmetric quantization in current non-turbo environments due to the extreme performance bottleneck.


### Older hardware GTX 1660 super 6GB
Speed is much more affected by KV Quantization


#### Compiled with:
<img width="1311" height="123" alt="image" src="https://github.com/user-attachments/assets/94402383-5690-41ce-a4aa-486840447562" />
#### Tried Asymetric K/V it crashed


```
./llama-server \
    -m /home/nathan/wsl-shared/models/unsloth/gemma-4-12B-it-qat-GGUF/gemma-4-12B-it-qat-UD-Q4_K_XL.gguf \
    -md /home/nathan/wsl-shared/models/unsloth/gemma-4-12B-it-qat-GGUF/gemma-4-12B-it-Q4_0-MTP.gguf \
    --mmproj /home/nathan/wsl-shared/models/unsloth/gemma-4-12B-it-qat-GGUF/mmproj-F32.gguf \
    --spec-type draft-mtp --spec-draft-n-max 3 -fa on \
    --ctx-size 98304 --temperature 0.6 --top_k 64 --top_p 0.9 --min_p 0.05 \
    --repeat_penalty 1.1 --host 0.0.0.0 --mmproj-offload \
    -ctkd iq4_nl -ctvd iq4_nl --tools all --webui-mcp-proxy --jinja \
    --cache-type-k iq4_nl --cache-type-v iq4_nl --threads-batch 6 --parallel 1 --kv-unified \
    -b 1024 -ub 512 -ag --alias "Gemma4 12B QAT4 Unsloth" --reasoning-budget 2048 \
    --reasoning-budget-message "</think>[Output Generation]" 
```

#### Using iq4_nl
<img width="1683" height="417" alt="image" src="https://github.com/user-attachments/assets/1117c37d-31af-4822-bd9b-97c04976fe74" />

---

#### Using Q8_0

<img width="1103" height="415" alt="image" src="https://github.com/user-attachments/assets/1ace0b5a-9dff-4c45-b44b-e6a813c93cd7" />

#### Using q4_0
No speed or memory change appreciated in the GTX1660
<img width="1705" height="488" alt="image" src="https://github.com/user-attachments/assets/a7204196-f3e0-45d3-b4ef-f7ce9e9d8f38" />


---

# Annex: Logs



### With Q4 V AND K 

1st run 
```
0.16.385.973 I slot print_timing: id  0 | task 42 | n_decoded =    335, tg = 111.67 t/s, tg_3s = 111.66 t/s
0.16.519.182 I slot print_timing: id  0 | task 42 | prompt eval time =     714.79 ms /  1091 tokens (    0.66 ms per token,  1526.33 tokens per second)
0.16.519.187 I slot print_timing: id  0 | task 42 |        eval time =    3133.20 ms /   353 tokens (    8.88 ms per token,   112.66 tokens per second)
0.16.519.188 I slot print_timing: id  0 | task 42 |       total time =    3847.99 ms /  1444 tokens
0.16.519.189 I slot print_timing: id  0 | task 42 |    graphs reused =        132
0.16.519.195 I slot print_timing: id  0 | task 42 | draft acceptance = 0.66237 (  257 accepted /   388 generated), mean acceptance length =  3.65, acceptance rate per position = (0.804, 0.701, 0.629, 0.515)
0.16.519.216 I statistics        draft-mtp: #calls(b,g,a) =    2    134    134, #gen drafts =    134, #acc drafts =   109, #gen tokens =    536, #acc tokens =   354, #mean acc len = 3.64, #acc rate/pos = (0.813, 0.716, 0.619, 0.493), dur(b,g,a) = 0.004, 808.560, 0.264 ms
```

2nd run

```
0.43.627.623 I slot print_timing: id  0 | task 144 | n_decoded =    300, tg =  99.66 t/s, tg_3s =  99.66 t/s
0.43.828.249 I slot print_timing: id  0 | task 144 | prompt eval time =     346.67 ms /     1 tokens (  346.67 ms per token,     2.88 tokens per second)
0.43.828.255 I slot print_timing: id  0 | task 144 |        eval time =    3210.86 ms /   329 tokens (    9.76 ms per token,   102.46 tokens per second)
0.43.828.256 I slot print_timing: id  0 | task 144 |       total time =    3557.54 ms /   330 tokens
0.43.828.256 I slot print_timing: id  0 | task 144 |    graphs reused =        229
0.43.828.261 I slot print_timing: id  0 | task 144 | draft acceptance = 0.57828 (  229 accepted /   396 generated), mean acceptance length =  3.31, acceptance rate per position = (0.778, 0.636, 0.495, 0.404)
0.43.828.282 I statistics        draft-mtp: #calls(b,g,a) =    3    233    233, #gen drafts =    233, #acc drafts =   186, #gen tokens =    932, #acc tokens =   583, #mean acc len = 3.50, #acc rate/pos = (0.798, 0.682, 0.567, 0.455), dur(b,g,a) = 0.006, 1417.448, 0.462 ms
```

# With default K V f16

1st run 
```0.10.655.055 I slot print_timing: id  0 | task 0 | n_decoded =    374, tg = 123.96 t/s, tg_3s = 123.95 t/s
0.11.730.868 I slot print_timing: id  0 | task 0 | prompt eval time =     652.30 ms /  1091 tokens (    0.60 ms per token,  1672.55 tokens per second)
0.11.730.872 I slot print_timing: id  0 | task 0 |        eval time =    4092.97 ms /   516 tokens (    7.93 ms per token,   126.07 tokens per second)
0.11.730.873 I slot print_timing: id  0 | task 0 |       total time =    4745.27 ms /  1607 tokens
0.11.730.874 I slot print_timing: id  0 | task 0 |    graphs reused =        139
0.11.730.879 I slot print_timing: id  0 | task 0 | draft acceptance = 0.66312 (  374 accepted /   564 generated), mean acceptance length =  3.65, acceptance rate per position = (0.809, 0.723, 0.596, 0.525)
0.11.730.906 I statistics        draft-mtp: #calls(b,g,a) =    1    141    141, #gen drafts =    141, #acc drafts =   114, #gen tokens =    564, #acc tokens =   374, #mean acc len = 3.65, #acc rate/pos = (0.809, 0.723, 0.596, 0.525), dur(b,g,a) = 0.003, 662.976, 0.282 ms
```


2nd run

```
0.58.543.330 I slot print_timing: id  0 | task 146 | prompt eval time =     572.90 ms /    19 tokens (   30.15 ms per token,    33.16 tokens per second)
0.58.543.336 I slot print_timing: id  0 | task 146 |        eval time =    2891.64 ms /   342 tokens (    8.46 ms per token,   118.27 tokens per second)
0.58.543.337 I slot print_timing: id  0 | task 146 |       total time =    3464.54 ms /   361 tokens
0.58.543.337 I slot print_timing: id  0 | task 146 |    graphs reused =        234
0.58.543.342 I slot print_timing: id  0 | task 146 | draft acceptance = 0.61990 (  243 accepted /   392 generated), mean acceptance length =  3.48, acceptance rate per position = (0.755, 0.673, 0.571, 0.480)
0.58.543.365 I statistics        draft-mtp: #calls(b,g,a) =    2    239    239, #gen drafts =    239, #acc drafts =   188, #gen tokens =    956, #acc tokens =   617, #mean acc len = 3.58, #acc rate/pos = (0.787, 0.703, 0.586, 0.506), dur(b,g,a) = 0.006, 1151.193, 0.468 ms
```

# Only with V Q4   K f16 (Asymetric cache) 

1st run

```
0.29.038.738 I slot print_timing: id  0 | task 0 | prompt processing, n_tokens =    575, progress = 0.53, t =   6.91 s / 83.25 tokens per second
0.29.110.733 I slot create_check: id  0 | task 0 | created context checkpoint 1 of 32 (pos_min = 0, pos_max = 574, n_tokens = 575, size = 115.120 MiB)
0.40.683.413 I slot print_timing: id  0 | task 0 | prompt processing, n_tokens =   1073, progress = 0.98, t =  18.55 s / 57.84 tokens per second
0.40.799.708 I slot create_check: id  0 | task 0 | created context checkpoint 2 of 32 (pos_min = 0, pos_max = 1072, n_tokens = 1073, size = 205.013 MiB)
0.41.713.764 I slot print_timing: id  0 | task 0 | prompt processing, n_tokens =   1087, progress = 1.00, t =  19.58 s / 55.51 tokens per second
0.42.698.405 I reasoning-budget: activated, budget=3072 tokens
0.50.441.715 I slot print_timing: id  0 | task 0 | n_decoded =    103, tg =  12.43 t/s, tg_3s =  12.43 t/s
0.53.549.702 I slot print_timing: id  0 | task 0 | n_decoded =    141, tg =  12.38 t/s, tg_3s =  12.23 t/s
0.56.738.967 I slot print_timing: id  0 | task 0 | n_decoded =    169, tg =  11.59 t/s, tg_3s =   8.78 t/s
0.59.773.620 I slot print_timing: id  0 | task 0 | n_decoded =    203, tg =  11.52 t/s, tg_3s =  11.20 t/s
1.02.879.304 I slot print_timing: id  0 | task 0 | n_decoded =    244, tg =  11.77 t/s, tg_3s =  13.20 t/s
1.06.002.063 I slot print_timing: id  0 | task 0 | n_decoded =    299, tg =  12.54 t/s, tg_3s =  17.61 t/s
1.09.251.570 I slot print_timing: id  0 | task 0 | n_decoded =    341, tg =  12.59 t/s, tg_3s =  12.93 t/s
1.10.170.079 I reasoning-budget: deactivated (natural end)
1.12.298.350 I slot print_timing: id  0 | task 0 | n_decoded =    368, tg =  12.21 t/s, tg_3s =   8.86 t/s
1.15.522.480 I slot print_timing: id  0 | task 0 | n_decoded =    398, tg =  11.93 t/s, tg_3s =   9.30 t/s
1.18.596.099 I slot print_timing: id  0 | task 0 | n_decoded =    438, tg =  12.02 t/s, tg_3s =  13.01 t/s
1.21.876.141 I slot print_timing: id  0 | task 0 | n_decoded =    478, tg =  12.03 t/s, tg_3s =  12.19 t/s
1.23.956.993 I slot print_timing: id  0 | task 0 | prompt eval time =   20023.89 ms /  1091 tokens (   18.35 ms per token,    54.48 tokens per second)
1.23.956.999 I slot print_timing: id  0 | task 0 |        eval time =   41800.92 ms /   509 tokens (   82.12 ms per token,    12.18 tokens per second)
1.23.957.000 I slot print_timing: id  0 | task 0 |       total time =   61824.81 ms /  1600 tokens
1.23.957.001 I slot print_timing: id  0 | task 0 |    graphs reused =        150
1.23.957.005 I slot print_timing: id  0 | task 0 | draft acceptance = 0.59046 (  359 accepted /   608 generated), mean acceptance length =  3.36, acceptance rate per position = (0.770, 0.664, 0.507, 0.421)
1.23.957.033 I statistics        draft-mtp: #calls(b,g,a) =    1    152    152, #gen drafts =    152, #acc drafts =   117, #gen tokens =    608, #acc tokens =   359, #mean acc len = 3.36, #acc rate/pos = (0.770, 0.664, 0.507, 0.421), dur(b,g,a) = 0.002, 4111.214, 0.303 ms
```

2 nd run

```
2.33.754.511 I slot print_timing: id  0 | task 157 | n_decoded =    102, tg =  15.60 t/s, tg_3s =  15.60 t/s
2.36.976.398 I slot print_timing: id  0 | task 157 | n_decoded =    150, tg =  15.37 t/s, tg_3s =  14.90 t/s
2.40.163.759 I slot print_timing: id  0 | task 157 | n_decoded =    186, tg =  14.37 t/s, tg_3s =  11.29 t/s
2.40.441.226 I reasoning-budget: deactivated (natural end)
2.43.180.768 I slot print_timing: id  0 | task 157 | n_decoded =    221, tg =  13.84 t/s, tg_3s =  11.60 t/s
2.46.261.529 I slot print_timing: id  0 | task 157 | n_decoded =    261, tg =  13.70 t/s, tg_3s =  12.98 t/s
2.49.408.309 I slot print_timing: id  0 | task 157 | n_decoded =    304, tg =  13.70 t/s, tg_3s =  13.66 t/s
2.52.222.511 I slot print_timing: id  0 | task 157 | prompt eval time =     986.43 ms /    19 tokens (   51.92 ms per token,    19.26 tokens per second)
2.52.222.516 I slot print_timing: id  0 | task 157 |        eval time =   25005.83 ms /   351 tokens (   71.24 ms per token,    14.04 tokens per second)
2.52.222.517 I slot print_timing: id  0 | task 157 |       total time =   25992.25 ms /   370 tokens
2.52.222.518 I slot print_timing: id  0 | task 157 |    graphs reused =        244
2.52.222.522 I slot print_timing: id  0 | task 157 | draft acceptance = 0.65206 (  253 accepted /   388 generated), mean acceptance length =  3.61, acceptance rate per position = (0.784, 0.711, 0.598, 0.515)
2.52.222.545 I statistics        draft-mtp: #calls(b,g,a) =    2    249    249, #gen drafts =    249, #acc drafts =   193, #gen tokens =    996, #acc tokens =   612, #mean acc len = 3.46, #acc rate/pos = (0.775, 0.683, 0.542, 0.458), dur(b,g,a) = 0.004, 6566.104, 0.496 ms
```
