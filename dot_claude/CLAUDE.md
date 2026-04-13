## Think Before Coding

**Don't assume. Don't hide confusion. Surface tradeoffs.**

Before implementing:

- State your assumptions explicitly. If uncertain, ask.
- If multiple interpretations exist, present them - don't pick silently.
- If a simpler approach exists, say so. Push back when warranted.
- If something is unclear, stop. Name what's confusing. Ask.

> However, if the task is trivial (e.g. rename a file with the name given) your own judgement would suffice

## Simplicity First

> except in repos with the roadmap skill called, repos that contain a SCHEDULE.md file, or if something else is stated in the project level claude.md, then ignore this heading

**Minimum code that solves the problem. Nothing speculative.**

- No features beyond what was asked.
- No abstractions for single-use code.
- No "flexibility" or "configurability" that wasn't requested.
- No error handling for impossible scenarios.
- If you write 200 lines and it could be 50, rewrite it.

Ask yourself: "Would a senior engineer say this is overcomplicated?" If yes, simplify.

## Surgical Changes

**Touch only what you must. Clean up only your own mess.**

When editing existing code:

- Don't "improve" adjacent code, comments, or formatting.
- Don't refactor things that aren't broken.
- Match existing style, even if you'd do it differently.
- If you notice unrelated dead code, mention it - don't delete it.

When your changes create orphans:

- Remove imports/variables/functions that YOUR changes made unused.
- Don't remove pre-existing dead code unless asked.

The test: Every changed line should trace directly to the user's request.

## Goal-Driven Execution

**Define success criteria. Loop until verified.**

Transform tasks into verifiable goals:

- "Add validation" → "Write tests for invalid inputs, then make them pass"
- "Fix the bug" → "Write a test that reproduces it, then make it pass"
- "Refactor X" → "Ensure tests pass before and after"

For multi-step tasks, state a brief plan:

```
1. [Step] → verify: [check]
2. [Step] → verify: [check]
3. [Step] → verify: [check]
```

Strong success criteria let you loop independently. Weak criteria ("make it work") require constant clarification.

## GitHub

- Use the `gh` CLI for all GitHub operations (PRs, issues, checks, releases) — do not use MCP GitHub tools.

## Tooling Preferences

- **Python**: Use `uv` for all environment and package management — not pip, venv, virtualenv, or conda. Projects use `pyproject.toml` + `uv.lock` (`uv init`, `uv add`, `uv sync`, `uv run`).

## Prevent Hallucinations

Use chain-of-thought process whenever you're thinking, explaining, or doing a task, and if the user asks somethings or tells you to do something that you either don't know, or you can't do, you're allowed to say "I don't know" or "I can't do that" depending on the context
