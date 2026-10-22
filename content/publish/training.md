---
title: Training
parent: Publish
has_children: true
has_toc: false
nav_order: 9
permalink: /publish/training/
---

# Training

Submit a training opportunity for editorial review. The path segment is `training` (no trailing “s”).

```
PUT|PATCH|DELETE https://api.reliefweb.int/v2/training/{uuid}?appname=REPLACE-WITH-APP-NAME
```

You need [Access and credentials](/publish/credentials/) and [Trusted URLs and UUIDs](/publish/urls-and-uuids/). For changes and withdrawals, see [Update](/publish/update/) and [Withdraw](/publish/withdraw/).

## Field summary

{% include publish-fields.html resource="training" %}

Taxonomy fields are **integer ids** — not UUIDs. Resolve them via the read API and [`/v2/references`](/read/resources/references/).

### Conditional fields
{: #conditional-fields }

| Field | Rule |
|-------|------|
| `fee_information` | Required when `cost` is `fee-based`; omit when `cost` is `free`. |
| `country` | Required when `format` includes on-site (`4606`); omit otherwise. |
| `dates` | If present, include `start`, `end`, and `registration_deadline` (ISO 8601). Omit the whole object for ongoing offerings. |

| Goal | See |
|------|-----|
| Rules, examples, and lookups for each field | [Training fields](/publish/training/fields/) |
| Minimal and production-style payloads, troubleshooting | [Training examples](/publish/training/examples/) |
| Change some fields | [Update](/publish/update/) |
| Withdraw | [Withdraw](/publish/withdraw/) |

**Next:** [Training fields](/publish/training/fields/)
