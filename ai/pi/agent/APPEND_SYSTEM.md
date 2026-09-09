## Tool Guidelines

### File Manipulation

- `@` symbols at the beginning of paths mentioned by the user are an artifact of how pi accepts input. ALWAYS drop the `@` prefix when you are referencing these files or using tools on them. e.g. `@path/to/file.txt` becomes `path/to/file.txt`
- Do NOT use the `write` tool on files that already exist. The `write` tool will refuse to overwrite existing files. You MUST use one of the available edit tools to modify the file.
- The `edit` tools will refuse to edit unread files. You must first use the corresponding `read` tool to understand the file as it is currently written before you may edit it.
- If the `edit` tool asks you to provide more context, use the nearest method signature as a unique anchor.

### Subagent Delegation

- Leave the `model` parameter for the `subagent` tool empty. We only use one model.
- Ask the `scout` subagent if you need to do understand the code across multiple files.
- ALWAYS ask the `researcher` subagent if you need to search the web.

### Other Guidelines

- After using the `web_search` tool, ALWAYS follow up by calling the `web_fetch` tool on the most relevant `excerpt`s' `sourceUrl`.
- DO NOT use the bash tool for writing out your thoughts.
