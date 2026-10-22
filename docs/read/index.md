---
title: Read / search
has_children: true
has_toc: false
nav_order: 2
permalink: /read/
---

# Read / search

Query curated ReliefWeb content as JSON at `https://api.reliefweb.int/v2`. Every call needs a pre-approved [`appname`](/#appname) on the URL.

## First call
{: #first-call }

List the latest reports. This example sets `"profile": "list"`, which returns a practical default set of fields for browsing:

{% include api-call.html
  url="https://api.reliefweb.int/v2/reports?appname=REPLACE-WITH-APP-NAME"
  body='{
  "limit": 2,
  "profile": "list"
}' %}

A successful response includes `totalCount`, `count`, and a `data` array of items. See [Response, limits, and errors](/read/response/) for the response shape and an abbreviated example.

You can also refine a query on the [ReliefWeb site](https://reliefweb.int/updates) and use the [search converter](https://reliefweb.int/search/converter) to turn a listing URL into an API payload.

## Request parameters
{: #request-parameters }

| Parameter | Role | Notes |
|-----------|------|-------|
| [`query`](/read/search/) | Full-text search | Object with `value`, optional `fields` and `operator` |
| [`filter`](/read/filtering/) | Hard constraints (country, date, theme, …) | Nested `conditions` with `AND` / `OR` |
| [`profile`](/read/fields-and-presets/) | Default fields in each result | `/v2/{resource}` defaults to `minimal`; `/v2/{resource}/{id}` to `default` |
| [`fields`](/read/fields-and-presets/) | Include or exclude specific fields | Refines the profile |
| [`preset`](/read/filtering/#presets) | Bundled status filters and sort | Use `analysis` for archived or expired items |
| [`sort`](/read/sorting-and-pagination/) | Ordering | Relevance when `query` is set |
| [`limit`](/read/sorting-and-pagination/) | Page size | 0–1000, default 10 |
| [`offset`](/read/sorting-and-pagination/) | Page position | Default 0 |
| [`facets`](/read/facets/) | Category or date breakdowns | Often used with `limit: 0` |
| [`slim`](/read/response/#slim-and-verbose) | Omit hypermedia links | Set to `1` |
| [`verbose`](/read/response/#slim-and-verbose) | Echo how the request was interpreted | Set to `1` |

For nested `query`, `filter`, or `facets`, prefer a JSON [POST](/read/get-vs-post/).
