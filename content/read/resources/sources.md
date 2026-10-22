---
title: Sources
parent: Resources
nav_order: 6
permalink: /read/resources/sources/
---

# Sources

Organizations that publish content on ReliefWeb ([reliefweb.int/organizations](https://reliefweb.int/organizations)), exposed in the API as `sources` (`id`, `name`, `shortname`, `longname`, `type`, `country`, `homepage`, `fts_id`).

Query `/v2/sources` to resolve organization `id` or `shortname` values for filtering or publishing. There are more than 1,000 sources, so use `limit` and `offset` ([Sort and paginate](/read/sorting-and-pagination/)) if fetching the full set.

- **Endpoint:** `POST` or `GET https://api.reliefweb.int/v2/sources`
- **Single source:** `GET https://api.reliefweb.int/v2/sources/{id|uuid}`

{% include resource-defaults.html resource="sources" %}

## Available fields

{% include fields-table.html resource="sources" %}
