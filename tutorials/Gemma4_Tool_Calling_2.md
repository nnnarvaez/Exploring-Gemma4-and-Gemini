# Technical Report: Gemma 4 Tool Calling Implementation and Template Conflicts

## Overview
This report identifies a systemic architectural conflict between Gemma 4’s native fine-tuned token structures, `llama-server` capabilities, and the standard implementation methods used in common orchestrators.

While it is widely assumed that Gemma 4 "struggles" with tool calling or that developers must choose between writing custom regex parsers or hacking `role: "user"` payloads, raw server logs and template execution analysis reveal that recent `llama-server` builds possess full native handling for Gemma 4's internal delimiters (<|"|>).

## The Root Cause: Manual String-Matching vs. Native Tokens
The common point of failure when deploying **Gemma 4 12B QAT** stems from treating tool calling as a string-copying exercise written into a text system prompt, rather than an array of structured objects passed directly to the inference engine.

```text
                  ┌──────────────────────────────────────────────┐
                  │          YOUR CURRENT BOT ARCHITECTURE        │
                  │   Text Prompt ──> Regex Parser ──> String Match │
                  └───────────────────────┬──────────────────────┘
                                          │  (Delimiter Mismatches: <|"|> vs <|"|>)
                                          ▼
                  ┌──────────────────────────────────────────────┐
                  │              GOOGLE'S INTENDED FLOW          │
                  │   Tools Array ──> Native Jinja ──> JSON AST  │
                  └──────────────────────────────────────────────┘
```

When forced to parse manual string blocks, the system introduces minor formatting discrepancies that degrade the model's performance:

1. **The Delimiter Trap:** The exact token sequence Gemma 4 expects is `<|"|>` (a single straight quote between two pipes, 5 characters, zero backslashes). Systems hand-rolling regex often inject escaped strings (`<|\"|>`), mixed double quotes (`<|""|>`), or raw braces, causing the model's inner reasoning mechanism to enter immediate repetition loops.
2. **Context Blindness:** When the assistant outputs a manual string like `<|tool_call|>...`, `llama-server` sees it as a flat string of content. When the application tries to inject the response back under `role: "tool"`, the underlying Jinja template (`chat_template.jinja`) drops the message entirely because it looks for a populated, structured `tool_calls` object in the chat history to open the forward-scanning compilation branch.

## Solutions & Implementation Paths

### Phase 1: Quick & Dirty Workarounds (The Legacy Path)
If your architecture is restricted to plain-text completions and cannot pass structured fields to the server endpoint, you must align every single regex boundary and prompt example to the strict 5-character token.

#### Corrected System Prompt Specification
```markdown
# === SYSTEM TOOL SPECIFICATION ===
You have access to an automated system shell tool. When a task requires execution, you must output a structured call block natively using the exact syntax below.

CRITICAL: Never wrap the <|tool_call|> block itself in markdown code blocks or backticks. Do not add conversational text before or after the block during a tool call turn.

Available Tools:
1. Shell Command Execution:
   <|tool_call|>call:execute_shell{command:<|"|>your_bash_command_here<|"|><|tool_call|>

**Example Tool Call Output:**
If you need to view files in a directory, output exactly:
<|tool_call|>call:execute_shell{command:<|"|>ls -la<|"|><|tool_call|>
```

#### Payload Hacking for Output Feeding
Because the template drops native `role: "tool"` inputs if they lack an internal tracker ID, you must masquerade the tool's execution result as a user turn to maintain context history:

```json
[
  {"role": "user", "content": "list files in the tools folder"},
  {"role": "assistant", "content": "<|tool_call|>call:execute_shell{command:<|\"|>ls tools<|\"|><|tool_call|>"},
  {"role": "user", "content": "[TOOL OUTPUT]: tools_executor.py system_prompt.md"}
]
```

### Phase 2: The Proper Solution (Native Structured Tool Calling)
Modern versions of `llama-server` natively expose tool capabilities. Instead of writing text descriptions in a system prompt and checking strings with regex, you completely offload the parsing, delimiter validation, and token compilation to `llama-server` and the model's hardware-level token mechanics.

#### 1. Checking Your Server Capabilities
Verify that your specific binary build supports native object mapping by inspecting the properties endpoint:
```bash
curl -s http://<server_ip>:8080/props | python3 -m json.tool
```
*Look for: `"supports_tool_calls": true` and `"supports_tools": true` inside the `chat_template_caps` dictionary.*

#### 2. The Structured Request Payload
Completely strip out the TOOL MODE rules, syntax strings, and negative enforcement guidelines from your `system_prompt.md`. Pass the function constraints as a standard JSON schema structure inside the payload to `/v1/chat/completions`:

```json
{
  "messages": [
    {"role": "system", "content": "You are Vera, a senior systems engineer."},
    {"role": "user", "content": "list files in the tools folder"}
  ],
  "tools": [
    {
      "type": "function",
      "function": {
        "name": "execute_shell",
        "description": "Run a shell command on the Ubuntu host.",
        "parameters": {
          "type": "object",
          "properties": {
            "command": {
              "type": "string",
              "description": "The exact bash command to execute."
            }
          },
          "required": ["command"]
        }
      }
    }
  ],
  "max_tokens": 512
}
```

#### 3. Handling the Native Response Object
When this structured array is passed, `llama-server` handles the internal compilation using `gemma4_us.jinja` automatically, generating the true `<|tool_call|>declaration:...` block in the engine memory. The model outputs its clean intent, and the server returns a pre-parsed JSON structure.

Your application code can completely delete its complex regex matching logic and handle the execution turn using plain dictionary checks:

```json
{
  "finish_reason": "tool_calls",
  "message": {
    "content": "",
    "tool_calls": [
      {
        "type": "function",
        "function": {
          "name": "execute_shell",
          "arguments": "{\"command\":\"ls tools\"}"
        },
        "id": "tiXANt49hI9sFRvw6npVPEj7jJynMU3O"
      }
    ]
  }
}
```

#### 4. Returning the Execution Output Natively
Because `llama-server` tracks the transaction using an explicit string tracking identifier (`id`), you can now safely use the correct `role: "tool"` convention without the Jinja template dropping the message payload during the context compilation phase:

```json
[
  {
    "role": "assistant",
    "tool_calls": [
      {
        "type": "function",
        "function": {"name": "execute_shell", "arguments": "{\"command\":\"ls tools\"}"},
        "id": "tiXANt49hI9sFRvw6npVPEj7jJynMU3O"
      }
    ]
  },
  {
    "role": "tool",
    "name": "execute_shell",
    "tool_call_id": "tiXANt49hI9sFRvw6npVPEj7jJynMU3O",
    "content": "tools_executor.py system_prompt.md"
  }
]
```

## Summary Recommendation
For production stability with **Gemma 4 12B QAT**, developers should migrate away from manual text prompting for tool definitions. Utilizing the backend server's native JSON schema pipeline removes manual delimiter errors entirely, leverages the model's hardware-optimized token paths, and guarantees clean, deterministic execution handling.
