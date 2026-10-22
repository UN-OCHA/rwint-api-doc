---
title: Withdraw
parent: Publish
nav_order: 5
permalink: /publish/withdraw/
---

# Withdraw

Use **`DELETE`** to unpublish an existing document. Unlike create and update, a withdrawal is applied immediately (nothing is queued), and the request has no body.

```
DELETE https://api.reliefweb.int/v2/{reports|jobs|training}/{uuid}?appname=REPLACE-WITH-APP-NAME
```

Send headers `X-RW-POST-API-KEY` and `X-RW-POST-API-PROVIDER`. See [Access and credentials](/publish/credentials/).

```bash
curl -X DELETE "https://api.reliefweb.int/v2/reports/c27c51bd-e6b6-5c09-91fd-ef122afdde8e?appname=REPLACE-WITH-APP-NAME" \
  -H "X-RW-POST-API-KEY: YOUR-API-KEY" \
  -H "X-RW-POST-API-PROVIDER: YOUR-PROVIDER-UUID"
```

## Responses

Withdrawal returns `200` (not `202`, since nothing is queued).

- **Withdrawn:** `200` with “Document withdrawn.” The document status is now `withdrawn`.
- **Already withdrawn:** `200` with “Document already withdrawn.” Nothing changes, so it is safe to retry.
- **Refused, duplicate, or archived:** `200` with a message such as “Document is already publicly unavailable (marked as refused).” The document is not changed and keeps its current status. Reports can also be `archive`.

## Errors

- `403` if the document was created by another provider.
- `404` if no document exists for the UUID.
See [Responses, limits, and errors](/publish/methods-and-responses/) for all error codes and rate limits.

## Expired jobs and training

ReliefWeb marks jobs and training as `expired` automatically after they close. You can still withdraw an expired document, and its status then becomes `withdrawn`.

## Reopen a withdrawn document

To reopen a withdrawn document (or an expired job or training), submit it again with `PUT` or `PATCH`. The submission is handled like any other and goes through the normal review process again.

See [Replace](/publish/create/#replace) and [Update](/publish/update/).

**Next:** [Responses, limits, and errors](/publish/methods-and-responses/)
