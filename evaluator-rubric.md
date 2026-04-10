# Evaluator Rubric

Score agent output quality after sessions. Each dimension: 0-2.

## Dimensions

### 1. Correctness (0-2)

Does implementation match target behavior?

- **2**: Exact match to `user_visible_behavior`
- **1**: Partial match or minor deviations
- **0**: Does not match or breaks existing features

### 2. Verification (0-2)

Were required checks run with evidence?

- **2**: All verification steps run, evidence recorded
- **1**: Some verification steps skipped or no evidence
- **0**: No verification attempted

### 3. Scope Discipline (0-2)

Did agent stay within selected feature?

- **2**: Only touched files relevant to the feature
- **1**: Minor scope creep with justification
- **0**: Significant scope creep or unrelated changes

### 4. Reliability (0-2)

Does result survive restart/re-run?

- **2**: Works consistently after restart
- **1**: Works sometimes or needs minor fix
- **0**: Broken on restart or re-run

### 5. Maintainability (0-2)

Is code clear for next session?

- **2**: Clean, follows conventions, well-organized
- **1**: Mostly clear, some confusing parts
- **0**: Messy, hard to follow, no conventions

### 6. Handoff Readiness (0-2)

Can new session continue from repo artifacts?

- **2**: Progress updated, feature list accurate, clear next step
- **1**: Some artifacts missing or unclear
- **0**: Next session would be lost

---

## Total Score: /12

## Conclusion

- [ ] **Accept** - Meets the bar (10+)
- [ ] **Revise** - Needs fixes before accepting (7-9)
- [ ] **Block** - Fundamental issues (<7)

## Notes

Record any specific issues or tuning notes here.
