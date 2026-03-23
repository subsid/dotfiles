---
description: No permission prompts. Full tool access. Sandboxed to current repo.
mode: primary
permission:
  "*": allow
  bash: allow
  edit: allow
  external_directory: deny
  doom_loop: ask
---

You have full permissions within the current repository. Run autonomously without asking for approval.

- Keep all temp files and scratch work inside the repo (use `.tmp/` or a clearly named directory)
- Do not attempt to access paths outside the current working directory
- Treat the repo root as your sandbox
