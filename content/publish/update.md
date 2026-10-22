---
title: Update
parent: Publish
nav_order: 4
permalink: /publish/update/
---

# Update

Use **`PATCH`** to change some fields of an existing document. Send only the fields you want to change. Everything else stays as it is. The document must already exist, and the change is queued for processing and review like a new submission. To resend the whole document instead, see [Replace](/publish/create/#replace).

```
PATCH https://api.reliefweb.int/v2/{reports|jobs|training}/{uuid}?appname=REPLACE-WITH-APP-NAME
```

Send headers `X-RW-POST-API-KEY` and `X-RW-POST-API-PROVIDER`. See [Access and credentials](/publish/credentials/).

## Change a field

Send the field with its new value. This example changes the title and body of a report and leaves every other field untouched:

```bash
curl -X PATCH "https://api.reliefweb.int/v2/reports/c27c51bd-e6b6-5c09-91fd-ef122afdde8e?appname=REPLACE-WITH-APP-NAME" \
  -H "Content-Type: application/json" \
  -H "X-RW-POST-API-KEY: YOUR-API-KEY" \
  -H "X-RW-POST-API-PROVIDER: YOUR-PROVIDER-UUID" \
  -d '{
  "title": "Updated situation report for Country X",
  "body": "Revised executive summary."
}'
```

### Lists and objects

A field you send is set to exactly the value you send. For lists such as `theme`, `country`, or `source`, that means you send the **complete new list**, not only the item you want to add or remove.

For example, if a report currently has `"theme": [4587, 4595]`:

| You send | The report ends up with |
|----------|-------------------------|
| `"theme": [4587, 4595, 4603]` | Themes `4587`, `4595`, and `4603` (`4603` added) |
| `"theme": [4587]` | Theme `4587` only (`4595` removed) |
| `"theme": [4603]` | Theme `4603` only. Both existing themes are replaced. |

The same applies to objects such as `image` and training `dates`: send the whole object. Report attachments (`file`) are the exception. See [Report attachments](#report-attachments).

## Clear an optional field

Set an optional field to `null` to remove its value:

```json
{
  "origin": null
}
```

Required fields cannot be cleared. A request such as `{ "title": null }` fails with `400` and the message “Cannot clear mandatory field: title.”

## Report attachments

For reports, `file` works differently from other fields: attachments are merged by UUID, so you can add, remove, or reorder one attachment without resending the others. See [Files and images](/publish/files-and-images/).

## Training: fields that depend on each other

Some training fields only make sense together. When your update touches one of them, the API checks the result against the values already stored on the document:

- `fee_information` is required when `cost` is `fee-based`, and must be empty otherwise.
- `country` is required when `format` includes on-site training, and must be empty otherwise.

For example, if a training is `fee-based` with a stored `fee_information`, switching it to free means changing both fields in the same request:

```json
{
  "cost": "free",
  "fee_information": null
}
```

Sending only `"cost": "free"` fails because the stored `fee_information` would no longer be allowed. See [Conditional fields](/publish/training/#conditional-fields).

## The `url` field

`url` is optional on `PATCH` because the path UUID already identifies the document. If you do send it, it must still match the UUID. See [Trusted URLs and UUIDs](/publish/urls-and-uuids/).

## Responses

- **Queued:** `202` with “Document queued for processing.”
- **No changes:** `200` with “No changes.” if the payload is identical to your previous submission. Nothing is queued again.

## Errors

- `400` if the payload is invalid, for example when clearing a required field.
- `403` if the document was created by another provider.
- `404` if no document exists for the UUID.
- `422` if the document is `refused`, `duplicate`, or for reports `archive`. These documents can no longer be changed.

See [Responses, limits, and errors](/publish/methods-and-responses/) for all error codes and rate limits.

**Next:** [Withdraw](/publish/withdraw/)
