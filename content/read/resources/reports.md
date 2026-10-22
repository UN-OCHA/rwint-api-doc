---
title: Reports
parent: Resources
nav_order: 1
permalink: /read/resources/reports/
---

# Reports

Humanitarian updates, situation reports, assessments, maps, and infographics from ReliefWeb sources ([reliefweb.int/updates](https://reliefweb.int/updates)).

Tagged with `country`, `primary_country`, `source`, `theme`, `format`, `disaster`, `disaster_type`, and `language`, with downloadable attachments in `file` and images in `image`.

- **Endpoint:** `POST` or `GET https://api.reliefweb.int/v2/reports`
- **Single report:** `GET https://api.reliefweb.int/v2/reports/{id|uuid}`

{% include resource-defaults.html resource="reports" %}

## Available fields

{% include fields-table.html resource="reports" %}
