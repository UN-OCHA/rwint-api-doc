---
layout: "index"
title: Reliefweb API - Documentation
---

<a name="top"></a>
# ReliefWeb API - Documentation

This is the documentation for the ReliefWeb API.

The API allows to fetch content from [ReliefWeb](http://reliefweb.int) like the latest headlines, job offers or disasters.

## Table of contents

- [**General information**](#general-information)
- [**Parameters**](#parameters)
- [**API URL**](#api-url)
- [**Version**](#version)
- [**Entities**](#entities)
- [**Methods**](#methods)
  - [info](#method-info)
      - [container fields](#container-fields)
      - [common fields](#common-fields)
  - [list](#method-list)
      - [list fields](#method-list-fields)
      - [list query](#method-list-query)
      - [list filter](#method-list-filter)
      - [list sort](#method-list-sort)
  - [item ID](#method-item-id)
- [**Status codes**](#status-codes)
- [**Examples**](#examples)


<a name="general-information"></a>
## General information

Any call to the API returns a `JSON` object.

Calls follow the pattern:

http://APIURL/VERSION/[ENTITY/[METHOD|ITEMID[?PARAMETERS]]].

| reference          | description | values |
| ------------------ | ----------- | ------ |
| **APIURL**         | Main url. [More information.](#api-url)  | `api.rwlabs.org` |
| **VERSION**        | API Version number. [More information.](#version) | `v0`|
| **ENTITY**         | Type of entity that is being queried. [More information.](#entities) | `report`, `job`, `training`, `disaster` or `country`. |
| **METHOD** or **ITEMID**| Type of request, or specific id of item being queried. [More information.](#methods) | `info`, `list` or numeric id. |
| **PARAMETERS**     | HTTP GET query string, or a JSON object, with further details of the query. [More information.](#parameters) | `?limit=1`, `{"limit": 1}` (for example). |

A successful call returns a JSON object of three parts:

* the `version` (see [Version](#version)),
* an HTTP `status` code of 200 (see [Status codes](#status-codes))
* a `data` object.

An unsuccessful call returns:

* the `version`,
* an HTTP `status` code (not 200)
* an `error` message.

> For convenience, the **version** and **status** codes are always present in the JSON object.

Example of a successful call:

```
http://api.rwlabs.org/v0/report/list?limit=1
```

Returns

```json

{
	"version": 0,
	"status": 200,
	"data": {
		"type": "report",
		"time": 1,
		"total": 982,
		"count": 1,
		"list": [{
			"id": "573658",
			"score": 1,
			"fields": {
				"title": "EU Chief Observer expresses serious concerns about levels of violence affecting the campaign during a visit to Peshawar"
			}
		}]
	}
}
```

[&uarr; top](#top)


<a name="parameters"></a>
## Parameters

There are two ways to pass parameters to a method:

- as json object in the request body:

```json
curl -XGET 'http://api.rwlabs.org/v0/report/list' -d '{
	"query": {
		"fields": ["title", "body"],
		"value": "humanitarian"
	}
}'
```

- as standard GET parameters:

```
http://api.rwlabs.org/v0/report/list?query[value]=humanitarian&query[fields][0]=title&query[fields][1]=body
```

> **Only the HTTP method GET is allowed.**

[&uarr; top](#top)

<a name="api-url"></a>
## API URL

While this remains a Reliefweb Labs project, the url for API calls is:

```
http://api.rwlabs.org
```

Remember that this is likely to change when the API leaves beta.

[&uarr; top](#top)

<a name="version"></a>
## Version

The current available version is a beta version labeled **`v0`**.

Calling the API with just the version number returns the available API endpoints:

```
curl -XGET 'http://api.rwlabs.org/v0'
```

Returns:

```json
{
	"version": 0,
	"status": 200,
	"data": {
		"title": "ReliefWeb API",
		"endpoints": {
			"report": {
				"info": "http:\/\/api.rwlabs.org\/v0\/report\/info",
				"list": "http:\/\/api.rwlabs.org\/v0\/report\/list",
				"item": "http:\/\/api.rwlabs.org\/v0\/report\/[ID]"
			},
			"job": {
				"info": "http:\/\/api.rwlabs.org\/v0\/job\/info",
				"list": "http:\/\/api.rwlabs.org\/v0\/job\/list",
				"item": "http:\/\/api.rwlabs.org\/v0\/job\/[ID]"
			},
			"training": {
				"info": "http:\/\/api.rwlabs.org\/v0\/training\/info",
				"list": "http:\/\/api.rwlabs.org\/v0\/training\/list",
				"item": "http:\/\/api.rwlabs.org\/v0\/training\/[ID]"
			},
			"country": {
				"info": "http:\/\/api.rwlabs.org\/v0\/country\/info",
				"list": "http:\/\/api.rwlabs.org\/v0\/country\/list",
				"item": "http:\/\/api.rwlabs.org\/v0\/country\/[ID]"
			},
			"disaster": {
				"info": "http:\/\/api.rwlabs.org\/v0\/disaster\/info",
				"list": "http:\/\/api.rwlabs.org\/v0\/disaster\/list",
				"item": "http:\/\/api.rwlabs.org\/v0\/disaster\/[ID]"
			}
		}
	}
}
```

[&uarr; top](#top)


<a name="entities"></a>
## Entities

Entities correspond to the main content on [ReliefWeb](http://reliefweb.int).

Currently data can be fetched for 5 entities:

- **Report**:

  This entity type corresponds to updates, headlines or maps available on [ReliefWeb - Updates](http://reliefweb.int/updates).

- **Job**:

  This entity type corresponds to the job offers available on [ReliefWeb - Jobs](http://reliefweb.int/jobs).

- **Training**:

  This entity type corresponds to the training opportunities available on [ReliefWeb - Training](http://reliefweb.int/training).

- **Country**:

  This entity type corresponds to the countries available on [ReliefWeb - Country](http://reliefweb.int/countries).

- **Disaster**:

  This entity type corresponds to the disasters available on [ReliefWeb - Disaster](http://reliefweb.int/disasters).

Calling the API with the version number and entity type gives endpoints for just that entity type:

```
curl -XGET 'http://api.rwlabs.org/v0/report'
```

Returns:

```json
{
  "version":0,
  "status":200,
  "data":{
    "title":"ReliefWeb API",
    "entity":"report",
    "endpoints":{
      "info":"http:\/\/api.rwlabs.org\/v0\/report\/info",
      "list":"http:\/\/api.rwlabs.org\/v0\/report\/list",
      "item":"http:\/\/api.rwlabs.org\/v0\/report\/[ID]"
    }
  }
}
```

[&uarr; top](#top)


<a name="methods"></a>
## Methods

Methods are the way to get the data for an entity type or for specific content.

They follow the same pattern:

```
http://[APIURL]/[VERSION]/[ENTITY]/[METHOD|ITEMID]
```

Currently 3 methods are defined.

1. `info`
2. `list`
3. `[itemid]`

The last one is not a method per se, but follows a similar pattern and allows to get the data for a particular entity item.

<a name="method-info"></a>
### Info

This method returns information about the entity, mainly the definition of the fields.

> **This method doesn't accept parameters.**

Example:

```
curl -XGET 'http://api.rwlabs.org/v0/country/info'
```

Returns:

```json
{
	"version": 0,
	"status": 200,
	"data": {
		"type": "country",
		"info": {
			"default_field": "name",
			"fields": {
				"id": {
					"type": "number",
					"sortable": true
				},
				"url": {
					"type": "string",
					"not_searchable": true
				},
				"name": {
					"type": "string",
					"exact": true,
					"sortable": true
				},
				"shortname": {
					"type": "string",
					"exact": true,
					"sortable": true
				},
				"iso3": {
					"type": "string",
					"exact": true,
					"sortable": true
				},
				"current": {
					"type": "boolean"
				},
				"featured": {
					"type": "boolean"
				},
				"description": {
					"type": "string",
					"format": "markdown"
				}
			}
		}
	}
}
```

> The `default_field` shows what will be returned in a `list` query if no fields are specified. See [list fields](#method-list-fields).

The result is a list of properties for each field.

| field property     | description | values |
| ------------------ | ----------- | ------ |
| **type**           | Indicates what kind of value the field can contain. If type is not present for a field, then it means this field is a `container` that can not be used directly unless `default` is defined. | `boolean`, `date`, `number` or `string` |
| **default**        | Indicates that using the field will default to the field indicated in this property. | another field name |
| **exact**          | Indicates that the field can also be used to match an exact value by appending `.exact` to the name of the field when querying or filtering. | `true` or not present |
| **multi**          | Indicates that the field can contain a single value or an array of values. | `true` or not present |
| **sortable**       | Indicates the field can be used to sort the the results. | `true` or not present |
| **not_searchable** | Indicates that the field can not be used in the filters or query but its value can be fetched. | `true` or not present |
| **format**         | Indicates the format of the content of the field. Currently the only format available is `markdown` (see [Markdown](http://daringfireball.net/projects/markdown/)). Left undefined it defaults to no special format. | currently `markdown` or not present |

> **Dates** are expressed in milliseconds since Epoch.

> **Exact** fields can be used to match an exact term or phrase. Searching for ***Sudan*** in `country.name.exact` will match documents tagged with ***Sudan*** but not documents tagged with ***South Sudan***.

> Some fields in **markdown** format can contain relative links to [ReliefWeb](http://reliefweb.int) reports like `[Some title](/node/123456)`. These links need consideration, and should be replaced with absolute links before transforming the text into html.

<a name="container-fields"></a>
##### Container fields.

Fields without the `type` property defined are `container` fields. They do not contain data themselves, but return useful related information, especially when combined with [common fields](#common-fields).

For example, the definition for the `date` field in reports is as follows:

```json
{
  "date": {
    "default":"date.created"
  },
  "date.created": {
    "type":"date",
    "sortable":true
  },
  "date.changed": {
    "type":"date",
    "sortable":true
	}
  "date.original": {
    "type":"date",
    "sortable":true
	}
}
```

Searching in the `date` field is the same as searching the `date.created` field.

<a name="common-fields"></a>
##### Common fields

Some `default` fields have the suffix `.common`. These are a shorthand to match all the other `string` fields with the same base name. This allows for shorter and more comprehensive search queries or filters and is useful in two ways:

- searching

  This can be used in `queries` and `filters` *(see [method list - query](#method-list-query) or [method list - filter](#method-list-filter))*. Searching a `common` field allows both shortened syntax and searching several sub-fields at once.

- getting results

  Requesting a `common` field will result in all the subfields being returned at the same time *(see [method list - fields](#method-list-fields))*.

For example, the `country` field in reports defaults to a search on `country.common`. This is equivalent to searching searching in the `country.name`, `country.shortname` and `country.iso3` fields.

```json
{
	"query": {
		"fields": ["country"],
		"value": "DR Congo"
	}
}
```

Is equivalent to:

```json
{
	"query": {
		"fields": ["country.name", "country.shortname", "country.iso3"],
		"value": "DR Congo"
	}
}
```

*See method [list](#method-list) for more details about the queries.*

> ***Common*** fields are not directly accessible but are often the default field for ***container*** fields and can be accessed using the container field name.

[&uarr; top](#top)

<a name="method-list"></a>
### List

This method can be used to get a list of entity items. This is the method for searching for content or generating filtered lists.

It accepts the following parameters, (`fields`, `query`, `filter` and `sort` are explained in more detail below):

| parameter  | description | values |
| ---------- | ----------- | ------ |
| **limit**  | Indicates the maximum number of items to return. The default is `10` and the maximum `1000`. | `1` to `1000` |
| **offset** | Indicates the offset from which to return the items. It can be used to create a pager. The default is `0`. | >= `0` |
| **fields** | Indicates which fields to `include` or `exclude` for each item. The default field returned depends on the entity type. See [below](#method-list-fields) for more details. | array of field names to `include` or `exclude` |
| **query**  | Classic search query which accepts an extended syntax. The default is no query. See [below](#method-list-query) for more details. | object |
| **filter** | Allows filtering of the results, it can be a simple filter or a logical combination of filters. See [below](#method-list-filter) for more details. | object |
| **sort**   | Allows sorting of the results. See [below](#method-list-sort) for more details. | array of field name and sort direction |

Example:

```json
curl -XGET 'http://api.rwlabs.org/v0/report/list' -d '{
	"offset": 0,
	"limit": 3,
	"fields": {
		"include": ["url", "title", "primary_country"],
		"exclude": ["primary_country.shortname"]
	},
	"query": {
		"value": "syria humanitarian",
		"fields": ["primary_country^5", "title^2", "body"],
		"operator": "and"
	},
	"filter": {
		"conditions": [{
			"field": "theme",
			"value": ["shelter", "protection"]
		},
		{
			"field": "headline"
		}],
		"operator": "and"
	}
}'
```

Returns

```json
{
	"version": 0,
	"status": 200,
	"data": {
		"type": "report",
		"time": 83,
		"total": 4,
		"count": 3,
		"list": [{
			"id": "572174",
			"score": 4.3886194,
			"fields": {
				"url": "http://reliefweb.int/node/572174",
				"title": "Syria Humanitarian Needs Overview, 26 April 2013",
				"primary_country": {
					"id": "226",
					"name": "Syrian Arab Republic",
					"iso3": "syr"
				}
			}
		},
		{
			"id": "572806",
			"score": 4.2634196,
			"fields": {
				"url": "http://reliefweb.int/node/572806",
				"title": "Regional Analysis Syria - 30 April 2013",
				"primary_country": {
					"id": "226",
					"name": "Syrian Arab Republic",
					"iso3": "syr"
				}
			}
		},
		{
			"id": "573651",
			"score": 1.6755415,
			"fields": {
				"url": "http://reliefweb.int/node/573651",
				"title": "UNHCR provides tents for hundreds of flood victims in Libya",
				"primary_country": {
					"id": "140",
					"name": "Libya",
					"iso3": "lby"
				}
			}
		}]
	}
}
```

<a name="method-list-fields"></a>
#### Fields

The `fields` parameter is an object with 2 properties: `include` and `exclude`. Each property accepts an array of field names.

> This `fields` parameter is not to be confused with `fields` as parameters for a `query`. These influence which fields are returned, not which are searched in.

For field names, refer to the entity description as returned by the **info** method. If no `fields` parameter is specified, the default is returned. See [info](#method-info).

Adding a [container](#container-fields) field that defaults to [common](#common-fields) to the `include` property returns all the sub-fields:

```json
{
	"limit": 1,
	"fields": {
		"include": ["title", "country"]
	},
	"query": {
		"fields": ["title", "body"],
		"value": "humanitarian"
	}
}
```

This query returns the above **fields**:

```json
{
	"fields": {
		"title": "Transitions and Durable Solutions for Displaced Persons: 21 Reasons for Optimism",
		"country": [{
			"id": "13",
			"name": "Afghanistan",
			"iso3": "afg"
		},
		{
			"id": "182",
			"name": "Pakistan",
			"iso3": "pak"
		}]
	}
}
```

In the above example, having selected **country** to include in the result, the full object with its sub-fields (id, name, iso3) is returned.

This is the same query with **country.name** instead of **country** in `include`:

```json
{
	"limit": 1,
	"fields": {
		"include": ["title", "country.name"]
	},
	"query": {
		"fields": ["title", "body"],
		"value": "humanitarian"
	}
}
```

This query returns the above **fields**:

```json
{
	"fields": {
		"title": "Transitions and Durable Solutions for Displaced Persons: 21 Reasons for Optimism",
		"country": [{
			"name": "Afghanistan"
		},
		{
			"name": "Pakistan"
		}]
	}
}
```

Alternatively, it's possible to specify fields or sub-fields to exclude by adding them to the `exclude` property:

```json
{
	"limit": 1,
	"fields": {
		"include": ["title", "country"],
		"exclude": ["country.iso3"]
	},
	"query": {
		"fields": ["title", "body"],
		"value": "humanitarian"
	}
}
```

This query returns the above **fields**:

```json
{
	"fields": {
		"title": "Transitions and Durable Solutions for Displaced Persons: 21 Reasons for Optimism",
		"country": [{
			"id": "13",
			"name": "Afghanistan"
		},
		{
			"id": "182",
			"name": "Pakistan"
		}]
	}
}
```

<a name="method-list-query"></a>
#### Query

This parameter is used to perform full text queries.

It's an object with 3 properties:

| property     | description | values | example |
| ------------ | ----------- | ------ | ------- |
| **value**    | corresponds to the query itself. It is ***mandatory***. | query string | "situation report Kenya"
| **fields**   | Specifies fields to perform the search query on. Defaults to the `default_field` as mentioned in the entity information (see [entity information](#method-info) for available fields).   | array of fields names | ["title", "country"]
| **operator** | Sets up the logical connector between the terms of the query, by default **spaces** are interprated as ` OR `. | `AND` or `OR` | `AND` &rarr; "humanitarian AND report" |

> This `fields` parameter for `query` is not to be confused with the higher level `fields` parameter. These indicate which fields are searched in, not which are returned.

##### Boost

Names in the `fields` property can have a suffix in the form `^N` where `N` is a positive integer. This will boost the score of the field to which it is applied, meaning that a term in this field will have more "value" than the same term in another field.

```json
{
	"query": {
		"fields": ["title^5", "body"],
		"value": "humanitarian"
	}
}
```

In the above query, `title` is boosted by 5. If two documents have the term `humanitarian`, one in the `title` and the other in the `body`, then the former will be have a better score, be considered more relevant and appear first in the list.

##### Extended syntax

The query `value` property accepts an extended syntax.

- **exact phrase**

  By default, the query searches for each term separated by a space individually.

  It's possible to search for an exact phrase by putting terms inside double quotes `"`:

  ```
  "situation report" humanitarian
  ```

  This query means `situation report` OR `humanitarian`.

- **inside query operator**

  By default spaces are interpreted as `OR`. This behavior can be changed by specifying a default operator in the query `operator` property.

  It's also possible to explicitely specify the relationship between terms inside the query:

  ```
  "situation report" AND humanitarian
  ```

- **inside query fields**

  By default, the query is executed on the `default_field` property of the entity (see entity information). It can be overriden by specifying field names in the `fields` property of the query.

  It's also possible to specify fields inside the query. The syntax is `fieldname` `:` `term`.

  ```
  country:France AND title:humanitarian
  ```

- **parentheses**

  It's possible to define logical groups inside the query by putting parts into parentheses:

  ```
  ("situation report" AND humanitarian) OR country:France
  ```

[&uarr; top](#top)

<a name="method-list-filter"></a>
#### Filter

The filter parameter is of 2 kinds. It can be a simple filter (field, value) or a logical combination of conditions, each condition being either a filter or another combination of conditions.

The following properties are available:

| property   | description | values |
| ---------- | ----------- | ------ |
| operator   | this property is always available. It corresponds to the logical connector between the filter values or the filter conditions. Default is `AND`. | `AND` or `OR` |
| negate     | This property is always available. It is used to negate the filter, for finding documents not containing the filter value. | `true` or not present |
| field      | This property is mandatory if the filter is a simple filter, but **can not** be defined at the same time as `conditions`. | field name |
| value      | This property is mandatory for `range` and `value` type filters only. Otherwise it **must not** be defined. See the description of the filter types below for more details. | single value, array or object |
| conditions | This property is used to combine filters with a logical connector (the `operator` property). It **can not** be defined as the same time as `field` and `value` | array of filters |

##### Simple filter

A simple filter/condition can be of 3 types:

  - **exists**

  Used to filter documents for which the specified field exists (has a value). The `field` property must be the field to check and the `value` property must not be defined. The `negate` property, if set, finds documents without the specified field. The `operator` property is ignored.

  ```json
	{
		"filter": {
			"field": "headline"
		}
	}
  ```

  - **range**

  The range filter can only be used with fields of type `date` or `number`. The `value` property is an object with two properties `from` and `to`. The `negate` property, if set, finds documents with values outside the specified range. The `operator` property is ignored.

    - If only `from` is defined then it will filter by values **greater or equal** to the `from` value.
    - If only `to` is defined then it will filter by values **lower or equal** to the `to` value.
    - If both `from` and `to` are defined then it will filter by values **between** the `from` and `to` values.

  ```json
	{
		"filter": {
			"field": "date.created",
			"value": {
				"from": 13697412340000,
				"to": 13697486790000,
			}
		}
	}
  ```

  > **Dates** are expressed in milliseconds since Epoch.

  - **value**

  Used to filter by a value. The `value` property can be either a single value or an array of values. The `operator` defines the logical relationship between the values in an array and is ignored for single values. The `negate` property, if set, finds documents that don't match the value(s).

  ```json
	{
		"filter": {
			"field": "country",
			"value": ["France", "Spain"],
			"operator": "AND"
		}
	}
  ```

  This filter will match documents where the country field contains both "France" and "Spain".

##### Conditions

A filter with the `conditions` property defined corresponds to a logical connection between the filters indicated in the `conditions` array. The `operator` defines the relationship between the filters. The `negate` property, if set, filters documents that don't match either all the conditions (operator `AND`) or at least one of the conditions (operator `OR`).

Each condition can be either a simple filter as described above or another *conditional* filter.

```json
{
	"filter": {
		"operator": "AND",
		"conditions": [{
			"field": "title",
			"value": "humanitarian"
		},
		{
			"field": "date.created",
			"value": {
				"from": 13697412340000
			}
		}]
	}
}
```

The above filter will return documents with both `humanitarian` in the title and created after `Tue, 28 May 2013 11:40:34 GMT` (`13697412340000` in milliseconds).

Conditional filters can also be nested as illustrated below:

```json
{
	"filter": {
		"operator": "AND",
		"conditions": [{
			"field": "title",
			"value": "humanitarian"
		},
		{
			"operator": "OR",
			"conditions": [{
				"field": "country",
				"value": "DR Congo"
			},
			{
				"field": "source",
				"value": "OCHA"
			}]
		}]
	}
}
```

The above filter will return documents with `humanitarian` in the title and either `DR Congo` as country or `OCHA` as source.

<a name="method-list-sort"></a>
#### Sort

The sort parameters accepts an array of **sortable** field names with the sort direction appended to the field name: `:desc` or `:asc`. See [entity information](#method-info) for details about sortable fields. The order of the field names in the array will determine the priority of the sorting.

```json
{
	"sort": ["date:desc", "title:asc"]
}
```

In the above example, the results will be sorted by date (most recent documents first) and then by title for documents with the same date.

[&uarr; top](#top)

<a name="method-item-id"></a>
### Item ID

This "method" is used to get the data for a single item using its unique ID.

By default, without any parameter, it returns all the available (existing) fields for the entity item.

*See method [info](#method-info) for information on the entity fields.*

Example:

```
curl -XGET 'http://api.rwlabs.org/v0/report/573658'
```

Returns:

```json
{
	"version": 0,
	"status": 200,
	"data": {
		"type": "report",
		"id": 573658,
		"item": {
			"id": "573658",
			"url": "http://reliefweb.int/node/573658",
			"status": true,
			"date": {
				"created": 1367592399000,
				"changed": 1367592851000,
				"original": 1367539200000
			},
			"title": "EU Chief Observer expresses serious concerns about levels of violence affecting the campaign during a visit to Peshawar",
			"body": "Chief Observer of the EU Election Observation Mission (EU EOM) to Pakistan and Member of the European Parliament, Michael Gahler, raised his serious concerns about the increased levels of violence against certain political parties during a visit to Peshawar on 2 May. Mr. Gahler reiterated his call, when visiting Karachi last week, on state authorities to do their utmost to protect the lives of candidates and citizens and safeguard the democratic process.\n\n\u201cThe targeted attacks on certain political parties and their supporters in parts of Khyber Pakhtunkhwa, Sindh and Balochistan are not only affecting these parties by distorting the playing field. In fact, every attack is an assault on the democratic process as a whole, and on the right of citizens to have an equal say in their governance. I welcome the efforts of Pakistan\u2019s state authorities to provide security for the elections, and I urge all stakeholders to do everything within their means to stand up against the violence and provide for citizens to exercise their democratic rights without fear.\u201d Said Chief Observer Michael Gahler.\n\nDuring his visit Mr. Gahler met with provincial government officials, the election administration, political candidates and representatives from civil society from Khyber Pakthunkhwa and the Federally Administered Tribal Areas (FATA).\n\nThe EU EOM\u2019s long-term methodology looks at several stages in the electoral process. The mission observes the elections in Islamabad, Khyber Pakthunkhwa, Punjab and Sindh. While the EU EOM has not deployed any observers in Balochistan and FATA, the Chief Observer\u2019s recent visits show the EU EOM\u2019s interest in actively following what is happening in those areas.",
			"language": [{
				"id": "267",
				"name": "English",
				"code": "en"
			}],
			"primary_country": {
				"id": "182",
				"name": "Pakistan",
				"iso3": "pak"
			},
			"country": [{
				"id": "182",
				"name": "Pakistan",
				"iso3": "pak",
				"primary": true
			}],
			"source": [{
				"id": "2831",
				"name": "European Union",
				"shortname": "EU",
				"longname": "European Union",
				"homepage": "http:\/\/europa.eu\/",
				"type": {
					"id": "271",
					"name": "Government"
				}
			}],
			"format": [{
				"id": "8",
				"name": "News and Press Release"
			}],
			"theme": [{
				"id": "4600",
				"name": "Protection and Human Rights"
			}]
		}
	}
}
```

> The **body** field above is formatted according to the [Markdown](http://daringfireball.net/projects/markdown/) syntax and can be converted to html by using a markdown library.

This "method" accepts only one parameter:

| parameter  | description | values |
| ---------- | ----------- | ------ |
| **fields** | Indicates which fields to `include` or `exclude` in the item data. See [method list - fields](#method-list-fields) for more details. | array of field names to `include` or `exclude` |

For example:

```json
curl -XGET 'http://api.rwlabs.org/v0/report/573658' -d '{
  "fields": {
    "include" : ["country.iso3"]
  }
}'
```

Returns:

```json
{
  "version":0,
  "status":200,
  "data":{
    "type":"report",
    "id":573658,
    "item":{
      "fields":{
        "country":[{
          "iso3":"pak"
        }]
      }
    }
  }
}
```

[&uarr; top](#top)

<a name="status-codes"></a>

The API uses the following subset of [HTTP status codes](https://en.wikipedia.org/wiki/List_of_HTTP_status_codes):

| code    | type    | description |
| ------- | ------- | ----------- |
| **200** | success | ***Successful API call.*** The data is in the `data` property of the JSON object. |
| **400** | error   | ***Syntax error.*** The passed parameters couldn't be parsed due to a syntax error, for example: wrong usage of a parameter, invalid operator etc. |
| **404** | error   | ***API endpoint not found.*** Call to a method or an endpoint that doesn't exist like using the ID of a document that has been removed. |
| **405** | error   | ***HTTP method not allowed.*** For example trying to call an endpoint using the method `PUT` while only `GET` is supported. |
| **410** | error   | ***Deprecated API version.*** Call to a version of the API that has been deprecated. |
| **500** | error   | ***Internal server error.*** Problem in the API itself. |
| **503** | error   | ***The service is currently unavailable.*** A possible cause is maintenance. |

> In case of error, the message defined in the `error` property of the JSON object *should* give enough information to resolve the problem.

[&uarr; top](#top)

<a name="examples"></a>
## Examples

**Latest 5 headlines**

URL, primary country name and title of latest 5 headlines, sorted by date.

```json
curl -XGET 'http://api.rwlabs.org/v0/report/list' -d '{
	"limit": 5,
	"fields": {
		"include": ["url", "primary_country.name", "title"]
	},
	"filter": {
		"field": "headline"
	},
	"sort": ["date.created:desc"]
}'
```

or

```
http://api.rwlabs.org/v0/report/list?limit=5&fields[include][0]=url&fields[include][1]=primary_country.name&fields[include][2]=title&filter[field]=headline&sort[0]=date.created:desc
```

Returns:

```json
{
	"version": 0,
	"status": 200,
	"data": {
		"type": "report",
		"time": 2,
		"total": 586,
		"count": 5,
		"list": [{
			"id": "573782",
			"score": 1,
			"fields": {
				"url": "http://reliefweb.int/node/573782",
				"title": "Syria Crisis Bi-Weekly Humanitarian Situation Report - Syria, Jordan, Lebanon, Iraq and Turkey, 18 April - 02 May 2013",
				"primary_country": {
					"name": "Syrian Arab Republic"
				}
			}
		},
		{
			"id": "573768",
			"score": 1,
			"fields": {
				"url": "http://reliefweb.int/node/573768",
				"title": "Middle East, North Africa, Afghanistan and Pakistan: Humanitarian Snapshot (as of 30 April 2013) [EN\/AR]",
				"primary_country": {
					"name": "Syrian Arab Republic"
				}
			}
		},
		{
			"id": "573763",
			"score": 1,
			"fields": {
				"url": "http://reliefweb.int/node/573763",
				"title": "UN warns nearly 13,000 families displaced near Afghan border, many more could follow",
				"primary_country": {
					"name": "Pakistan"
				}
			}
		},
		{
			"id": "573736",
			"score": 1,
			"fields": {
				"url": "http://reliefweb.int/node/573736",
				"title": "DR Congo: UN food relief agency warns of \u2018Triangle of Death\u2019",
				"primary_country": {
					"name": "Democratic Republic of the Congo"
				}
			}
		},
		{
			"id": "573717",
			"score": 1,
			"fields": {
				"url": "http://reliefweb.int/node/573717",
				"title": "Niger : Bulletin humanitaire num\u00e9ro 17, 2 mai 2013",
				"primary_country": {
					"name": "Niger"
				}
			}
		}]
	}
}
```

**Latest Map for Syria**

```json
curl -XGET 'http://api.rwlabs.org/v0/report/list' -d '{
	"limit": 1,
	"fields": {
		"include": ["url", "title", "file.preview"]
	},
	"query": {
		"value": "primary_country:Syria format:map"
	},
	"filter": {
		"field": "file.preview"
	},
	"sort": ["date.created:desc"]
}'
```

or

```
http://api.rwlabs.org/v0/report/list?limit=1&fields[include][0]=url&fields[include][1]=title&fields[include][2]=file.preview&query[value]=primary_country:Syria format:map&filter[field]=file.preview&sort[0]=date.created:desc
```

Returns:

```json
{
	"version": 0,
	"status": 200,
	"data": {
		"type": "report",
		"time": 2,
		"total": 1,
		"count": 1,
		"list": [{
			"id": "573773",
			"score": 2.1177814,
			"fields": {
				"url": "http://reliefweb.int/node/573773",
				"title": "Regional Humanitarian Funding Update (as of 30 April 2013)",
				"file": [{
					"preview": "http:\/\/reliefweb.int\/sites\/reliefweb.int\/files\/resources-pdf-previews\/147308-Regional%20Humanitarian%20Funding%20Update%2030%20Apr%202013..png"
				}]
			}
		}]
	}
}
```

> **Images** or **file previews** (some pdf only) can be pretty large.

> `format: map` is the filter to use for map reports. To inspect *most* of the other possible values, see the filters on the corresponding Reliefweb page (i.e. [Updates](http://reliefweb.int/updates) for reports, [Jobs](http://reliefweb.int/jobs), [Training](http://reliefweb.int/training), [Countries](http://reliefweb.int/country/wld), or on individual [disaster](http://reliefweb.int/disasters)) pages. We are working on a way to make these more explicit.

**Example of an error due to a bad syntax:**

```
http://api.rwlabs.org/v0/report/list?limit=1&fields=country
```

Returns:

```json
{
	"version": 0,
	"status": 400,
	"error": {
		"type": "UnexpectedValueException",
		"message": "Invalid parameter 'fields'. It must be an array with the 'include' and\/or 'exclude' fields defined."
	}
}
```

[&uarr; top](#top)
