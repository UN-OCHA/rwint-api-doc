---
title: Jobs
parent: Resources
nav_order: 4
permalink: /read/resources/jobs/
---

# Jobs

Humanitarian job listings ([reliefweb.int/jobs](https://reliefweb.int/jobs)) tagged with `type`, `career_categories`, `experience`, `theme`, `country`, `city`, and `source`, plus application instructions in `how_to_apply` and closing dates in `date.closing`.

- **Endpoint:** `POST` or `GET https://api.reliefweb.int/v2/jobs`
- **Single job:** `GET https://api.reliefweb.int/v2/jobs/{id|uuid}`

{% include resource-defaults.html resource="jobs" %}

## Available fields

{% include fields-table.html resource="jobs" %}
