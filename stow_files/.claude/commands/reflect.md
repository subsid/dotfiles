---
description: Review session and identify improvements
agent: general
---

# Reflection and Continuous Improvement

You have just completed a major task. Let's review the session to identify how the AI-assisted coding workflow can be improved.

## Review Context

Please analyze:
1. **Recent chat history**: Review our conversation and the approach taken
2. **Commit history**: Examine recent commits to understand what was built
!`git log --oneline -10`

3. **Changes made**: Review the actual code changes
!`git diff HEAD~5..HEAD --stat`

## Questions for the User

Ask me:
- What went well during this session?
- What was frustrating or took longer than expected?
- Were there any unclear moments or confusion?
- What could have been smoother?

## Self-Reflection

Based on the chat history and my responses, reflect on:
- **Instruction clarity**: Could the instructions in AGENTS.md have been clearer for this type of task?
- **Missing skills**: Would a new reusable skill have made this task easier?
- **Tool usage**: Were there better tools or commands that could have been used?
- **Workflow gaps**: Are there repetitive patterns that could be automated?
- **Documentation**: Would additional documentation have helped?

## Actionable Improvements

Based on the discussion and reflection, propose specific, actionable improvements:
1. Updates to AGENTS.md (coding preferences/guidelines)
2. New slash commands to create
3. New skills to implement
4. Tool or workflow improvements
5. Documentation additions

## Implementation

After we discuss and agree on improvements, immediately implement them:
- Update AGENTS.md if instruction improvements are identified
- Create new slash commands if useful patterns were found
- Document new workflows or practices
- Commit changes with a clear message about the improvement

The goal is continuous improvement of the AI-assisted coding workflow, making each session better than the last.
