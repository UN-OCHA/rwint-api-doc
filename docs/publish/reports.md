---
title: Reports
parent: Publish
has_children: true
has_toc: false
nav_order: 7
permalink: /publish/reports/
---

# Reports

Submit a report for editorial review.

```
PUT|PATCH|DELETE https://api.reliefweb.int/v2/reports/{uuid}?appname=REPLACE-WITH-APP-NAME
```

You need [Access and credentials](/publish/credentials/) and [Trusted URLs and UUIDs](/publish/urls-and-uuids/). For changes and withdrawals, see [Update](/publish/update/) and [Withdraw](/publish/withdraw/).

## Field summary

{% include publish-fields.html resource="report" %}

Use **integer ids** for taxonomies (`source`, `country`, `format`, `language`, and optional tags) — not UUIDs. Resolve them with the read API and [`/v2/references`](/read/resources/references/).

## Body vs attachments

- Put the full article in `body`, or an executive summary when the main content is a PDF.
- PDFs go in `file` (map of attachments, `.pdf` filename, max 20MB each, max 10).
- An optional cover or illustration goes in `image` (`.jpg` / `.png` / `.webp`, min width 700px, max 5MB).

Prefer **`PATCH`** for targeted field or attachment edits. Use **`PUT`** when you resend the full record from your system. See [Update](/publish/update/) and [Replace](/publish/create/#replace).

| Goal | See |
|------|-----|
| Rules, examples, and lookups for each field | [Report fields](/publish/reports/fields/) |
| Minimal and production-style payloads, troubleshooting | [Report examples](/publish/reports/examples/) |
| PDF and image details | [Files and images](/publish/files-and-images/) |
| Change title or body only | [Update](/publish/update/) |
| New PDF version, same permanent URL | [Publish a new version of a file](/publish/files-and-images/#new-file-version) |
| Withdraw | [Withdraw](/publish/withdraw/) |

**Next:** [Report fields](/publish/reports/fields/)
