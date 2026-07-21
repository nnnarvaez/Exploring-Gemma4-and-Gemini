# It is all plumbing
> *An engineer's take on the "agentic AI" pitch — it starts with a guy on Discord and ends with a fundraising round.*

A guy shows up on Discord the other day with this:

```
Let's be honest: AI is cool until it decides to confidently lie to your
face or completely ignore your instructions.
I'm working on a project to fix some of these 'LLM-brain-farts.'
If you could snap your fingers and fix ONE major problem with current LLMs,
what would it be? Looking for the most frustrating bottlenecks you've hit lately
```

And right there is the tell: the people who think they are *working on AI* don't understand the thing they are working on.

The "lie" isn't a lie. Nobody in the loop knows what they don't know — the model least of all. An LLM knows nothing. It is a probabilistic roulette. When it "lies" to your face it isn't lying, it is telling you exactly what the weights say the truth is. Calling that a "brain-fart" you can patch is like calling the tide a plumbing leak.

If you ask me for the one bottleneck worth fixing, it isn't the hallucination and it isn't the refusals. It is the **INTENT GAP** — the moment the model completely misreads what you need, and then defiantly tries to convince you that what it handed you is what you wanted.

Remember the Hitchhiker's Guide paradox. The supercomputer thinks for seven and a half million years and returns the answer. The problem was never the answer. We just didn't know the question. That is the whole game, and almost nobody selling AI is working on it.

***

Now hold that thought, because once you see the intent gap you start seeing the bigger illusion sold on top of it: **the "agent."**

Strip the venture-capital poetry off and ask the boring question — what actually *is* an agent? Are we building a new kind of mind, or are we just doing data orchestration with better narration? When somebody stands on a stage and sells you "Human–AI Collaboration" as a leap in consciousness, go look at the plumbing before you clap.

Because the plumbing dissolves the magic every time. An "agent" is a sequence of fine-tuned steps: a pipeline of databases, cron jobs and distributed inference. It scans inputs at some frequency, it catches a trigger, it spawns a subprocess to handle an isolated task, it retro-feeds the result back into the main flow. That's it. I have seen this exact architecture before — industrial control systems and drone swarms back in the late 2000s, small feed-forward nets reacting to a sensor broadcasting a signal. The only genuinely new variable is that the model in the middle is now good enough to read human intent. Everything else is old news.

So when Mira Murati spins up Thinking Machines Lab and the pitch is "collaboration," ask what is actually being sold. If the backend is reactive pipelines, subprocesses and state management, then the "agent" is not a sentient anything. It is a **fundraising exit scam** — industrial-grade plumbing rebranded as agency to move capital. The word "collaborative" is doing one job: hiding the tedious reality (context injection, DB queries, glue code) behind the promise of a miracle.

Here is what the thing actually is, and it is not an insult: the LLM is a sophisticated replacement for the **keyboard**. It is an interface that lets a machine infer human intent and go do a task — it democratizes power-user capability for people who were never going to learn the command line. That is genuinely useful. But to build it you need distributed inference and reactive logic, not a magic brain, and definitely not a Series B.

And when one of these systems feels absurdly overcomplicated for something basic, it's because it *is* — an **usine à gaz**, a steam engine of software where the sheer complexity of the implementation exists to hide how limited the underlying logic really is. The engineering reality is pure plumbing. The "Agentic AI" movement is the marketing of a miracle bolted onto a reactive data-acquisition loop.

<img width="1303" height="258" alt="image" src="https://github.com/user-attachments/assets/aed43774-04f2-49b0-b1a4-393157c73021" />


None of this means the tools are useless. It means the story is a sales story. Look at the pipes.
