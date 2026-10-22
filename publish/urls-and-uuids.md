---
title: Trusted URLs and UUIDs
parent: Publish
nav_order: 2
permalink: /publish/urls-and-uuids/
---

# Trusted URLs and UUIDs

When you [request Publish access](/publish/credentials/), you must provide trusted URL prefixes for your organization. The API only accepts document and media URLs that start with those approved prefixes. Those URLs also determine the UUIDs you send in every request.

## Trusted URL prefixes

You configure three categories. Each category can list **one or more** prefixes:

| Category | Used for |
|----------|----------|
| **Document prefixes** | Document `url` (stable document identifier) |
| **File prefixes** | Attachment `url` (stable file identifier) and `download_url` |
| **Image prefixes** | Image `download_url` |

Use your organization's own domain for permanent identifiers (`url` on documents and attachments).

If ReliefWeb needs to download your files or images (`download_url`) from a separate CDN or storage host, add that host as an extra file or image prefix.

Example for an organization that keeps permanent IDs on its own site and hosts PDF bytes on a CDN:

```yaml
# Document prefixes (for document url)
https://myorganization.org/report
https://myorganization.org/job
https://myorganization.org/training

# File prefixes (organization domain for file.url + CDN for file.download_url)
https://myorganization.org/files
https://cdn.example.org/files

# Image prefixes (for image.download_url)
https://myorganization.org/images
https://cdn.example.org/images
```

List every host and path prefix you will use. ReliefWeb configures the exact allowlist when it enables your provider.

## Document URL (`url`)

The payload `url` is an **immutable unique identifier in URL form**:

- It must start with one of your **trusted document prefixes**
- Prefer your organization's own domain (for example `https://myorganization.org/...`)
- It is used to generate the document UUID (see below)
- It must **never** change after the first successful submission
- It **does not need to resolve** to a live web page

Examples:

```
https://myorganization.org/report/12345
https://myorganization.org/job/12345
https://myorganization.org/training/12345
```

## Attachment URL vs download URL

ReliefWeb downloads attachments and images when it processes a submission. For **report PDFs**, two URL fields matter, and they play different roles.

| Field | Role |
|-------|------|
| `url` | Permanent attachment identifier. Used to generate the file UUID. Does not need to resolve. Never change it for that attachment. |
| `download_url` | Public URL where ReliefWeb downloads the file. Must start with one of your trusted file prefixes. You may change it when you publish a new version. |

**Use your organization's domain for `url`.** Never use a variable CDN path, cloud storage URL, SharePoint link, or versioned filename as the permanent `url`. Those hosts change over time and would change the file UUID. Put them in `download_url` instead, and register the host in your trusted file prefixes.

For **images**, send `download_url` only (plus checksum and metadata). See [Files and images](/publish/files-and-images/).

### Same host for identifier and download

When the PDF lives on your own site, `url` and `download_url` can be the same:

```json
{
  "uuid": "78d63e84-e2b4-5467-813d-1c2456f40d63",
  "url": "https://myorganization.org/report/12345/attachment.pdf",
  "download_url": "https://myorganization.org/report/12345/attachment.pdf",
  "filename": "attachment.pdf",
  "checksum": "42fffa6c0e84ebab15f0f1ead8319efc448d0d883a0b492528997b4f17989755"
}
```

### Identifier on your domain, file on a CDN

When the bytes live on a CDN or external storage, keep `url` on your organization domain and put the CDN URL in `download_url`:

```json
{
  "uuid": "78d63e84-e2b4-5467-813d-1c2456f40d63",
  "url": "https://myorganization.org/report/12345/attachment.pdf",
  "download_url": "https://cdn.example.org/files/2026-06/sitrep-v1.pdf",
  "filename": "attachment.pdf",
  "checksum": "42fffa6c0e84ebab15f0f1ead8319efc448d0d883a0b492528997b4f17989755"
}
```

When you later publish `sitrep-v2.pdf`, keep the same `url` and `uuid`. Change only `download_url` and `checksum`:

```json
{
  "uuid": "78d63e84-e2b4-5467-813d-1c2456f40d63",
  "url": "https://myorganization.org/report/12345/attachment.pdf",
  "download_url": "https://cdn.example.org/files/2026-06/sitrep-v2.pdf",
  "filename": "attachment.pdf",
  "checksum": "46e71dcadaee27ff9248490c5310bd2f9a04da602638b1f1d71bb01cdfaaf9a0"
}
```

### Avoid

Do **not** use the CDN or versioned path as the permanent identifier:

```json
{
  "url": "https://cdn.example.org/files/2026-06/sitrep-v1.pdf",
  "download_url": "https://cdn.example.org/files/2026-06/sitrep-v1.pdf"
}
```

That ties the file UUID to a path that will change when you upload `sitrep-v2.pdf`.

### Download URL rules

Download URLs must:

- Start with one of your **trusted file or image prefixes**
- Be **publicly reachable** without login, a paywall, or signed access that expires before import
- Match the schema rules:
  - **PDF `filename`:** ends with lowercase `.pdf` (the `download_url` path has no extension requirement)
  - **Image `download_url`:** ends with `.jpg`, `.png`, or `.webp`
  - Size limits: PDF max 20MB; image min width 700px, max 5MB

If ReliefWeb cannot download a file or image, processing fails even when the JSON validates.

### Checklist before you submit

1. Document `url` starts with an approved document prefix on your organization domain
2. Every attachment `url` starts with an approved file prefix on your organization domain (permanent identifier, not a CDN or versioned path)
3. Every attachment `download_url` and image `download_url` starts with an approved file or image prefix and opens in a private browser window without signing in
4. PDF `filename` ends in `.pdf`; image `download_url` ends in `.jpg`, `.png`, or `.webp`; size limits match the schema

## Document UUID

The Publish API uses **UUID version 5**. The server recomputes each UUID and rejects mismatches. You generate the **document** UUID (and each report **file** UUID). Cover images do not use a client-supplied UUID.

```
uuid5(reliefweb_namespace, document_url)
```

- **Namespace (fixed):** `8e27a998-c362-5d1f-b152-d474e1d36af2`
- **Second argument:** the document `url` exactly as it appears in your payload (character for character)

| Document `url` | Document `uuid` |
|----------------|-----------------|
| `https://myorganization.org/report/12345` | `c27c51bd-e6b6-5c09-91fd-ef122afdde8e` |
| `https://myorganization.org/job/12345` | `efa7a5ff-a00c-500e-bc5d-d181874dc072` |
| `https://myorganization.org/training/12345` | `c2484d60-fa5d-591e-bcdd-401ffa63b92c` |

Call `/v2/{resource}/{document_uuid}`. If `uuid` in the body does not match `uuid5(reliefweb_namespace, document_url)`, the submission is rejected.

### Generating a document UUID

**uuidgen (Linux)** (the `--name` option is the `url` string):

```bash
uuidgen --sha1 --namespace 8e27a998-c362-5d1f-b152-d474e1d36af2 \
  --name "https://myorganization.org/report/12345"
```

**JavaScript (Node)** ([npm uuid](https://www.npmjs.com/package/uuid)):

```js
import { v5 as uuidv5 } from 'uuid';

const NS = '8e27a998-c362-5d1f-b152-d474e1d36af2';
const url = 'https://myorganization.org/report/12345';
console.log(uuidv5(url, NS));
// c27c51bd-e6b6-5c09-91fd-ef122afdde8e
```

**PHP** ([Symfony UID](https://www.symfony.com/doc/current/components/uid.html)):

```php
use Symfony\Component\Uid\Uuid;

$ns = Uuid::fromString('8e27a998-c362-5d1f-b152-d474e1d36af2');
$url = 'https://myorganization.org/report/12345';
echo Uuid::v5($ns, $url)->toRfc4122();
```

You can also use [uuidtools v5](https://www.uuidtools.com/v5).

## File UUIDs (reports)

For PDF attachments, the **document UUID is used as the namespace** instead of the fixed ReliefWeb one:

```
uuid5(document_uuid, file_url)
```

- **Namespace:** the document `uuid` (see above)
- **Second argument:** the attachment’s permanent `url` (not `download_url`)

Using the report example above (`document_uuid` = `c27c51bd-e6b6-5c09-91fd-ef122afdde8e`):

| Attachment permanent `url` | File `uuid` (map key) |
|----------------------------|------------------------|
| `https://myorganization.org/report/12345/attachment.pdf` | `78d63e84-e2b4-5467-813d-1c2456f40d63` |

That UUID is the key in the report `file` map, and the same value goes in the attachment's `uuid` field (other fields abbreviated):

```json
{
  "file": {
    "78d63e84-e2b4-5467-813d-1c2456f40d63": {
      "uuid": "78d63e84-e2b4-5467-813d-1c2456f40d63",
      "url": "https://myorganization.org/report/12345/attachment.pdf",
      "download_url": "…",
      "filename": "attachment.pdf",
      "checksum": "…"
    }
  }
}
```

Keep it stable for the life of the attachment. Changing `download_url` does **not** change the file UUID.

### Generating a file UUID

**JavaScript:**

```js
import { v5 as uuidv5 } from 'uuid';

const documentUuid = 'c27c51bd-e6b6-5c09-91fd-ef122afdde8e';
const fileUrl = 'https://myorganization.org/report/12345/attachment.pdf';
console.log(uuidv5(fileUrl, documentUuid));
// 78d63e84-e2b4-5467-813d-1c2456f40d63
```

**uuidgen:**

```bash
uuidgen --sha1 --namespace c27c51bd-e6b6-5c09-91fd-ef122afdde8e \
  --name "https://myorganization.org/report/12345/attachment.pdf"
```

Each file also requires a lowercase SHA-256 `checksum` of the file at `download_url`. See [Files and images](/publish/files-and-images/).

## Images

Do **not** send a client `uuid` for `image`. ReliefWeb derives the media id from the checksum and `download_url`. Send `download_url`, `checksum`, `description`, and `copyright`.

## Later submissions

- Same document `url` produces the same document UUID. Use `PUT` or `PATCH` on that path.
- Same attachment `url` produces the same file UUID. Change `download_url` and `checksum` to publish a new PDF version.

**Next:** [Create](/publish/create/)
