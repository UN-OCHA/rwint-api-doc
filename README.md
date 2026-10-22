# ReliefWeb API documentation

Static documentation for the ReliefWeb API, built with **Jekyll** and the **[Just the Docs](https://just-the-docs.github.io/just-the-docs/)** remote theme. Hosted on GitHub Pages (`apidoc.reliefweb.int`).

Jekyll site files live at the repo root. Tooling is under `local/` (excluded from the Jekyll build).

## Local development

```bash
cd local
./install.sh   # if needed
docker compose up
```

First boot needs network access so Jekyll can fetch `remote_theme: just-the-docs/just-the-docs@v0.10.1`.

Or locally from the repo root: `bundle exec jekyll serve` (requires `repository` in `_config.yml` for github-pages metadata).

## GitHub Pages

Publish from the branch with folder **`/`** (repo root). `_config.yml` excludes `local/`, `README.md`, and the Gemfile from the site build.

## Content layout (editors)

Navigation is driven by page front matter (`title`, `parent`, `nav_order`, `has_children`), not a YAML menu.

Top-level order: **Home**, **Read / search**, **Publish**, **FAQ**.

Home covers the shared `appname` credential (`/#appname`). Under each API, topic pages are **direct children**. Read keeps one hub where many pages would clutter the sidebar: **Resources**.

| Path | Purpose |
|------|---------|
| `index.md` | Home (incl. appname) |
| `read/` | Read / search hub + unified topic pages |
| `read/resources/` | Resources and fields |
| `read/response.md` | Response, limits, errors, slim/verbose |
| `publish/` | Publish hub + setup, methods, and content types |
| `faq.md` | Site-wide FAQ |
| `_data/fields/` | Read field tables (YAML) |
| `_data/publish/` | Publish schema field summaries |
| `_includes/api-call.html` | Example request component |
| `_sass/color_schemes/rw.scss` | ReliefWeb color scheme |
| `_sass/custom/custom.scss` | Fonts, nav, logo title, code blocks, polish |

**Just the Docs note:** `parent` matches page **title** uniquely site-wide. Avoid two different hubs with the same title. Flattening under Read / Publish avoids that clash.

### Read topic pages

| Path | Topic |
|------|-------|
| `read/search.md` | Search |
| `read/filtering.md` | Filter |
| `read/fields-and-presets.md` | Choose fields (`profile`, `fields`) |
| `read/sorting-and-pagination.md` | Sort and paginate |
| `read/facets.md` | Break down results |
| `read/get-item.md` | Get one item |
| `read/get-vs-post.md` | GET vs POST |
| `read/response.md` | Response, limits, and errors |

### Add a read topic page

Create `read/my-topic.md`:

```yaml
---
title: My topic
parent: Read / search
nav_order: 8
permalink: /read/my-topic/
---
```

### Add a publish page

Create `publish/my-page.md` with `parent: Publish`.

### Examples

Prefer POST JSON via the include (see existing guides for patterns):

```
{% include api-call.html url="..." body='{ "limit": 2 }' %}
```

### Updating fields

Edit YAML under `_data/fields/`. Each resource page under `read/resources/` renders that file via `_includes/fields-table.html`.

Reconcile against `rwint-api` OpenAPI / Resource PHP / Silk when the API changes. There is no automated sync.

### Updating Publish schemas

Field data for Publish lives in `_data/publish/{report,job,training}.yml`. The hub summary table uses `_includes/publish-fields.html`; per-field pages use `_includes/publish-field-sections.html`. Each content type has **Fields** and **Examples** child pages under `publish/{jobs,reports,training}/`.

For nested examples (objects/maps), set `example_json` to a pretty-printed JSON block string. Simple scalars and short arrays can keep `example` (rendered with Liquid `jsonify`, which is compact-only).

Canonical public JSON remains at `https://reliefweb.int/post-api-schemas/v2/`. When reconciling, prefer the Drupal module schemas in `reliefweb_post_api/schemas/v2/` (rwint9-site) if they are ahead of production. Jekyll does not fetch schemas at build time.

### Theme

- `_config.yml` sets `remote_theme: just-the-docs/just-the-docs@v0.10.1` and `color_scheme: rw`
- Brand colors live in `_sass/color_schemes/rw.scss`; fonts/api-call polish in `_sass/custom/custom.scss`
- OpenAPI link is in `aux_links`
