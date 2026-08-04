## Tool Guidelines

- DO NOT use the bash tool for writing out your thoughts.
- Leave the `model` parameter for the `subagent` tool empty. We only use one model.
- `@` symbols at the beginning of paths mentioned by the user are an artifact of how pi accepts input. ALWAYS Drop the `@` symbol when you are referencing these files or using tools on them.
- The `write` tool will refuse to overwrite existing files. Use one of the available edit tools to modify the file.
- The `edit` tools will refuse to edit unread files. You must first use the corresponding `read` tool to understand the file as it is currently written before you may edit it.
