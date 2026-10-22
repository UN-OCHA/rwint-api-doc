---
title: Training examples
parent: Training
grand_parent: Publish
nav_order: 2
permalink: /publish/training/examples/
---

# Training examples

Replace the example IDs and URLs with your own. A successful create typically returns **HTTP 202**. Field rules: [Training fields](/publish/training/fields/).

## Minimal valid training

Online, fee-based offering (includes required `fee_information`; no `country` because format is online-only).

```bash
curl -X PUT "https://api.reliefweb.int/v2/training/c2484d60-fa5d-591e-bcdd-401ffa63b92c?appname=REPLACE-WITH-APP-NAME" \
  -H "Content-Type: application/json" \
  -H "X-RW-POST-API-KEY: YOUR-API-KEY" \
  -H "X-RW-POST-API-PROVIDER: YOUR-PROVIDER-UUID" \
  -d @training.json
```

```json
{
  "url": "https://myorganization.org/training/12345",
  "uuid": "c2484d60-fa5d-591e-bcdd-401ffa63b92c",
  "title": "Example Introduction to Humanitarian Response",
  "source": [1503],
  "format": [4607],
  "event_url": "https://myorganization.org/training/12345/register",
  "cost": "fee-based",
  "fee_information": "USD 250 covers tuition and materials.",
  "category": [4609],
  "training_language": [267],
  "language": [267],
  "body": "Course overview and learning objectives in markdown or HTML.",
  "how_to_register": "Register on the event URL before the listed deadline."
}
```

## Production-style training

On-site and online, with `country`, `dates`, `theme`, and `professional_function`.

```json
{
  "url": "https://myorganization.org/training/12345",
  "uuid": "c2484d60-fa5d-591e-bcdd-401ffa63b92c",
  "title": "Example Introduction to Humanitarian Response",
  "source": [1503],
  "format": [4606, 4607],
  "country": [13],
  "dates": {
    "start": "2026-09-01T09:00:00+00:00",
    "end": "2026-09-05T17:00:00+00:00",
    "registration_deadline": "2026-08-15T00:00:00+00:00"
  },
  "event_url": "https://myorganization.org/training/12345/register",
  "cost": "fee-based",
  "fee_information": "USD 250 covers tuition and materials. Travel and accommodation are not included.",
  "category": [4609],
  "training_language": [267],
  "professional_function": [36601],
  "theme": [4587],
  "language": [267],
  "body": "## Overview\n\nA five-day introduction to humanitarian response for new practitioners.\n\n## Objectives\n\n- Understand the humanitarian architecture\n- Practice basic needs assessment concepts\n\n## Audience\n\nProgramme and operations staff with up to two years of experience.",
  "how_to_register": "Complete the online form on the event URL and attach your CV. Contact training@myorganization.org with questions. Registration closes on the listed deadline."
}
```

## Taxonomy ids in these examples

| Field | Id | Meaning | Look it up |
|-------|----|---------|------------|
| `source` | `1503` | UN Office for the Coordination of Humanitarian Affairs | `GET /v2/sources/1503` |
| `format` | `4606` | on-site | `GET /v2/references/training-formats/4606` |
| `format` | `4607` | online | `GET /v2/references/training-formats/4607` |
| `country` | `13` | Afghanistan | `GET /v2/countries/13` |
| `category` | `4609` | Training/Workshop | `GET /v2/references/training-types/4609` |
| `training_language`, `language` | `267` | English | `GET /v2/references/languages/267` |
| `professional_function` | `36601` | Logistics/Procurement | `GET /v2/references/career-categories/36601` |
| `theme` | `4587` | (theme term — confirm via lookup) | `GET /v2/references/themes/4587` |

Prefix paths with `https://api.reliefweb.int` and add your `appname`. See [References](/read/resources/references/), [Sources](/read/resources/sources/), and [Countries](/read/resources/countries/).

### Country lookup example

Required when `format` includes on-site (`4606`). Search countries by name or ISO3, then use the integer `id` (not the ISO3 string):

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

Take `id` from the response and send `"country": [13]`. Do not send `AFG` or `"Afghanistan"`. Omit `country` for online-only offerings.

## Troubleshooting

| Issue | Likely cause | What to do |
|-------|--------------|------------|
| Invalid taxonomy / unknown id | Wrong integer or name sent instead of id | Look up via `/v2/sources`, `/v2/countries`, or `/v2/references/...` and send integer ids |
| `country` rejected or missing | On-site format without `country`, or `country` sent for online-only | Include `country` when `format` contains `4606`; omit `country` when format is online-only |
| `fee_information` rejected or missing | `cost` is `fee-based` without fee text, or fee text sent when `free` | Require `fee_information` for `fee-based`; omit it for `free` |
| Incomplete `dates` | Missing `start`, `end`, or `registration_deadline` | Send all three, or omit the whole `dates` object for ongoing courses |
| UUID / url mismatch | `uuid` not derived from the exact `url` | Recompute UUID v5; see [Trusted URLs and UUIDs](/publish/urls-and-uuids/) |
| Trusted URL rejected | Document `url` outside approved prefixes | Use a trusted document prefix; update prefixes via [credentials](/publish/credentials/) |
| Invalid JSON / schema errors | Wrong types, short strings, social URL in `event_url` | Check the [training schema](https://reliefweb.int/post-api-schemas/v2/training.json) and [Training fields](/publish/training/fields/) |
| `body` / `how_to_register` rejected | Replaced with “see link” or too short | Put the real description and registration steps in those fields |

See also [Responses, limits, and errors](/publish/methods-and-responses/).
