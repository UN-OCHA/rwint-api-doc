---
title: Home
nav_order: 1
permalink: /
---

# ReliefWeb API

The ReliefWeb API gives you programmatic access to humanitarian reports, disasters, jobs, training, and related data as JSON over HTTPS.

## Start here

Choose what you want to do. Both paths require an approved [`appname`](#appname) on every request:

<div class="api-paths">
<div class="api-path" markdown="1">

[Read / search](/read/)
{: .api-path__title }

Search and retrieve reports, disasters, jobs, training, countries, and sources.
{: .api-path__lead }

[Explore Read / search](/read/)
{: .api-path__cta }

</div>
<div class="api-path" markdown="1">

[Publish](/publish/)
{: .api-path__title }

Publish your organization’s reports, jobs, and training on ReliefWeb.
{: .api-path__lead }

[Explore Publish](/publish/)
{: .api-path__cta }

</div>
</div>

## Appname
{: #appname }

Every API URL needs a pre-approved `appname` so ReliefWeb can monitor usage. Pass it as a **query parameter on the URL** (including for POST, PATCH, or DELETE requests):

```
https://api.reliefweb.int/v2/reports?appname=YOUR-APPROVED-APPNAME
```

Request one with [this short form](https://docs.google.com/forms/d/e/1FAIpQLScR5EE_SBhweLLg_2xMCnXNbT6md4zxqIB00OL0yZWyrqX_Nw/viewform?usp=header). Use a combination of your organization name, purpose, and random characters. ReliefWeb reviews requests and replies by email.

Examples in this documentation use `REPLACE-WITH-APP-NAME`. Substitute your approved value before calling the API.

Publish also needs an API key and provider headers. See [Access and credentials](/publish/credentials/).

## OpenAPI

An interactive OpenAPI schema is available for exploring endpoints and trying requests:

[https://api.reliefweb.int/v2/swagger/api](https://api.reliefweb.int/v2/swagger/api){:target="_blank"}

## Terms

Anyone may use the ReliefWeb API. Reports, jobs, and training may include material owned by the original source. Respect those rights when reusing content.

ReliefWeb may log calls and analyze usage. Always send a valid `appname` so usage can be attributed.
