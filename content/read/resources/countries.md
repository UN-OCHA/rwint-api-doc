---
title: Countries
parent: Resources
nav_order: 3
permalink: /read/resources/countries/
---

# Countries

Country records and situational overviews ([reliefweb.int/countries](https://reliefweb.int/countries)), including `id`, `name`, `shortname`, `iso3`, `status`, and country `profile` content.

Query `/v2/countries` to look up country `id` or `iso3` codes for filtering or publishing on other resources.

- **Endpoint:** `POST` or `GET https://api.reliefweb.int/v2/countries`
- **Single country:** `GET https://api.reliefweb.int/v2/countries/{id|uuid}`

{% include resource-defaults.html resource="countries" %}

## Available fields

{% include fields-table.html resource="countries" %}
