---
title: Responses, limits, and errors
parent: Publish
nav_order: 6
permalink: /publish/methods-and-responses/
---

# Responses, limits, and errors

All Publish API calls use the same path and authentication:

```
https://api.reliefweb.int/v2/{reports|jobs|training}/{uuid}?appname=REPLACE-WITH-APP-NAME
```

Send headers `X-RW-POST-API-KEY` and `X-RW-POST-API-PROVIDER`. See [Access and credentials](/publish/credentials/).

How-to pages: [Create](/publish/create/) · [Update](/publish/update/) · [Withdraw](/publish/withdraw/).

Responses are short JSON-encoded strings (for example `"Document queued for processing."`) with an HTTP status code.

## Rules that apply to all methods

| Rule | What it means |
|------|----------------|
| **Same provider** | You can only change documents your provider created. The wrong provider returns `403`. |
| **Terminal statuses** | Documents marked `refused`, `duplicate`, or (for reports) `archive` cannot be changed with PUT or PATCH (`422`). |
| **No changes** | If the payload is identical to the previous submission, you get `200` “No changes.” and nothing is re-queued. Exception: for **withdrawn** documents (and **expired** jobs/training), the same payload is accepted again so you can [reopen](/publish/withdraw/#reopen-a-withdrawn-document). See also [Replace](/publish/create/#replace). |
| **Queue** | If a document is still queued, a later submission for the same UUID replaces the queued item. |
| **Rate limits** | See [Limits](#limits) below. |

## Success responses

| HTTP | Message (typical) | Meaning |
|------|-------------------|---------|
| **202** | Document queued for processing. | Accepted and queued for import/review. |
| **200** | Document processed. | Processed without queuing (when applicable). |
| **200** | No changes. | Payload matches the last submission. Nothing is re-queued. |
| **200** | Document withdrawn. | `DELETE` succeeded. |
| **200** | Document already withdrawn. | `DELETE` when already withdrawn (safe to retry). |
| **200** | Document is already publicly unavailable (marked as refused). | `DELETE` on a terminal status (`refused`, `duplicate`, or for reports `archive`). The status is not changed. |

Most creates, replaces, and updates return **202**.

## Common errors

| HTTP | Message (typical) | What to do |
|------|-------------------|------------|
| **400** | Missing or invalid appname parameter. | Add `?appname=REPLACE-WITH-APP-NAME`. |
| **400** | Invalid JSON / invalid data… | Fix the payload against the schema for the document type: [report](https://reliefweb.int/post-api-schemas/v2/report.json), [job](https://reliefweb.int/post-api-schemas/v2/job.json), or [training](https://reliefweb.int/post-api-schemas/v2/training.json). Field guides: [Report fields](/publish/reports/fields/), [Job fields](/publish/jobs/fields/), [Training fields](/publish/training/fields/). |
| **403** | Invalid API key. / Invalid provider. | Check `X-RW-POST-API-KEY` and `X-RW-POST-API-PROVIDER`. |
| **403** | Not allowed to modify this document. | Only the owning provider can change or withdraw. |
| **403** | Not allowed to post content. | Your provider has no posting quota. [Contact ReliefWeb](https://reliefweb.int/contact). |
| **404** | Document not found. | `PATCH` and `DELETE` need an existing UUID. Check the path. |
| **404** | Unknown endpoint. / Invalid endpoint UUID. | Use `reports`, `jobs`, or `training` and a valid UUID. |
| **405** | Unsupported method. | Use only `PUT`, `PATCH`, or `DELETE`. |
| **413** | Request body too large. | Keep the JSON body small (attachments are URLs, not uploads). |
| **422** | Document is marked as refused (publicly unavailable) and cannot be updated. | Terminal status (`refused`, `duplicate`, or for reports `archive`). Contact editors if you need a change. |
| **429** | Not enough time elapsed since last request. / Daily quota exceeded. | Respect the limits below. Check the `Retry-After` header. |

## Limits
{: #limits }

Typical defaults (ReliefWeb may set different values for your provider):

| Limit | Typical value |
|-------|---------------|
| Documents per day | **50** |
| Minimum interval | **1 document per minute** |

Exceeding these limits returns `429 Too Many Requests` with a `Retry-After` header: remaining seconds until the next allowed request, or the start of the next UTC day when the daily quota is exceeded. Processing can still take time after a `202`.

**Next:** [Reports](/publish/reports/)
