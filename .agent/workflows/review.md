---
description: Review code and project files against Flutter best practices and experienced developer standards.
---

1. **Read Rules**:
   - Use `read_url_content` to fetch the latest rules from `https://raw.githubusercontent.com/flutter/flutter/refs/heads/main/docs/rules/rules.md`.
   - Adopt the persona of an expert Senior Flutter Developer.

2. **Analyze**:
   - Analyze the current codebase or the specific files mentioned in the user's request.
   - Use `dart-mcp-server` tools like `analyze_files` to find lint errors and static analysis issues.
   - Use `grep_search` or `view_file` to check for deeper architectural or stylistic issues mentioned in the rules (e.g., proper state management, file structure, naming conventions).
   - Look for opportunities to apply "experienced developer" insights, such as code maintainability, scalability, and performance optimizations.

3. **Report & Plan**:
   - Create a detailed report of findings.
   - For each finding, cite the specific rule or principle being violated from the fetched rules or general best practices.
   - Propose a plan to fix these issues. 
   - **CRITICAL**: Do NOT execute any fixes yet. The goal of this workflow is to review and plan.
   - Present the plan clearly to the user.
   - Explicitly state: "I have completed the review. Please approve the plan above before I proceed with any changes."
   - Stop execution here and wait for the user's response in the next turn.
