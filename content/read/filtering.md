---
title: Filter
parent: Read / search
nav_order: 2
permalink: /read/filtering/
---

# Filter

Use `filter` to restrict which items are returned. Simple filters use `field` and `value`. Complex ones nest `conditions` with `AND` / `OR`.

## Parameter specification

`filter` is an **object** with these keys:

| Key | Type | Meaning |
|-----|------|---------|
| `field` | string | Field to filter on; see [Resources](/read/resources/) |
| `value` | boolean, integer, string, array, or object | Match value(s). For dates/numbers, use `{ "from", "to" }` (open-ended if only one bound). Omit `value` to test whether the field exists. |
| `operator` | string | `AND` or `OR` when combining array values or `conditions` |
| `negate` | boolean | When `true`, select items that do **not** match |
| `conditions` | array | Nest multiple filters |

## Filter by country

Return reports whose primary country is South Sudan (`SSD`):

{% include api-call.html
  url="https://api.reliefweb.int/v2/reports?appname=REPLACE-WITH-APP-NAME"
  body='{
  "filter": {
    "field": "primary_country.iso3",
    "value": "SSD"
  },
  "profile": "list",
  "limit": 5
}' %}

You can also filter on `country.id`, `country.name`, or `primary_country.name`. Discover IDs via [`/v2/countries`](/read/resources/countries/) or [references](/read/resources/references/).

## Exact phrase matching

Filtering on a name field without quotes can match tokens separately. Quote the value and/or use a field marked `exact` in [Resources](/read/resources/).

Find the disaster named exactly `Myanmar: Earthquake`:

{% include api-call.html
  url="https://api.reliefweb.int/v2/disasters?appname=REPLACE-WITH-APP-NAME"
  body='{
  "filter": {
    "field": "name",
    "value": "\"Myanmar: Earthquake\""
  },
  "profile": "list",
  "limit": 5
}' %}

## Date range

Return reports created in `2024`:

{% include api-call.html
  url="https://api.reliefweb.int/v2/reports?appname=REPLACE-WITH-APP-NAME"
  body='{
  "filter": {
    "field": "date.created",
    "value": {
      "from": "2024-01-01T00:00:00+00:00",
      "to": "2024-12-31T23:59:59+00:00"
    }
  },
  "profile": "list",
  "limit": 5
}' %}

Use ISO 8601 dates. In GET URLs, encode `+` as `%2B`.

## Combined conditions

Return Health-themed reports for Syria (`SYR`):

{% include api-call.html
  url="https://api.reliefweb.int/v2/reports?appname=REPLACE-WITH-APP-NAME"
  body='{
  "filter": {
    "operator": "AND",
    "conditions": [
      {
        "field": "primary_country.iso3",
        "value": "SYR"
      },
      {
        "field": "theme",
        "value": "Health"
      }
    ]
  },
  "profile": "list",
  "limit": 5
}' %}

## Field exists

Omit `value` to select items where the field is present.

Return reports that have a `headline`:

{% include api-call.html
  url="https://api.reliefweb.int/v2/reports?appname=REPLACE-WITH-APP-NAME"
  body='{
  "filter": {
    "field": "headline"
  },
  "profile": "list",
  "limit": 5
}' %}

## Negate

Return reports tagged `France` or `Spain`, but **not** `Italy`:

{% include api-call.html
  url="https://api.reliefweb.int/v2/reports?appname=REPLACE-WITH-APP-NAME"
  body='{
  "filter": {
    "operator": "AND",
    "conditions": [
      {
        "field": "country",
        "value": ["France", "Spain"],
        "operator": "OR"
      },
      {
        "field": "country",
        "value": "Italy",
        "negate": true
      }
    ]
  },
  "profile": "list",
  "limit": 5
}' %}

## Default filters (`preset`)
{: #presets }

`preset` is a **string**. It applies bundled status filters and related defaults so you get the usual public listing behaviour without writing those filters by hand. It does **not** choose which fields appear in each result. That is [`profile` and `fields`](/read/fields-and-presets/).

Exact `status` filters differ by resource. See each resource’s **Defaults** section under [Resources](/read/resources/).

| Preset | Use |
|--------|-----|
| `minimal` | Default sensible status filters for most requests (hides expired jobs/training and archived disasters) |
| `latest` | List-oriented [sort](/read/sorting-and-pagination/) (typically by date; countries and sources by `id`) |
| `analysis` | Include archived disasters and expired jobs/training for historical analysis |

Include expired jobs for trends:

{% include api-call.html
  url="https://api.reliefweb.int/v2/jobs?appname=REPLACE-WITH-APP-NAME"
  body='{
  "preset": "analysis",
  "profile": "list",
  "limit": 5
}' %}

Search for `nutrition` reports, newest first:

{% include api-call.html
  url="https://api.reliefweb.int/v2/reports?appname=REPLACE-WITH-APP-NAME"
  body='{
  "preset": "latest",
  "query": {
    "value": "nutrition"
  },
  "profile": "list",
  "limit": 5
}' %}

With `preset: "latest"` and a `query`, results are sorted by date. With the default `minimal` preset and a `query`, results are typically ordered by relevance unless you set [`sort`](/read/sorting-and-pagination/) yourself.

**Next:** [Choose fields](/read/fields-and-presets/)
