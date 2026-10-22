---
title: GET vs POST
parent: Read / search
nav_order: 7
permalink: /read/get-vs-post/
---

# GET vs POST

Search endpoints (`/v2/reports`, `/v2/jobs`, …) accept **GET** or **POST** with the same parameters. With GET, put them on the query string; with POST, put them in a JSON body.

Always pass [`appname`](/#appname) as a URL query parameter, including for POST. Do not put it in the JSON body.

Use **POST** when the request includes nested structures (`query`, `filter`, `facets`, `fields`). The JSON body stays readable.

## Same request, two forms

Search for `drought` reports in Ethiopia (`ETH`) as JSON POST:

{% include api-call.html
  url="https://api.reliefweb.int/v2/reports?appname=REPLACE-WITH-APP-NAME"
  body='{
  "query": {
    "value": "drought"
  },
  "filter": {
    "field": "primary_country.iso3",
    "value": "ETH"
  },
  "limit": 3,
  "profile": "list"
}' %}

Same request as a GET query string:

{% include api-call.html
  url="https://api.reliefweb.int/v2/reports?appname=REPLACE-WITH-APP-NAME&query[value]=drought&filter[field]=primary_country.iso3&filter[value]=ETH&limit=3&profile=list"
  label="GET" %}

## Encoding tips

- Arrays: `fields[include][]=title&fields[include][]=body`
- Nested objects: `filter[value][from]=...&filter[value][to]=...`
- Facet list indexes: `facets[0][field]=country&facets[0][limit]=20`
- Encode `+` in timezone offsets as `%2B`
- Keep URLs reasonably short. Large filters belong in POST bodies.

## When to use which

| Use GET when… | Use POST when… |
|---------------|----------------|
| Sharing a simple link | Nested filters, facets, or queries |
| Fetching one record (GET only) | Bodies stay readable in code |
| OpenAPI “try it” for simple calls | Building clients in JSON |

**Next:** [Response, limits, and errors](/read/response/)
