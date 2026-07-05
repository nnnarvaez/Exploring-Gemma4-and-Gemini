# Technical Report: Gemma 4 Tool Calling Implementation and Template Conflicts
Gemma4 was trained in a  tool call format different from OpenAI standard, Google provided a `jinja` template that expects the OpenAI format, Gemma4 struggles to adhere to the format. 


## Overview
This report identifies a specific problem regarding tool calling in the Gemma 4 model architecture when integrated with standard inference servers (llama-server) and common code harnesses (Hermes, Pi Agent, Opencode). 

The core issue is a mismatch between Gemma 4’s native training format and the OpenAI-style JSON schemas expected by most modern LLM harnesses. Using standard configurations results in dropped tool outputs or reasoning loops.


---

## Problem: Syntax Strictness
Gemma 4 was trained on a specific, strict syntax for tool calls that differs from the OpenAI standard. While many harnesses use generic tool call syntax to maintain multi-model compatibility, this breaks Gemma 4's logic. 

**Native Format:**
The model expects and handles the following structure natively:

```
<|tool_call>call:execute_shell{command:<|\"|>your_bash_command_here<|\"|>}<tool_call|>
```

**Findings:**
*   Gemma 4 is highly sensitive to this format. Using it removes approximately 90% of reasoning loops and failed calls.
*   When forced to use OpenAI-style JSON, the model frequently fails by dropping quotes around the `command` key or malforming the JSON structure entirely.
*   The complexity of the OpenAI format is a problem for Gemma 4; it was not optimized for it.

**Reference:** [Google AI Dev - Function Calling Gemma 4](https://ai.google.dev/gemma/docs/capabilities/text/function_calling_gemma4)

## System Prompt example for native tool_call format

This prompt shown good results along the proper python code

```
# === SYSTEM TOOL SPECIFICATION ===
You have access to an automated system shell tool. When a task requires execution, you must output a structured call block natively using the exact syntax below.

    CRITICAL: Never wrap the <|tool_call> block itself in markdown code blocks or backticks. Do not add conversational text before or after the block during a tool call turn.

    Available Tools:
    1. Shell Command Execution:
       <|tool_call>call:execute_shell{command:<|"|>your_bash_command_here<|"|>}<tool_call|>

    **Example Tool Call Output:**
    If you need to view files in a directory, output exactly:
    <|tool_call>call:execute_shell{command:<|"|>ls -la<|"|>}<tool_call|>
```

Adapt as needed


---

## Problem: Jinja Template Filtering
Using the native tool call will lead to a new problem, with the interaction between `llama-server` and standard Jinja templates (including the Google provided template and those used by popular GGUF conversions like Unsloth and HauhauCS). 

Analysis of common templates (specifically around line 217) reveals that any message with `role: "tool"` is skipped entirely unless it follows a specific OpenAI-style `tool_calls` array.

**Technical Breakdown:**
1.  The assistant produces the native sentinel string (`<|tool_call>...`) as plain content, not inside a `tool_calls` field.
2.  Because there is no `tool_calls` array in the preceding message, the template's forward-scan branch (lines 270–314) never triggers.
3.  The subsequent tool output (the result of the command) hits the filter at line 217 (`if message['role'] != 'tool'`). Since it is a tool role and doesn't meet the forward-scan criteria, the content is rendered as nothing.

**Result:** The model never sees the result of its own tool call. It is effectively "blind" to the output.

---

## Solutions and Workarounds

### Short-Term Workaround (Role Hacking)
To bypass the Jinja filtering immediately without rewriting templates, change the role of the tool output from `tool` to `user`. 
*   **Why it works:** The `user` role is not filtered by the `!= 'tool'` check. This forces the result into the prompt, allowing the model to see the output and proceed.

### Long-Term Solutions
1.  **Custom Jinja Templates:** Load a specific Jinja template designed for Gemma 4's native tool call format rather than using the default OpenAI-compatible ones provided.
2.  **Native Tool Definition:** Instead of trying to force the model into an OpenAI wrapper, ask your harness to code the tools specifically using the `<|tool_call>` native format for Gemma4.
    This is more achievable than fine-tuning a model to handle complex JSON structures it wasn't built for.

---

## Template Verification
To verify the templates currently being used by your GGUF files and identify discrepancies between the model you are using and Google’s official versions, use the following command:

```bash
curl -s http://localhost:8080/props | python3 -c "import json,sys; print(json.load(sys.stdin)['chat_template'])" > gemma4_us.jinja
```
### Not that is matters as Google trained Gemma4 in a format and provided a jinja template in OpenAI format which is different. 

https://huggingface.co/google/gemma-4-12B-it-qat-q4_0-unquantized/blob/main/chat_template.jinja

**Note on Versions:** There are minimal differences between HauhauCS and the current Google official template regarding audio/image parsing, the Unsloth version currently corresponds to the latest Google release. 
