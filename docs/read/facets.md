---
title: Break down results
parent: Read / search
nav_order: 5
permalink: /read/facets/
---

# Break down results

Get counts broken down by a field, for example how many jobs per country. In the API these are `facets`.

Set `"limit": 0` on the main request when you only need facets, not result rows. For a single total of all matches (`totalCount`), see [Sort and paginate](/read/sorting-and-pagination/).

## Parameter specification

`facets` is an **array** of objects. Keys per facet:

| Key | Type | Meaning |
|-----|------|---------|
| `field` | string | Date, category, or status field; see [Resources](/read/resources/) |
| `name` | string | Label when faceting the same field more than once |
| `limit` | integer | Terms to return for non-date facets (default 10) |
| `sort` | string | `{type}:{direction}` where type is `count` or `value`, direction `asc` or `desc` (default `count:desc`) |
| `filter` | object | Extra [filter](/read/filtering/) applied only to this facet |
| `interval` | string | For dates: `year`, `month`, `week`, or `day` |
| `scope` | string | `default` (after global query+filter), `query` (ignore global filter), or `global` (ignore both) |

## Top countries for jobs

Count jobs by country (top 20); omit result rows (`limit: 0`):

{% include api-call.html
  url="https://api.reliefweb.int/v2/jobs?appname=REPLACE-WITH-APP-NAME"
  body='{
  "limit": 0,
  "facets": [
    {
      "field": "country",
      "limit": 20
    }
  ]
}' %}

Example response (abbreviated):

```json
{
  "totalCount": 15234,
  "count": 0,
  "data": [],
  "embedded": {
    "facets": {
      "country": {
        "data": [
          { "value": "South Sudan", "count": 412 },
          { "value": "Yemen", "count": 387 },
          { "value": "Syrian Arab Republic", "count": 301 }
        ],
        "missing": 12,
        "type": "term"
      }
    }
  }
}
```

## Sort facet terms

Count reports by country, rarest (smallest counts) first (10 terms):

{% include api-call.html
  url="https://api.reliefweb.int/v2/reports?appname=REPLACE-WITH-APP-NAME"
  body='{
  "limit": 0,
  "facets": [
    {
      "field": "country",
      "sort": "count:asc",
      "limit": 10
    }
  ]
}' %}

## Date intervals

Facet `limit` does not apply to date intervals. Restrict with a facet `filter` if needed.

Count reports by year created:

{% include api-call.html
  url="https://api.reliefweb.int/v2/reports?appname=REPLACE-WITH-APP-NAME"
  body='{
  "limit": 0,
  "facets": [
    {
      "field": "date.created",
      "interval": "year"
    }
  ]
}' %}

Count reports by month created in 2025:

{% include api-call.html
  url="https://api.reliefweb.int/v2/reports?appname=REPLACE-WITH-APP-NAME"
  body='{
  "limit": 0,

  "facets": [
    {
      "field": "date.created",
      "interval": "month",
      "filter": {
        "field": "date.created",
        "value": {
          "from": "2025-01-01T00:00:00+00:00",
          "to": "2025-12-31T23:59:59+00:00"
        }
      }
    }
  ]
}' %}

## Scope

Use `scope` when a global `query` or `filter` should not apply to a facet:

- **default**: after global `query` and `filter`
- **query**: ignore global `filter`
- **global**: ignore global `query` and `filter`

Name facets with `name` when faceting the same field more than once or comparing scopes side by side.

**Next:** [Get one item](/read/get-item/)
