---
title: Get one item
parent: Read / search
nav_order: 6
permalink: /read/get-item/
---

# Get one item

Fetch a single document by ReliefWeb id or UUID:

```
GET /v2/{resource}/{id|uuid}
```

Single-record requests are **GET** (or HEAD) only.

Allowed parameters: [`profile`](/read/fields-and-presets/), [`fields`](/read/fields-and-presets/), [`preset`](/read/filtering/#presets), and [`slim`](/read/response/#slim-and-verbose). Defaults are `preset=minimal` and `profile=default`.

If the item is excluded by the preset (for example an expired job or archived disaster under `minimal`), the API returns **404**. Pass `preset=analysis` on the query string to fetch historical items.

Fetch report `1082221` with the full profile:

{% include api-call.html
  url="https://api.reliefweb.int/v2/reports/1082221?appname=REPLACE-WITH-APP-NAME&profile=full"
  label="GET" %}

Example response (abbreviated):

```json
{
  "href": "https://api.reliefweb.int/v2/reports/1082221?appname=REPLACE-WITH-APP-NAME&profile=full",
  "time": 8,
  "totalCount": 1,
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
          "created": "2024-06-06T01:00:00+00:00",
          "original": "2024-06-05T00:00:00+00:00"
        },
        "source": [
          {
            "name": "Example Organization",
            "shortname": "EO"
          }
        ]
      }
    }
  ]
}
```

Fetch the same report with `list` fields plus `source.name` and `body`:

{% include api-call.html
  url="https://api.reliefweb.int/v2/reports/1082221?appname=REPLACE-WITH-APP-NAME&profile=list&fields[include][]=source.name&fields[include][]=body"
  label="GET" %}

## From search results to full item

1. List with `profile: "list"` to browse.
2. Read `data[].id`, `data[].fields.uuid` (when included), or `data[].href`.
3. Request the item with `profile=full` for detail.

On the website, many items are also at `https://reliefweb.int/node/{id}`.

**Next:** [GET vs POST](/read/get-vs-post/)
