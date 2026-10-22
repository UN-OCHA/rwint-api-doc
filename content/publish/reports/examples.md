---
title: Report examples
parent: Reports
grand_parent: Publish
nav_order: 3
permalink: /publish/reports/examples/
---

# Report examples

Replace the example IDs and URLs with your own. A successful create typically returns **HTTP 202**. Field rules: [Report fields](/publish/reports/fields/). Attachment deep dive: [Files and images](/publish/files-and-images/).

## Minimal valid report

Required fields only (text body, no PDF or image).

```bash
curl -X PUT "https://api.reliefweb.int/v2/reports/c27c51bd-e6b6-5c09-91fd-ef122afdde8e?appname=REPLACE-WITH-APP-NAME" \
  -H "Content-Type: application/json" \
  -H "X-RW-POST-API-KEY: YOUR-API-KEY" \
  -H "X-RW-POST-API-PROVIDER: YOUR-PROVIDER-UUID" \
  -d @report.json
```

```json
{
  "url": "https://myorganization.org/report/12345",
  "uuid": "c27c51bd-e6b6-5c09-91fd-ef122afdde8e",
  "title": "Example situation report for Country X",
  "source": [1503],
  "country": [13],
  "format": [10],
  "language": [267],
  "published": "2024-06-06T01:00:00+00:00",
  "body": "Short overview or full article text in markdown or HTML."
}
```

## Production-style report (PDF and image)
{: #create-with-pdf-and-image }

`file` is a **map** keyed by permanent file UUID. Each attachment needs `url` (stable identifier), `download_url` (fetch location), `filename`, and `checksum`. Images have no client-supplied `uuid`. `file_order` lists UUIDs in **display** order; map key order does not control ordering.

```json
{
  "url": "https://myorganization.org/report/12345",
  "uuid": "c27c51bd-e6b6-5c09-91fd-ef122afdde8e",
  "title": "Example situation report for Country X",
  "source": [1503],
  "country": [13],
  "format": [10],
  "language": [267],
  "published": "2024-06-06T01:00:00+00:00",
  "body": "Executive summary of the attached PDFs.",
  "origin": "https://myorganization.org/report/12345/view",
  "theme": [4587],
  "file": {
    "78d63e84-e2b4-5467-813d-1c2456f40d63": {
      "uuid": "78d63e84-e2b4-5467-813d-1c2456f40d63",
      "url": "https://myorganization.org/report/12345/attachment.pdf",
      "download_url": "https://myorganization.org/report/12345/attachment.pdf",
      "filename": "attachment.pdf",
      "checksum": "42fffa6c0e84ebab15f0f1ead8319efc448d0d883a0b492528997b4f17989755",
      "description": "Main situation report",
      "language": "en"
    },
    "0c478b4a-6c1a-5153-bd73-96fecb1bd49c": {
      "uuid": "0c478b4a-6c1a-5153-bd73-96fecb1bd49c",
      "url": "https://myorganization.org/report/12345/annex.pdf",
      "download_url": "https://myorganization.org/report/12345/annex.pdf",
      "filename": "annex.pdf",
      "checksum": "ecf9d6481917f47bbcb47c4ba934a14177cb919c2c597444b9a764073f827980",
      "description": "Annex",
      "language": "en"
    }
  },
  "file_order": [
    "0c478b4a-6c1a-5153-bd73-96fecb1bd49c",
    "78d63e84-e2b4-5467-813d-1c2456f40d63"
  ],
  "image": {
    "download_url": "https://myorganization.org/images/report-12345.png",
    "checksum": "c24863f6aa2065dd5071a831ee78439260ea72983799dd3e88fbfb4aa08fdc18",
    "description": "Test image",
    "copyright": "Test NGO"
  },
  "notify": ["editor@myorganization.org"]
}
```

In this example `file_order` is used to have the annex shown before the main PDF.

## Taxonomy ids in these examples

| Field | Id | Meaning | Look it up |
|-------|----|---------|------------|
| `source` | `1503` | UN Office for the Coordination of Humanitarian Affairs | `GET /v2/sources/1503` |
| `country` | `13` | Afghanistan | `GET /v2/countries/13` |
| `format` | `10` | Situation Report | `GET /v2/references/content-formats/10` |
| `language` | `267` | English | `GET /v2/references/languages/267` |
| `theme` | `4587` | (theme term — confirm via lookup) | `GET /v2/references/themes/4587` |

Prefix paths with `https://api.reliefweb.int` and add your `appname`. See [References](/read/resources/references/), [Sources](/read/resources/sources/), and [Countries](/read/resources/countries/).

### Country lookup example

Search countries by name or ISO3, then use the integer `id` in the payload (not the ISO3 code). The first `country` id is the primary country.

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

Take `id` from the response and send `"country": [13]`. Do not send `AFG` or `"Afghanistan"`.

## Troubleshooting

| Issue | Likely cause | What to do |
|-------|--------------|------------|
| Invalid taxonomy / unknown id | Wrong integer, name/ISO3 instead of id | Look up via `/v2/sources`, `/v2/countries`, `/v2/disasters`, or `/v2/references/...` |
| Missing required field | Required property omitted | Include every required field from [Report fields](/publish/reports/fields/) |
| UUID / url mismatch | Document or file UUID not derived from the exact url | Recompute UUID v5; see [Trusted URLs and UUIDs](/publish/urls-and-uuids/) |
| Trusted URL rejected | Document, file, or image URL outside approved prefixes | Register document/file/image prefixes; see [credentials](/publish/credentials/) |
| `file` shape errors | Sent as a JSON array, or map key ≠ attachment `uuid` | Send a UUID-keyed **object**; key must match `uuid` and `uuid5(document_uuid, file.url)` |
| Checksum / download failures | Wrong SHA-256, unreachable `download_url`, or non-PDF | Recompute checksum of the bytes at `download_url`; ensure PDF ≤ 20MB |
| Image rejected | Missing fields, wrong extension, or too small | Require `download_url`, `checksum`, `description`, `copyright`; `.jpg`/`.png`/`.webp`; min width 700px |
| Invalid JSON / schema errors | Wrong types or short strings | Validate against the [report schema](https://reliefweb.int/post-api-schemas/v2/report.json) |

See also [Responses, limits, and errors](/publish/methods-and-responses/).
