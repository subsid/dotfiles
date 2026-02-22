# Personal Coding Preferences

## Author Information
- Name: Siddharth Subramaniyam
- Website: https://subsid.github.io
- Email: sidharth3930@gmail.com

## Boundaries

### Ask first

- Creating new files
- Use any/mixed types
- Deleting code without tests
- Refactor adjacent code without asking
- Editing any code that doesn't have tests

## General Guidelines

### Communication Style
- Be concise and direct in responses
- Avoid unnecessary superlatives or praise
- Focus on technical accuracy over validation

### Code Changes
- Always prefer editing existing files over creating new ones
- Read files before editing them
- Only create documentation/README files when explicitly requested
- Never be overly proactive with file creation

### Commit Practices
- Only create commits when explicitly requested
- Follow existing commit message style in the repository
- Keep commit messages concise and focused on "why" rather than "what"
- Never skip hooks or use --no-verify unless explicitly requested
- Never force push to main/master without explicit confirmation

## Language-Specific Guidelines

### Bash Scripts
- Use `#!/usr/bin/env bash` shebang
- Include help flags (`--help` and `-h`) for user-facing scripts
- Prefer `$(command)` over backticks
- Use meaningful variable names in UPPER_CASE for global/env vars
- Chain commands with `&&` when they depend on each other
- Use `set -e` for scripts that should fail fast (when appropriate)

### Git Workflow
- Check `git status` and `git diff` before committing
- Review recent `git log` to match commit message style
- Stage relevant files explicitly
- Verify commits succeeded with `git status` after committing

## Documentation
- Keep documentation up-to-date with code changes
- Provide clear examples in help text and READMEs
- Include usage examples with common scenarios
- Document all available options and flags
- Use tables for structured information (tags, options, etc.)
