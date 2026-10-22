---
title: Training
parent: Resources
nav_order: 5
permalink: /read/resources/training/
---

# Training

Humanitarian training courses, workshops, and academic programs ([reliefweb.int/training](https://reliefweb.int/training)). The endpoint path is singular: `/v2/training`.

Tagged with `type`, `format` (online / on-site), `cost` (`free` / `fee-based`), `career_categories`, `theme`, `country`, `city`, `source`, `language`, and `training_language`, with registration details in `how_to_register` and `fee_information`.

- **Endpoint:** `POST` or `GET https://api.reliefweb.int/v2/training`
- **Single training:** `GET https://api.reliefweb.int/v2/training/{id|uuid}`

{% include resource-defaults.html resource="training" %}

## Available fields

{% include fields-table.html resource="training" %}
