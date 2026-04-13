---
name: tmux-sessions
description: Use when you need to run interactive commands like dev servers, background jobs, or long-running processes. Provides tmux commands for session management, output capture, and process control.
---

# Tmux Session Management

## Overview

Use tmux to run interactive commands (dev servers, background jobs) in persistent sessions. This allows checking output, sending input, and managing processes without blocking the agent.

## Quick Reference

### Start a session with a command
```bash
tmux new-session -d -s dev 'bun run dev'
```

### Start with custom name
```bash
tmux new-session -d -s api 'npm run start:api'
tmux new-session -d -s worker 'npm run worker'
```

### List sessions
```bash
tmux list-sessions
tmux ls
```

### Capture/View output
```bash
tmux capture-pane -t dev -p -S -100
```

### Send keys (commands to the session)
```bash
tmux send-keys -t dev 'C-c'
tmux send-keys -t dev 'rs'
```

### Kill a session
```bash
tmux kill-session -t dev
```

### Attach to session (for debugging)
```bash
tmux attach -t dev
```

## Common Workflows

### Start dev server and check it's running
```bash
tmux new-session -d -s dev 'bun run dev'
sleep 3
tmux capture-pane -t dev -p -S -50
```

### Run tests against a running server
```bash
tmux new-session -d -s dev 'bun run dev'
sleep 5
bun test:e2e
tmux kill-session -t dev
```

### Restart a dev server
```bash
tmux kill-session -t dev 2>/dev/null
tmux new-session -d -s dev 'bun run dev'
sleep 3
tmux capture-pane -t dev -p -S -30
```

### Run multiple services
```bash
tmux new-session -d -s frontend 'npm run dev'
tmux new-session -d -s backend 'npm run server'
tmux new-session -d -s db 'docker run -p 5432:5432 postgres'
```

### Check multiple session outputs
```bash
tmux capture-pane -t frontend -p -S -20
tmux capture-pane -t backend -p -S -20
```

### Clean up all sessions
```bash
tmux kill-server
```

## Session Naming Conventions

| Session Name | Use Case |
|--------------|----------|
| `dev` | Main dev server |
| `api` | API server |
| `db` | Database |
| `worker` | Background job worker |
| `test-server` | Test fixture server |

## Useful Flags

| Flag | Meaning |
|------|---------|
| `-d` | Detach immediately (run in background) |
| `-s NAME` | Session name |
| `-t NAME` | Target session |
| `-p` | Print to stdout (with capture-pane) |
| `-S -N` | Scroll back N lines (with capture-pane) |

## Checking Session Health

### Check if session exists
```bash
tmux has-session -t dev 2>/dev/null && echo "running" || echo "not running"
```

### Get process info
```bash
tmux list-panes -t dev -F "#{pane_pid}"
```

## Tips

- Always use `-d` to detach immediately
- Use descriptive session names for clarity
- Kill sessions when done to free resources
- Use `sleep` after starting to allow server startup
- Check output with `capture-pane` before assuming success
- Use `2>/dev/null` when killing sessions that may not exist
