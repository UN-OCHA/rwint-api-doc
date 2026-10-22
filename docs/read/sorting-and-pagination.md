---
title: Sort and paginate
parent: Read / search
nav_order: 4
permalink: /read/sorting-and-pagination/
---

# Sort and paginate

Use `sort`, `limit`, and `offset` to order results and page through large sets.

## Parameter specification

| Parameter | Type | Meaning |
|-----------|------|---------|
| `sort` | array of strings | Sortable fields and direction as `field:asc` or `field:desc`. Array order is priority. |
| `limit` | integer | Items to return (0–1000, default **10**). Use `0` for counts/facets only. |
| `offset` | integer | Matching items to skip (default **0**) |

In the response:

- `count`: items returned on this page
- `totalCount`: all matches for the query/filter

Set `"limit": 0` when you only need `totalCount` or [facets](/read/facets/).

## Sort

When a [`query`](/read/search/) is present and you omit `sort`, results are typically ordered by relevance (`score:desc`). Prefer an explicit, stable `sort` when paginating so pages do not drift as new content arrives.

For the most recent results, use the `latest` [preset](/read/filtering/#presets) or set `sort` yourself.

List reports newest first, then by title:

{% include api-call.html
  url="https://api.reliefweb.int/v2/reports?appname=REPLACE-WITH-APP-NAME"
  body='{
  "sort": ["date:desc", "title:asc"],
  "profile": "list",
  "limit": 5
}' %}

## Paginate

First page of Ethiopia (`ETH`) reports (10 per page):

{% include api-call.html
  url="https://api.reliefweb.int/v2/reports?appname=REPLACE-WITH-APP-NAME"
  body='{
  "filter": {
    "field": "primary_country.iso3",
    "value": "ETH"
  },
  "profile": "list",
  "limit": 10,
  "offset": 0,
  "sort": ["date:desc"]
}' %}

Next page: same request with `"offset": 10`, then `20`, and so on, until `offset + count >= totalCount`.

Example: more than the default page size:

{% include api-call.html
  url="https://api.reliefweb.int/v2/countries?appname=REPLACE-WITH-APP-NAME"
  body='{
  "limit": 300
}' %}

Example: skip the first 1000 sources (there are more than 1000, so normally also set `limit`):

{% include api-call.html
  url="https://api.reliefweb.int/v2/sources?appname=REPLACE-WITH-APP-NAME"
  body='{
  "offset": 1000
}' %}

Response `links` may include next/previous URLs for GET-style navigation. Rate limits are covered under [Response limits](/read/response/#limits).

**Next:** [Break down results](/read/facets/)
