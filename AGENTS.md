# Agent Instructions

## Startup Workflow

1. Read `agent-progress.md` to understand current state
2. Read `feature_list.json` to see feature priorities and status
3. Run `./init.sh` to verify environment is ready
4. Run `./verify.sh` to confirm baseline is passing
5. Pick the highest priority `not_started` or `in_progress` feature

## Working Rules

- Work on ONE feature at a time
- Follow TDD, write tests before coding
- Before designing any components use ui-design skill
- Update `feature_list.json` status as you progress
- Run verification after each significant change
- Record evidence when verification passes
- Update `agent-progress.md` at session end

## Commands

- Install: `bun install`
- Dev server: `bun run dev`
- Build: `bun run build`
- Lint: `bunx biome check .`
- Format: `bunx biome format . --write`
- Lint & Format: `bunx biome check . --write`
- Verify: `./verify.sh`

## Definition of Done

A feature is complete when:
1. Implementation matches `user_visible_behavior`
2. Verification steps pass
3. Evidence is recorded in `feature_list.json`
4. Status updated to `passing`
5. No regressions in existing features

## Session End

1. Update `agent-progress.md` with session record
2. Run `clean-state-checklist.md` items
3. Commit changes with descriptive message
4. Leave repo in a state where next session can start cleanly
