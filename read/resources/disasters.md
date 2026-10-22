---
title: Disasters
parent: Resources
nav_order: 2
permalink: /read/resources/disasters/
---

# Disasters

Disaster records ([reliefweb.int/disasters](https://reliefweb.int/disasters)) used to group related reports and provide situational overviews (`name`, `glide`, `status`, `country`, `primary_country`, `type`, `primary_type`).

- **Endpoint:** `POST` or `GET https://api.reliefweb.int/v2/disasters`
- **Single disaster:** `GET https://api.reliefweb.int/v2/disasters/{id|uuid}`

{% include resource-defaults.html resource="disasters" %}

## Available fields

{% include fields-table.html resource="disasters" %}
