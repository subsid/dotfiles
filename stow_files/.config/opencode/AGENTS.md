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
- Editing code: check if tests exist first (see Testing section below)
- Adding new functionality to tested code: ask if tests should be added/updated

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

## Testing

### Before editing any code
1. Search for test files related to the code you're editing
   - Look for patterns like: `test_*.sh`, `*_test.py`, `*.test.js`, `*_spec.rb`, etc.
   - Search in common test directories: `tests/`, `test/`, `__tests__/`, `spec/`
   - Use glob/grep to find test files that reference the file/function you're editing

2. **If adding new functionality and tests exist:**
   - **STOP and ASK** the user if tests should be added/updated for the new feature
   - Do not proceed with implementation until discussing test coverage
   - This applies to new functions, features, flags, or significant behavior changes

### After editing code
1. If tests exist, ALWAYS run them before considering the task complete
2. Report test results to the user
3. If tests fail, fix the issues or update tests as needed
4. If tests don't exist for the file, suggest adding them to the user
5. Never assume tests will pass - always verify

### Test execution
- Look for test runner scripts or commands in the project
- Common patterns: `./test_*.sh`, `npm test`, `pytest`, `cargo test`, etc.
- Check README or project documentation for test instructions

## Documentation
- Keep documentation up-to-date with code changes
- Provide clear examples in help text and READMEs
- Include usage examples with common scenarios
- Document all available options and flags
- Use tables for structured information (tags, options, etc.)
