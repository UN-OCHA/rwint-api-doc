---
title: Create
parent: Publish
nav_order: 3
permalink: /publish/create/
---

# Create

Use **`PUT`** to submit a document. If no document exists for the UUID, it is created. If one already exists, it is replaced (see [Replace](#replace)). The submission is queued for processing and review, so it does not appear on ReliefWeb immediately.

```
PUT https://api.reliefweb.int/v2/{reports|jobs|training}/{uuid}?appname=REPLACE-WITH-APP-NAME
```

Send headers `X-RW-POST-API-KEY` and `X-RW-POST-API-PROVIDER`. See [Access and credentials](/publish/credentials/).

## Create a document

Generate the UUID from the document `url` first. See [Trusted URLs and UUIDs](/publish/urls-and-uuids/).

```bash
curl -X PUT "https://api.reliefweb.int/v2/reports/c27c51bd-e6b6-5c09-91fd-ef122afdde8e?appname=REPLACE-WITH-APP-NAME" \
  -H "Content-Type: application/json" \
  -H "X-RW-POST-API-KEY: YOUR-API-KEY" \
  -H "X-RW-POST-API-PROVIDER: YOUR-PROVIDER-UUID" \
  -d @report.json
```

Full payloads: [Report examples](/publish/reports/examples/), [Job examples](/publish/jobs/examples/), [Training examples](/publish/training/examples/).

## Responses

- **Queued:** `202` with “Document queued for processing.”
- **No changes:** `200` with “No changes.” if the payload is identical to your previous submission. Nothing is queued again.

## Errors

- `400` if the payload is invalid. Check it against the schema for the document type.
- `403` if the UUID belongs to a document created by another provider, or if your provider is not allowed to post this type of content.
- `422` if the existing document is `refused`, `duplicate`, or for reports `archive`. These documents can no longer be changed.

See [Responses, limits, and errors](/publish/methods-and-responses/) for all error codes and rate limits.

## Replace an existing document
{: #replace }

If a document already exists for this UUID, the same `PUT` **replaces** it entirely. Use this when your system always has the full record and resends it. For targeted edits, use [Update](/publish/update/) (`PATCH`) instead.

- Send the complete document, including all required fields.
- Omitted optional fields are cleared. For reports, this includes `file`: attachments missing from the map are removed.
- A changed submission goes back through editorial review.

**Next:** [Update](/publish/update/)
