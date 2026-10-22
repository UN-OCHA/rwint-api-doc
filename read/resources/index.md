---
title: Resources
parent: Read / search
has_children: true
nav_order: 9
permalink: /read/resources/
---

# Resources

Base host: `https://api.reliefweb.int`. Version path: `/v2`. List available resources with `GET /v2` (include your [`appname`](/#appname)).

Each resource page covers the endpoint, its fields, and a **Defaults** section (profile field sets and public presets). To choose which fields appear in a response, see [Choose fields](/read/fields-and-presets/).

Do not confuse the **`profile` request parameter** with the `profile` field on [countries](/read/resources/countries/) and [disasters](/read/resources/disasters/).

## Endpoints

- **Resource endpoint** (`GET` or `POST /v2/{resource}`): Search, filter, sort, and facet across records. All [request parameters](/read/#request-parameters) apply.
- **Single record** (`GET /v2/{resource}/{id|uuid}`): Fetch one record by numeric ReliefWeb ID or UUID. Accepts `profile`, `fields`, `preset`, and `slim` (defaults and 404 behaviour: [Get one item](/read/get-item/)).

## Field attributes

Resource field tables include an **Attributes** column:

| Attribute | Meaning |
|-----------|---------|
| `searchable` | Can be targeted in [`query`](/read/search/) |
| `facetable` | Can be used in [`facets`](/read/facets/) |
| `exact` | Supports `.exact` / exact phrase matching |
| `sortable` | Can be used in [`sort`](/read/sorting-and-pagination/) |
| `multi` | Field may hold multiple values |
| `common` | Shared across several content types |

## Resources

| Resource | Role |
|----------|------|
| [Reports](/read/resources/reports/) | Humanitarian updates and analysis |
| [Disasters](/read/resources/disasters/) | Disaster events and status |
| [Countries](/read/resources/countries/) | Country metadata and related content |
| [Jobs](/read/resources/jobs/) | Job listings |
| [Training](/read/resources/training/) | Training opportunities |
| [Sources](/read/resources/sources/) | Content providers / organizations |
| [Blog](/read/resources/blog/) | ReliefWeb blog posts |
| [Topics](/read/resources/topics/) | Editorial topic hubs |
| [References](/read/resources/references/) | Taxonomy vocabularies (themes, formats, …) |
| [Field catalogue](/read/resources/field-catalogue/) | Cross-resource field summary |
