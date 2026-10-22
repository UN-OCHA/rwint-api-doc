# ReliefWeb API documentation

Static documentation for the ReliefWeb API, built with **Jekyll** and the **[Just the Docs](https://just-the-docs.github.io/just-the-docs/)** remote theme. Hosted on GitHub Pages (`apidoc.reliefweb.int`).

Site content lives under `content/` (`source: content` in `_config.yml`). Repo root holds tooling (`Gemfile`, `local/`, config).

## Local development

```bash
cd local
./install.sh   # if needed
docker compose up
```

First boot needs network access so Jekyll can fetch `remote_theme: just-the-docs/just-the-docs@v0.10.1`.

Or locally: `bundle exec jekyll serve` (requires `repository` in `_config.yml` for github-pages metadata).

## Content layout (editors)

Navigation is driven by page front matter (`title`, `parent`, `nav_order`, `has_children`), not a YAML menu.

Top-level order: **Home**, **Read / search**, **Publish**, **FAQ**.

Home covers the shared `appname` credential (`/#appname`). Under each API, topic pages are **direct children**. Read keeps one hub where many pages would clutter the sidebar: **Resources**.

| Path | Purpose |
|------|---------|
| `content/index.md` | Home (incl. appname) |
| `content/read/` | Read / search hub + unified topic pages |
| `content/read/resources/` | Resources and fields |
| `content/read/response.md` | Response, limits, errors, slim/verbose |
| `content/publish/` | Publish hub + setup, methods, and content types |
| `content/faq.md` | Site-wide FAQ |
| `content/_data/fields/` | Read field tables (YAML) |
| `content/_data/publish/` | Publish schema field summaries |
| `content/_includes/api-call.html` | Example request component |
| `content/_sass/color_schemes/rw.scss` | ReliefWeb color scheme |
| `content/_sass/custom/custom.scss` | Fonts, nav, logo title, code blocks, polish |

**Just the Docs note:** `parent` matches page **title** uniquely site-wide. Avoid two different hubs with the same title. Flattening under Read / Publish avoids that clash.

### Read topic pages

| Path | Topic |
|------|-------|
| `content/read/search.md` | Search |
| `content/read/filtering.md` | Filter |
| `content/read/fields-and-presets.md` | Choose fields (`profile`, `fields`) |
| `content/read/sorting-and-pagination.md` | Sort and paginate |
| `content/read/facets.md` | Break down results |
| `content/read/get-item.md` | Get one item |
| `content/read/get-vs-post.md` | GET vs POST |
| `content/read/response.md` | Response, limits, and errors |

### Add a read topic page

Create `content/read/my-topic.md`:

```yaml
---
title: My topic
parent: Read / search
nav_order: 8
permalink: /read/my-topic/
---
```

### Add a publish page

Create `content/publish/my-page.md` with `parent: Publish`.

### Examples

Prefer POST JSON via the include (see existing guides for patterns):

```
{% include api-call.html url="..." body='{ "limit": 2 }' %}
```

### Updating fields

Edit YAML under `content/_data/fields/`. Each resource page under `content/read/resources/` renders that file via `content/_includes/fields-table.html`.

Reconcile against `rwint-api` OpenAPI / Resource PHP / Silk when the API changes. There is no automated sync.

### Updating Publish schemas

Field data for Publish lives in `content/_data/publish/{report,job,training}.yml`. The hub summary table uses `content/_includes/publish-fields.html`; per-field pages use `content/_includes/publish-field-sections.html`. Each content type has **Fields** and **Examples** child pages under `content/publish/{jobs,reports,training}/`.

For nested examples (objects/maps), set `example_json` to a pretty-printed JSON block string. Simple scalars and short arrays can keep `example` (rendered with Liquid `jsonify`, which is compact-only).

Canonical public JSON remains at `https://reliefweb.int/post-api-schemas/v2/`. When reconciling, prefer the Drupal module schemas in `reliefweb_post_api/schemas/v2/` (rwint9-site) if they are ahead of production. Jekyll does not fetch schemas at build time.

### Theme

- `_config.yml` sets `source: content`, `remote_theme: just-the-docs/just-the-docs@v0.10.1`, and `color_scheme: rw`
- Brand colors live in `content/_sass/color_schemes/rw.scss`; fonts/api-call polish in `content/_sass/custom/custom.scss`
- OpenAPI link is in `aux_links`
- GitHub Pages builds from the branch root; Jekyll reads pages from `content/`
