---
title: References
parent: Resources
nav_order: 9
permalink: /read/resources/references/
---

# References

Taxonomy vocabularies used for tagging (themes, disaster types, job types, languages, and more). For plain-language descriptions of terms, see [Humanitarian Terms](https://reliefweb.int/taxonomy-descriptions).

Look up a term to get its integer `id`, then use that `id` in [filters](/read/filtering/) or Publish payloads ([reports](/publish/reports/), [jobs](/publish/jobs/), [training](/publish/training/)). For example, searching `/v2/references/languages` for `french` returns `id` `268` (`fields.name`: `French`). You can then filter reports with `{"field": "language.id", "value": 268}`, or publish with `"language": [268]`.

## Endpoints

- **Index:** `GET https://api.reliefweb.int/v2/references`: lists all vocabulary endpoints
- **Vocabulary:** `GET` or `POST https://api.reliefweb.int/v2/references/{vocabulary}`: list or search terms in a vocabulary

The index response is the authoritative list of available vocabularies. Common ones are summarized below.

Search a vocabulary with `query`, for example:

```
GET https://api.reliefweb.int/v2/references/languages?appname=REPLACE-WITH-APP-NAME&query[value]=french
```

Example response (abbreviated):

```json
{
  "totalCount": 1,
  "count": 1,
  "data": [
    {
      "id": 268,
      "fields": {
        "name": "French",
        "code": "fr"
      }
    }
  ]
}
```

## Common vocabularies

| Vocabulary | Path |
|------------|------|
| [Career categories](https://reliefweb.int/taxonomy-descriptions#careercategory) | `/v2/references/career-categories` |
| [Content formats](https://reliefweb.int/taxonomy-descriptions#format) | `/v2/references/content-formats` |
| [Disaster types](https://reliefweb.int/taxonomy-descriptions#disastertype) | `/v2/references/disaster-types` |
| [Features](https://reliefweb.int/taxonomy-descriptions#feature) | `/v2/references/features` |
| [Job experience](https://reliefweb.int/taxonomy-descriptions#jobexperience) | `/v2/references/job-experience` |
| [Job types](https://reliefweb.int/taxonomy-descriptions#jobtype) | `/v2/references/job-types` |
| [Languages](https://reliefweb.int/taxonomy-descriptions#language) | `/v2/references/languages` |
| [OCHA products](https://reliefweb.int/taxonomy-descriptions#ochaproduct) | `/v2/references/ocha-products` |
| [Organization types](https://reliefweb.int/taxonomy-descriptions#orgtype) | `/v2/references/organization-types` |
| [Themes](https://reliefweb.int/taxonomy-descriptions#theme) | `/v2/references/themes` |
| [Training formats](https://reliefweb.int/taxonomy-descriptions#trainingformat) | `/v2/references/training-formats` |
| [Training types](https://reliefweb.int/taxonomy-descriptions#trainingtype) | `/v2/references/training-types` |
| Vulnerable groups (deprecated; no Terms page) | `/v2/references/vulnerable-groups` |
