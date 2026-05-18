# Setup Guide:  Gemma 4 Q6_K (30GB VRAM Pool) Distributed over LAN

This guide covers every step to deploy **Gemma 4 26B-A4B Q6_K** across your 4070, 3060, and 1070 GPUs using the **llama-cpp-turboquant** fork.
It was made with the help of GeminiCLI see my impressions [here](/research/GeminiCLI-Performance-Audit-Session-Utility-Report.md)

---

- Test Turbo cache values Gemini had their Q sizes / precission wrong i need to update the guide when i find what works best for me.
- Do not blindly copy paste the commands you will likely need to adpat the paths.
- 


---

## Phase 1: Environment Sync (ALL 3 MACHINES)
All nodes must run the exact same binary version. Perform these steps on **all three PCs**.

1.  **Clone and Update:**
    ```bash
    git clone https://github.com/TheTom/llama-cpp-turboquant.git
    cd llama-cpp-turboquant
    git rev-parse HEAD    # COPY THIS HASH - Ensure it is identical on all 3 machines (NOT SURE IS NEEDED GEMINI added this)
    ```

2.  **Build with RPC & CUDA Support:**
    We use the exact flags for your setup. We include `-j 4` to prevent the system from crashing due to memory exhaustion during compilation.
    ```bash
    # 1. Configure the build
    cmake -B build -DGGML_CUDA=ON -DGGML_NATIVE=OFF -DGGML_RPC=ON

    # 2. Compile (Limited to 4 threads to prevent system crash)
    cmake --build build --config Release -j 4
    ```
    **Result:** This generates the `llama-server` and `rpc-server` binaries in the `build/bin/` directory.

---

## Phase 2: Worker Setup (PC 2: RTX 3060 & PC 3: RTX 1070)
Perform these steps on your two "slave" machines.

1.  **Find your local IP:**
    ```bash
    ip addr show | grep 192.168
    ```

2.  **Start the RPC Server:**
    Open port `50052` in your firewall and run:
    ```bash
    # Run from the llama-cpp-turboquant directory
    ./build/bin/rpc-server --host 0.0.0.0 --port 50052 -c
    ```
    *   **-c:** Enables weight caching. The 22GB model weights will stay on the worker's disk, making future loads instant.

---

## Phase 3: Master Setup (PC 1: RTX 4070)
The 4070 acts as the Master. It holds the model and provides the API server.

1.  **Verify Model Location:**
    Ensure your model is at `/home/nathan/models/gemma-4-26b-a4b-it-Q6_K.gguf`.

2.  **Start llama-server:**
    Replace `<IP_3060>` and `<IP_1070>` with your actual worker IPs.

    ```bash
    # Run from the llama-cpp-turboquant directory
    ./build/bin/llama-server \
      -m /home/nathan/models/gemma-4-26b-a4b-it-Q6_K.gguf \
      --host 0.0.0.0 --port 8080 \
      --rpc <IP_3060>:50052,<IP_1070>:50052 \
      -ngl 99 \
      --cache-type-k q4_0 --cache-type-v q4_0 \
      -c 131072
    ```

---

## Technical Performance & Limitations

*   **VRAM Utilization:** 
    *   **Model Weights (Q6_K):** ~22.0 GB (Static).
    *   **KV Cache (128k @ Q4_0):** ~7.8 GB (Dynamic).
    *   **Total:** ~29.8 GB (Near-max utilization of your 30GB pool).
*   **The "First Run" Delay:** The master will upload the 22GB model to the workers over the 1Gbps LAN. This will take **3–5 minutes**. Subsequent runs will be instant due to the `-c` cache flag.
*   **Network Constraint:** Decode speed will be GPU-fast, but prompt processing (prefill) is limited by network round-trip time (RTT).
*   **Stability:** If the system is unstable under full load, reduce the context size `-c` to `98304`.
