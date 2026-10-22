---
title: Job examples
parent: Jobs
grand_parent: Publish
nav_order: 2
permalink: /publish/jobs/examples/
---

# Job examples

Replace the example IDs and URLs with your own. A successful create typically returns **HTTP 202**. Field rules: [Job fields](/publish/jobs/fields/).

## Minimal valid job

Required fields only (omit `country` / `theme` for remote, roster/roving, or TBD location).

```bash
curl -X PUT "https://api.reliefweb.int/v2/jobs/efa7a5ff-a00c-500e-bc5d-d181874dc072?appname=REPLACE-WITH-APP-NAME" \
  -H "Content-Type: application/json" \
  -H "X-RW-POST-API-KEY: YOUR-API-KEY" \
  -H "X-RW-POST-API-PROVIDER: YOUR-PROVIDER-UUID" \
  -d @job.json
```

```json
{
  "url": "https://myorganization.org/job/12345",
  "uuid": "efa7a5ff-a00c-500e-bc5d-d181874dc072",
  "title": "Example Humanitarian Affairs Officer",
  "source": [1503],
  "closing_date": "2029-06-06T01:00:00+00:00",
  "body": "Role overview and key responsibilities in markdown or HTML.",
  "how_to_apply": "Apply via the careers portal linked from the job URL.",
  "job_type": [263],
  "job_experience": [260],
  "career_category": [36601]
}
```

## Production-style job

Includes `country` and `theme`, with fuller description and application text.

```json
{
  "url": "https://myorganization.org/job/12345",
  "uuid": "efa7a5ff-a00c-500e-bc5d-d181874dc072",
  "title": "Example Humanitarian Affairs Officer",
  "source": [1503],
  "closing_date": "2029-06-06T01:00:00+00:00",
  "body": "## Role overview\n\nCoordinate humanitarian information management and reporting for the country office.\n\n## Responsibilities\n\n- Draft situation updates and briefing notes\n- Support partners with data standards and taxonomy tagging\n- Liaise with clusters and OCHA counterparts\n\n## Requirements\n\n- Degree in a relevant field\n- Experience in humanitarian coordination or information management",
  "how_to_apply": "Submit your CV and cover letter through the careers portal at the job URL before the closing date. Incomplete applications will not be considered.",
  "country": [13],
  "job_type": [263],
  "job_experience": [260],
  "career_category": [36601],
  "theme": [4587]
}
```

## Taxonomy ids in these examples

| Field | Id | Meaning | Look it up |
|-------|----|---------|------------|
| `source` | `1503` | UN Office for the Coordination of Humanitarian Affairs | `GET /v2/sources/1503` |
| `country` | `13` | Afghanistan | `GET /v2/countries/13` |
| `job_type` | `263` | Job | `GET /v2/references/job-types/263` |
| `job_experience` | `260` | 5-9 years | `GET /v2/references/job-experience/260` |
| `career_category` | `36601` | Logistics/Procurement | `GET /v2/references/career-categories/36601` |
| `theme` | `4587` | (theme term — confirm via lookup) | `GET /v2/references/themes/4587` |

Prefix paths with `https://api.reliefweb.int` and add your `appname`. To find an id, see [References](/read/resources/references/), [Sources](/read/resources/sources/), and [Countries](/read/resources/countries/).

### Country lookup example

Search countries by name or ISO3, then use the integer `id` in the payload (not the ISO3 string):

```
GET https://api.reliefweb.int/v2/countries?appname=REPLACE-WITH-APP-NAME&query[value]=afghanistan
```

Example response (abbreviated):

```json
{
  "totalCount": 1,
  "count": 1,
  "data": [
    {
      "id": 13,
      "fields": {
        "name": "Afghanistan",
        "iso3": "AFG"
      }
    }
  ]
}
```

Take `id` from the response and send `"country": [13]`. Do not send `AFG` or `"Afghanistan"`. Omit `country` entirely for remote, roster/roving, or TBD location.

## Troubleshooting

| Issue | Likely cause | What to do |
|-------|--------------|------------|
| Invalid taxonomy / unknown id | Wrong integer, name/ISO3 sent instead of id, or stale id | Look up the term via `/v2/sources`, `/v2/countries`, or `/v2/references/...` and send the integer `id` in an array |
| Missing required field | Required property omitted or set to `null` | Include every required field from [Job fields](/publish/jobs/fields/); required fields cannot be cleared on PATCH |
| UUID / url mismatch | `uuid` not derived from the exact `url` string | Recompute `uuid5(ReliefWeb namespace, url)`; see [Trusted URLs and UUIDs](/publish/urls-and-uuids/) |
| Trusted URL rejected | `url` (or other URL fields) outside approved prefixes | Use a URL under your trusted document prefix; request prefix updates via [credentials](/publish/credentials/) |
| Invalid JSON / schema errors | Malformed JSON, wrong types (string instead of array of ints), title too short, empty body | Validate against the [job schema](https://reliefweb.int/post-api-schemas/v2/job.json); check min lengths and `maxItems` |
| `how_to_apply` / `body` rejected | Control characters, leading/trailing spaces, or too short | Use markdown/HTML within the allowlist; keep length ≥ 10; avoid odd whitespace |

See also [Responses, limits, and errors](/publish/methods-and-responses/).
