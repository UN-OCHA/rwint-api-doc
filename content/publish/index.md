---
title: Publish
has_children: true
has_toc: false
nav_order: 3
permalink: /publish/
---

# Publish

Use the Publish API to submit reports, jobs, and training for publication on ReliefWeb.

## Usual flow

A create, replace, or update typically goes like this:

1. **Submit** with `PUT` (or `PATCH`)
2. **Queued** (`202`)
3. **Processed** (including file download for reports when relevant)
4. **Editorial review**
5. **Published** on [reliefweb.int](https://reliefweb.int) and in the [read/search API](/read/)

`DELETE` withdraws a document immediately, with no queue.

## Before you start

Your organization must be listed on [reliefweb.int/organizations](https://reliefweb.int/organizations). You also need an [`appname`](/#appname), API key, provider UUID, and trusted URL prefixes. See [Access and credentials](/publish/credentials/).

## Where to go

| What you want to do | Page |
|---------------------|------|
| Get access and credentials | [Access and credentials](/publish/credentials/) |
| Set up trusted URL prefixes and generate UUIDs | [Trusted URLs and UUIDs](/publish/urls-and-uuids/) |
| Create or replace a document (`PUT`) | [Create](/publish/create/) |
| Change some fields (`PATCH`) | [Update](/publish/update/) |
| Withdraw a document (`DELETE`) | [Withdraw](/publish/withdraw/) |
| Status codes, shared rules, and limits | [Responses, limits, and errors](/publish/methods-and-responses/) |
| Publish a report (including PDFs and images) | [Reports](/publish/reports/) · [Report fields](/publish/reports/fields/) · [Report examples](/publish/reports/examples/) · [Files and images](/publish/files-and-images/) |
| Publish a job | [Jobs](/publish/jobs/) · [Job fields](/publish/jobs/fields/) · [Job examples](/publish/jobs/examples/) |
| Publish a training opportunity | [Training](/publish/training/) · [Training fields](/publish/training/fields/) · [Training examples](/publish/training/examples/) |

JSON Schemas: [report](https://reliefweb.int/post-api-schemas/v2/report.json), [job](https://reliefweb.int/post-api-schemas/v2/job.json), [training](https://reliefweb.int/post-api-schemas/v2/training.json)
