---
title: Response, limits, and errors
parent: Read / search
nav_order: 8
permalink: /read/response/
---

# Response, limits, and errors

## Successful result

A successful JSON body includes:

| Field | Meaning |
|-------|---------|
| `href` | URL of the current request |
| `time` | Milliseconds to compute the response |
| `links` | Navigation links (`self`, and often `next` / previous for lists) |
| `totalCount` | Total matches for the query/filter (may be larger than this page) |
| `count` | Number of items in **this** response (≤ `limit`) |
| `data` | Array of result items |
| `embedded.facets` | Present when facets were requested |

Each `data[]` item typically has:

| Field | Meaning |
|-------|---------|
| `id` | ReliefWeb id (site: `https://reliefweb.int/node/{id}` for reports, jobs, training) |
| `fields` | Selected fields from `profile` / `fields` (may include `uuid`) |
| `score` | Relevance when a full-text [`query`](/read/search/) was used |
| `href` | Item API URL. See [Get one item](/read/get-item/). |

List one report with the `list` profile:

{% include api-call.html
  url="https://api.reliefweb.int/v2/reports?appname=REPLACE-WITH-APP-NAME"
  body='{
  "profile": "list",
  "limit": 1
}' %}

Example response (abbreviated):

```json
{
  "href": "https://api.reliefweb.int/v2/reports?appname=REPLACE-WITH-APP-NAME",
  "time": 12,
  "totalCount": 842103,
  "count": 1,
  "data": [
    {
      "id": 1082221,
      "score": 1,
      "href": "https://api.reliefweb.int/v2/reports/1082221",
      "fields": {
        "title": "Example situation report for Country X",
        "url": "https://reliefweb.int/node/1082221",
        "date": {
          "created": "2024-06-06T01:00:00+00:00"
        },
        "primary_country": {
          "name": "South Sudan",
          "iso3": "SSD"
        },
        "source": [
          {
            "name": "Example Organization"
          }
        ]
      }
    }
  ]
}
```

Responses also include `links` (self / next / previous) unless you set [`slim`](#slim-and-verbose). For paging, see [Sort and paginate](/read/sorting-and-pagination/).

## Slim and verbose
{: #slim-and-verbose }

| Parameter | Meaning |
|-----------|---------|
| `slim` | Set to `1` to omit hypermedia links from the result |
| `verbose` | Set to `1` to add a `details` section that echoes how the request was interpreted |

Return two reports without hypermedia links (`slim`):

{% include api-call.html
  url="https://api.reliefweb.int/v2/reports?appname=REPLACE-WITH-APP-NAME"
  body='{
  "slim": 1,
  "limit": 2
}' %}

## Limits
{: #limits }

- Maximum **1000** entries returned per call
- Maximum **10000** calls per day

If these limits block a legitimate use case, [contact us](https://reliefweb.int/contact).

## Errors
{: #errors }

Common cases:

- **Missing `appname`**: HTTP 400. Get one under [Appname](/#appname).
- **Unapproved `appname`**: HTTP 403.
- Invalid `limit` (valid range 0–1000)
- Invalid date range (must be ISO 8601; encode `+` as `%2B` in GET URLs)
- Invalid `query` keys (valid: `value`, `operator`, `fields`; `fields` must be an array)

**Next:** [Resources](/read/resources/)
