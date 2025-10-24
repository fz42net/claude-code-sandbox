# Claude Code Sandbox

A containerized environment for testing and experimenting with Claude Code features in isolation, without affecting your main configuration.

## What is this?

This sandbox provides a Docker-based environment where you can safely test Claude Code's features. Your authentication and configuration persist between sessions, and since the project directory is mounted, you can modify `.claude/` settings without rebuilding the container.

## Features You Can Test

- **Custom Commands**: Create slash commands in `.claude/commands/` to automate repetitive tasks
- **Skills**: Build reusable AI skills in `.claude/skills/` for specialized workflows
- **Hooks**: Configure hooks in `.claude/claude.json` for automation
- **Subagents**: Experiment with delegating tasks to specialized Claude agents
- **MCP Servers**: Test Model Context Protocol integrations

## Quick Start

1. **Clone this repository**
   ```bash
   git clone <repository-url>
   cd claude-code-sandbox
   ```

2. **Build and start the container**
   ```bash
   docker compose up -d
   ```

3. **Enter the container**
   ```bash
   docker compose exec claude-code-sandbox zsh
   ```

4. **Login to Claude Code** (first time only)
   ```bash
   claude
   # Follow the authentication prompts
   ```

5. **Start experimenting!**
   - Modify `.claude/commands/`, `.claude/skills/`, or `.claude/claude.json`
   - Changes take effect immediately - no rebuild needed
   - Exit the container with `exit`, your auth persists for next time

## Repository Structure

```
.claude/
├── commands/     # Custom slash commands
├── skills/       # Reusable AI skills
└── claude.json   # Configuration and hooks (create as needed)
```

## Learn More

For comprehensive documentation on Claude Code features:
https://docs.claude.com/en/docs/claude-code
