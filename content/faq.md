---
title: FAQ
nav_order: 4
permalink: /faq/
---

# FAQ

Common questions. For walkthroughs, start with [Read / search](/read/) or [Publish](/publish/). Suggestions welcome via [contact](https://reliefweb.int/contact).

## General

### Are client libraries available?
{: #client-libraries }

Yes. There are simple clients for [PHP](https://github.com/reliefweb/api-php-client) and [Golang](https://github.com/reliefweb/api-go-client).

## Read / search

### How often is the data updated?
{: #updates }

In real time. Content is available whenever it is added or updated on ReliefWeb.

---

### How far does the data go back?
{: #content-dates }

Reports have been posted continuously since 1996 (ReliefWeb launch). UN reports on major disasters from the 1980s are also available. Jobs started in 2001 and training in 1998, with API data available from 2011 onwards.

---

### Why are my results almost empty?
{: #empty-results }

On `/v2/{resource}` the default [`profile`](/read/fields-and-presets/) is `minimal` (title or name only). Set `"profile": "list"` for a practical browsing set, or `full` for everything. Single-record requests (`/v2/{resource}/{id}`) default to `profile=default`. See [Choose fields](/read/fields-and-presets/) and [Resources](/read/resources/) for details.

---

### Why don’t I see expired or archived items?
{: #archived-expired }

Default presets hide archived disasters and expired jobs/training. Use `"preset": "analysis"` when you need historical content. See [Default filters (`preset`)](/read/filtering/#presets).

---

### How can I get exact results for my search terms?
{: #exact-results }

- **Filters:** quote the value and/or use a field marked `exact` under [Resources](/read/resources/). Examples: [Filter](/read/filtering/).
- **Full-text `query`:** phrases, booleans, and field prefixes are covered in [Search](/read/search/).

---

### How can I get just the total?
{: #totalcount }

Each response includes `totalCount` (all matches), separate from `count` (items on this page). Set `"limit": 0` when you only need the total. See [Sort and paginate](/read/sorting-and-pagination/).

## Publish

### What’s the difference between `url` and `download_url`?
{: #url-vs-download-url }

On report attachments, `url` is the permanent attachment identifier on your organization domain. `download_url` is the public URL where ReliefWeb downloads the file (your site or a CDN). See [Trusted URLs and UUIDs](/publish/urls-and-uuids/).

---

### Why did I get HTTP 202 instead of 200?
{: #http-202 }

**202** means the document was queued for processing. That is the usual success for creates, replaces, and updates. See [Responses, limits, and errors](/publish/methods-and-responses/).

---

### When should I use PUT, PATCH, or DELETE?
{: #put-patch-delete }

| Want to… | Use |
|----------|-----|
| Create or replace entirely | **PUT** — [Create](/publish/create/) |
| Change some fields | **PATCH** — [Update](/publish/update/) |
| Withdraw | **DELETE** — [Withdraw](/publish/withdraw/) |
