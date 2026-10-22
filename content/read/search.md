---
title: Search
parent: Read / search
nav_order: 1
permalink: /read/search/
---

# Search

Use `query` for full-text search across a resource.

## Parameter specification

`query` is an **object** with these keys:

| Key | Type | Meaning |
|-----|------|---------|
| `value` | string | Search string (required). Supports the syntax below. |
| `fields` | array | Optional list of fields to search (defaults depend on the resource) |
| `operator` | string | How spaces in `value` combine: `AND` or `OR` (default `OR`) |

## Basic search

Search for reports that mention `cholera`:

{% include api-call.html
  url="https://api.reliefweb.int/v2/reports?appname=REPLACE-WITH-APP-NAME"
  body='{
  "query": {
    "value": "cholera"
  },
  "profile": "list",
  "limit": 5,
  "sort": ["date:desc"]
}' %}

Search for reports whose title contains both `flash` and `appeal`:

{% include api-call.html
  url="https://api.reliefweb.int/v2/reports?appname=REPLACE-WITH-APP-NAME"
  body='{
  "query": {
    "value": "flash appeal",
    "fields": ["title"],
    "operator": "AND"
  },
  "profile": "list",
  "limit": 5
}' %}

## Query string syntax

The `query.value` string supports phrases, field prefixes, booleans, wildcards, ranges, and boosting (similar to Elasticsearch `query_string` syntax).

### Phrases and proximity

```text
"climate change"
"food security crisis"~3
title:"flash appeal"~2
```

Content inside valid double quotes is preserved, including special characters.

### Field queries

```text
title:humanitarian
country:Syria
date:[2024-01-01 TO 2024-12-31]
_exists_:file.url
```

Unknown field names are ignored (the colon is treated as a space).

### Fuzzy and wildcards

```text
humanitarin~
climat* change
earth?uake
title:report*
```

Avoid wildcards on date fields.

### Ranges

Inclusive `[min TO max]`, exclusive `{min TO max}`, and mixed brackets:

```text
date:[2024-01-01 TO 2024-12-31]
population:[1000000 TO *]
age:>=10
date:>2024-01-01
```

### Boolean operators

`AND`, `OR`, `NOT` (also `&&`, `||`, `!`). Prefix `+` (must) and `-` (must not) when they start a term:

```text
(Syria OR Yemen) AND crisis
title:test +required -excluded
drought AND food security OR famine
```

### Boosting

```text
crisis^3 humanitarian
title:"situation report"^2 OR sitrep
```

### Grouping

```text
title:(natural disaster) AND (country:Philippines OR country:Indonesia)
```

### Example API call

Search for reports about `cholera` or `"acute watery diarrhoea"` in `Yemen`:

{% include api-call.html
  url="https://api.reliefweb.int/v2/reports?appname=REPLACE-WITH-APP-NAME"
  body='{
  "query": {
    "value": "(cholera OR \"acute watery diarrhoea\") AND country:Yemen",
    "operator": "AND"
  },
  "profile": "list",
  "limit": 5
}' %}

### Tips

- Use field names from [Resources](/read/resources/).
- Quote phrases that contain special characters.
- Close quotes and parentheses deliberately. The parser is lenient, but well-formed queries are more predictable.
- Fields marked `exact` support a `.exact` suffix (for example `source.shortname.exact`). For exact matching with **filters**, see [Filter](/read/filtering/).

**Next:** [Filter](/read/filtering/)
