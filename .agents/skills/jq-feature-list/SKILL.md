---
name: jq-feature-list
description: Use when you need to filter, search, or query feature_list.json efficiently. Provides jq commands for common queries like finding by status, priority, area, or searching text.
---

# JQ Feature List Queries

## Overview

Quick jq commands to filter and query `feature_list.json` without reading the entire file.

## Common Queries

### List all features with key fields
```bash
jq '.features[] | {id, priority, status, title}' feature_list.json
```

### Filter by status
```bash
jq '.features[] | select(.status == "not_started")' feature_list.json
jq '.features[] | select(.status == "in_progress")' feature_list.json
jq '.features[] | select(.status == "passing")' feature_list.json
```

### Filter by priority (highest first)
```bash
jq '.features | sort_by(.priority) | .[]' feature_list.json
jq '.features | sort_by(.priority) | .[] | {priority, id, status, title}' feature_list.json
```

### Filter by area
```bash
jq '.features[] | select(.area == "core")' feature_list.json
```

### Find highest priority not_started feature
```bash
jq '.features | sort_by(.priority) | .[] | select(.status == "not_started" or .status == "in_progress") | {priority, id, status, title}' feature_list.json | head -20
```

### Search text in title/notes/user_visible_behavior
```bash
jq '.features[] | select(.title | test("search_term"; "i"))' feature_list.json
jq '.features[] | select(.notes | test("search_term"; "i"))' feature_list.json
jq '.features[] | select(.user_visible_behavior | test("search_term"; "i"))' feature_list.json
```

### Count by status
```bash
jq '.features | group_by(.status) | .[] | {status: .[0].status, count: length}' feature_list.json
```

### Get single feature by id
```bash
jq '.features[] | select(.id == "feature-id")' feature_list.json
```

### Compact output (one line per feature)
```bash
jq -c '.features[] | {id, priority, status, title}' feature_list.json
```

### Table format
```bash
jq -r '.features[] | [.priority, .status, .id, .title] | @tsv' feature_list.json | column -t -s $'\t'
```

## Combined Filters

### High priority features that are not started
```bash
jq '.features | sort_by(.priority) | .[] | select((.priority <= 5) and (.status == "not_started"))' feature_list.json
```

### Features with no evidence recorded
```bash
jq '.features[] | select(.evidence == null) | {id, status}' feature_list.json
```

## Tips

- Use `-c` for compact one-line output when scanning many items
- Use `| head -N` to limit output
- Use `test("pattern"; "i")` for case-insensitive regex matching
- Chain with `select()` for multiple conditions: `select(.status == "in_progress" and .priority < 5)`
