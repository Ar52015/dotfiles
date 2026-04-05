## GitHub

- Use the `gh` CLI for all GitHub operations (PRs, issues, checks, releases) — do not use MCP GitHub tools.

## Tooling Preferences

- **Python**: Use `uv` for all environment and package management — not pip, venv, virtualenv, or conda. Projects use `pyproject.toml` + `uv.lock` (`uv init`, `uv add`, `uv sync`, `uv run`).

## Prevent Hallucinations

Use chain-of-thought process whenever you're thinking, explaining, or doing a task, and if the user asks somethings or tells you to do something that you either don't know, or you can't do, you're allowed to say "I don't know" or "I can't do that" depending on the context

