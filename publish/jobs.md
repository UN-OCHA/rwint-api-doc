---
title: Jobs
parent: Publish
has_children: true
has_toc: false
nav_order: 8
permalink: /publish/jobs/
---

# Jobs

Submit a job listing for editorial review. For advice on writing effective listings, see [How your job postings can better attract the right candidates](https://reliefweb.int/blogpost/how-your-job-postings-can-better-attract-right-candidates).

```
PUT|PATCH|DELETE https://api.reliefweb.int/v2/jobs/{uuid}?appname=REPLACE-WITH-APP-NAME
```

You need [Access and credentials](/publish/credentials/) and [Trusted URLs and UUIDs](/publish/urls-and-uuids/). For changes and withdrawals, see [Update](/publish/update/) and [Withdraw](/publish/withdraw/).

## Field summary

{% include publish-fields.html resource="job" %}

Taxonomy fields are **integer ids** (`source`, `job_type`, `job_experience`, `career_category`, optional `country` / `theme`) — not UUIDs. Resolve them via the read API and [`/v2/references`](/read/resources/references/).

| Goal | See |
|------|-----|
| Rules, examples, and lookups for each field | [Job fields](/publish/jobs/fields/) |
| Minimal and production-style payloads, troubleshooting | [Job examples](/publish/jobs/examples/) |
| Change some fields | [Update](/publish/update/) |
| Withdraw | [Withdraw](/publish/withdraw/) |

**Next:** [Job fields](/publish/jobs/fields/)
