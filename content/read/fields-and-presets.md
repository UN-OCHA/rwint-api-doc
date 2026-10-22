---
title: Choose fields
parent: Read / search
nav_order: 3
permalink: /read/fields-and-presets/
---

# Choose fields

Two parameters control **which fields appear** in each result:

| Parameter | Role |
|-----------|------|
| `profile` | Default set of fields in each result |
| `fields` | Include or exclude specific fields on top of the profile |

For default status filters and list-oriented sort, see [`preset`](/read/filtering/#presets).

## Profiles (`profile`)

Requests to `/v2/{resource}` default to `profile=minimal` (title or name only). Single-record requests (`/v2/{resource}/{id}`) default to `profile=default` (nearly all fields; see below). Override with the `profile` string, or refine further with `fields`.

| Profile | When to use | What you get |
|---------|-------------|--------------|
| `minimal` | Compact results, lookups by title/name | Title or name only (**default on `/v2/{resource}`**) |
| `list` | Browsable result sets | Listing-oriented fields (as on ReliefWeb listing pages). Exact set varies by [resource](/read/resources) |
| `full` | Complete payloads | All fields for the resource |
| `default` | Single-record fetches | All fields for most resources (**default on `/v2/{resource}/{id}`**) |
| `suggest` | Typeahead UIs | Compact name fields for countries, disasters, sources, and references |

Most examples use `"profile": "list"`. For the exact field sets and [`preset`](/read/filtering/#presets) status / sort / query defaults, open the resource page’s **Defaults** tables under [Resources](/read/resources/).

List countries with the `list` profile and include each `iso3` code:

{% include api-call.html
  url="https://api.reliefweb.int/v2/countries?appname=REPLACE-WITH-APP-NAME"
  body='{
  "profile": "list",
  "fields": {
    "include": ["iso3"]
  },
  "limit": 5
}' %}

## Fields (`fields`)

`fields` is an **object** with two optional arrays:

| Key | Type | Meaning |
|-----|------|---------|
| `include` | array of strings | Extra fields to add beyond the profile |
| `exclude` | array of strings | Fields to remove from the profile |

List reports with `list` fields plus `format.name`:

{% include api-call.html
  url="https://api.reliefweb.int/v2/reports?appname=REPLACE-WITH-APP-NAME"
  body='{
  "limit": 3,
  "profile": "list",
  "fields": {
    "include": ["format.name"]
  }
}' %}

List `full` reports but omit `body` and `body-html`:

{% include api-call.html
  url="https://api.reliefweb.int/v2/reports?appname=REPLACE-WITH-APP-NAME"
  body='{
  "limit": 3,
  "profile": "full",
  "fields": {
    "exclude": ["body", "body-html"]
  }
}' %}

Available field names for each resource are listed under [Resources](/read/resources/).

**Next:** [Sort and paginate](/read/sorting-and-pagination/)
