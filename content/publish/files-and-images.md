---
title: Files and images
parent: Reports
grand_parent: Publish
nav_order: 2
permalink: /publish/files-and-images/
---

# Files and images

Only reports support PDF attachments and an optional cover image. Jobs and training do not. Field summaries: [Report fields](/publish/reports/fields/#field-file). Full payloads: [Report examples](/publish/reports/examples/).

{: .warning }
In the Publish API, `file` is a **map keyed by permanent file UUID**, not a JSON array. How `url`, `download_url`, and file UUIDs relate is explained in [Trusted URLs and UUIDs](/publish/urls-and-uuids/).

## Attachment fields

| Field | Required | Meaning |
|-------|----------|---------|
| Map key / `uuid` | Yes | Permanent file UUID = `uuid5(document_uuid, url)` |
| `url` | Yes (when creating) | Permanent attachment identifier under your organization's domain. Do not use a variable CDN or versioned URL. Optional on later submissions if unchanged. Keep it the same to [publish a new version](#new-file-version) of the file. |
| `download_url` | Yes | Public URL ReliefWeb downloads. May equal `url`, or point to a CDN/storage host registered in your trusted file prefixes. Changing it does **not** change the UUID. |
| `filename` | Yes | Must end in lowercase `.pdf` |
| `checksum` | Yes | Lowercase SHA-256 of the file at `download_url` |
| `description` | No | On PATCH, omit to keep; `null` to clear |
| `language` | No | Optional ISO code: `ar`, `en`, `es`, `fr`, `ru`, `zh`, or `ot`. On PATCH, omit to keep; `null` to clear |

Optional root field **`file_order`**: an array of attachment UUIDs that sets display order.

Examples below use the same IDs as [Trusted URLs and UUIDs](/publish/urls-and-uuids/):

- Document: `c27c51bd-e6b6-5c09-91fd-ef122afdde8e`
- File: `78d63e84-e2b4-5467-813d-1c2456f40d63`

## Checksum

`checksum` is the lowercase hex SHA-256 of the file at `download_url`:

```bash
# macOS
shasum -a 256 path/to/file.pdf | awk '{print tolower($1)}'

# Linux
sha256sum path/to/file.pdf | awk '{print tolower($1)}'
```

---

## Publish a new version of a file
{: #new-file-version }

This is the recommended way to update a PDF. Keep the attachment's permanent `url` and `uuid` the same, and change only `download_url` and `checksum`. Everyone who already has a link to the file on ReliefWeb then gets the new version. The `description` and `language` are kept unless you send new values.

{: .warning }
Do not add the new version under a new `url`. That creates a separate attachment with a new UUID. Depending on the method, the old file is either still listed next to the new one (`PATCH`) or removed (`PUT`), and existing links to it never reach the new version.

1. Keep the same map key, `uuid`, and permanent `url` (your organization domain, not a CDN path).
2. Point `download_url` at the new file. It can stay the same if you overwrote the file at that location.
3. Send the new `checksum`. ReliefWeb uses it to detect that the content changed. If the checksum is unchanged, the file is not downloaded again.
4. Use **`PATCH`** so the other attachments stay untouched.

In the example below, only `download_url` and `checksum` change.

```bash
curl -X PATCH "https://api.reliefweb.int/v2/reports/c27c51bd-e6b6-5c09-91fd-ef122afdde8e?appname=REPLACE-WITH-APP-NAME" \
  -H "Content-Type: application/json" \
  -H "X-RW-POST-API-KEY: YOUR-API-KEY" \
  -H "X-RW-POST-API-PROVIDER: YOUR-PROVIDER-UUID" \
  -d @replace-file.json
```

```json
{
  "file": {
    "78d63e84-e2b4-5467-813d-1c2456f40d63": {
      "uuid": "78d63e84-e2b4-5467-813d-1c2456f40d63",
      "url": "https://myorganization.org/report/12345/attachment.pdf",
      "download_url": "https://cdn.example.org/files/2026-06/sitrep-v2.pdf",
      "filename": "attachment.pdf",
      "checksum": "46e71dcadaee27ff9248490c5310bd2f9a04da602638b1f1d71bb01cdfaaf9a0"
    }
  }
}
```

---

## Add an attachment

Send a `PATCH` with a new UUID key. Other files are kept.

```json
{
  "file": {
    "0c478b4a-6c1a-5153-bd73-96fecb1bd49c": {
      "uuid": "0c478b4a-6c1a-5153-bd73-96fecb1bd49c",
      "url": "https://myorganization.org/report/12345/annex.pdf",
      "download_url": "https://myorganization.org/report/12345/annex.pdf",
      "filename": "annex.pdf",
      "checksum": "ecf9d6481917f47bbcb47c4ba934a14177cb919c2c597444b9a764073f827980",
      "description": "Annex",
      "language": "en"
    }
  }
}
```

Generate the new UUID with `uuid5(document_uuid, url)`. See [Trusted URLs and UUIDs](/publish/urls-and-uuids/#file-uuids-reports).

---

## Remove one attachment

Send a `PATCH` that sets that UUID to `null`. Other files stay.

```json
{
  "file": {
    "0c478b4a-6c1a-5153-bd73-96fecb1bd49c": null
  }
}
```

---

## Remove all attachments

```json
{
  "file": null
}
```

On `PUT`, an empty object `{}` also clears all attachments. On `PATCH`, `{}` means “change nothing about files.”

---

## Reorder attachments

Send `file_order` without changing `file`:

```json
{
  "file_order": [
    "78d63e84-e2b4-5467-813d-1c2456f40d63",
    "0c478b4a-6c1a-5153-bd73-96fecb1bd49c"
  ]
}
```

Listed UUIDs come first in that order. Any unlisted attachments keep their relative order at the end. Unknown ids are ignored.

---

## Full replace of the attachment set

Use **`PUT`** with a complete document payload whose `file` map lists **exactly** the attachments that should remain. Anything absent from the map is removed. See [Replace](/publish/create/#replace). Full create-with-PDF examples: [Report examples](/publish/reports/examples/#create-with-pdf-and-image).

---

## Set or clear the cover image

`image` is a single object that you replace as a whole. Required fields: `download_url`, `checksum`, `description`, `copyright`. Do **not** send a client `uuid`.

**Set or replace:**

```json
{
  "image": {
    "download_url": "https://myorganization.org/images/report-12345.png",
    "checksum": "c24863f6aa2065dd5071a831ee78439260ea72983799dd3e88fbfb4aa08fdc18",
    "description": "Test image",
    "copyright": "Test NGO"
  }
}
```

**Clear:**

```json
{
  "image": null
}
```

**Next:** [Jobs](/publish/jobs/)
