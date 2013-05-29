---
layout: "index"
---

<a name="top"></a>
# ReliefWeb API - Documentation

This is the documentation for the ReliefWeb API.

The API allows to fetch content from [ReliefWeb](http://reliefweb.int) like the latest headlines, job offers or disasters.

## Table of contents

- [**Versions**](#versions)
- [**Entities**](#entities)
- [**Paramaters**](#parameters)
- [**Methods**](#methods)
  - [info](#method-info)
  - [list](#method-list)
  - [ID](#method-item)


<a name="versions"></a>
## Versions

The current available version is a beta version labeled **`v0`**.

By calling the API with just the version number, you can discover the available API endpoints:

```
curl -XGET 'http://api.rwdev.org/v0'
```

```json
{
	"version": 0,
	"status": 200,
	"data": {
		"title": "ReliefWeb API",
		"endpoints": {
			"report": {
				"info": "http:\/\/api.rwdev.org\/v0\/report\/info",
				"list": "http:\/\/api.rwdev.org\/v0\/report\/list",
				"item": "http:\/\/api.rwdev.org\/v0\/report\/[ID]"
			},
			"job": {
				"info": "http:\/\/api.rwdev.org\/v0\/job\/info",
				"list": "http:\/\/api.rwdev.org\/v0\/job\/list",
				"item": "http:\/\/api.rwdev.org\/v0\/job\/[ID]"
			},
			"training": {
				"info": "http:\/\/api.rwdev.org\/v0\/training\/info",
				"list": "http:\/\/api.rwdev.org\/v0\/training\/list",
				"item": "http:\/\/api.rwdev.org\/v0\/training\/[ID]"
			},
			"country": {
				"info": "http:\/\/api.rwdev.org\/v0\/country\/info",
				"list": "http:\/\/api.rwdev.org\/v0\/country\/list",
				"item": "http:\/\/api.rwdev.org\/v0\/country\/[ID]"
			},
			"disaster": {
				"info": "http:\/\/api.rwdev.org\/v0\/disaster\/info",
				"list": "http:\/\/api.rwdev.org\/v0\/disaster\/list",
				"item": "http:\/\/api.rwdev.org\/v0\/disaster\/[ID]"
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

[&uarr; top](#top)


<a name="parameters"></a>
## Parameters

There are 2 ways to pass parameters to a method.

- As json object in the request body:

```
curl -XGET 'http://api.rwdev.org/v0/report/list' -d '{
  "query": {
    "fields": ["title", "body"],
    "value": "humanitarian"
  }
}'
```

- As standard GET paramaters:

```
http://api.rwdev.org/v0/report/list?query[value]=humanitarian&query[fields][0]=title&query[fields][1]=body
```

> **Only the HTTP method GET is allowed.**

[&uarr; top](#top)


<a name="methods"></a>
## Methods


Methods are the way to get the data for an entity type.

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

This method returns information about the entity, mainly fields definition.

> **This method doesn't accept parameters.**

Example:

```
curl -XGET 'http://api.rwdev.org/v0/country/info'
```

```json
{
	"version": 0,
	"satus": 200,
	"data": {
		"type": "country",
		"info": {
			"fields": {
				"id": {
					"type": "number",
					"sortable": true
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
					"type": "string"
				}
			}
		}
	}
}
```

The result is a list of properties for each field.

| Field property     | description | values |
| ------------------ | ----------- | ------ |
| **type**           | indicates what kind of value the field can contain. If type is not present for a field, then it means this field a container that can not be used directly unless `default` is defined. | `boolean`, `date`, `number` or `string` |
| **default**        | indicates that using the field for search for example will default to the field indicated in this property. | another field name |
| **exact**          | indicates that the field can also be used to match an exact value by appending `.exact` to name of the field when querying or filtering. | `true` or not present |
| **multi**          | indicates that the field can contain a single value or an array of values. | `true` or not present |
| **sortable**       | indicates the field can be used to sort the the results. | `true` or non present |
| **not_searchable** | indicates that the field, can not be used in the filters or query but its value can fetch. | `true` or non present |

> **Dates** are expressed in milliseconds since Epoch.

- **Common** fields

Some `default` fields have the suffix `.common`, they are a match to all the other `string` fields with the same base name.

For example, the definition of country field for the entity type **report** is as followed:

```json
{
  "country": {
    "multi": true,
    "default": "country.common"
  },
  "country.id": {
    "type": "number"
  },
  "country.primary": {
    "type": "boolean",
    "not_searchable": true
  },
  "country.name": {
    "type": "string",
    "exact": true
  },
  "country.shortname": {
    "type": "string",
    "exact": true
  },
  "country.iso3": {
    "type": "string",
    "exact": true
  }
}
```

Searching in the `country.common` is equivalent to searching in the `country.name`, `country.shortname` and `country.iso3` field.

> ***Common*** fields are not directly accessible but are often the default field for ***container*** fields and can be accessed using the container field name.

- **Container** fields.

The `country` field doesn't have a type. It's a container field. However it has the property `default` set to the field `country.common`. It means that searching in the `country` field is equivalent to searching in the `country.common` field. It allows for shorter and more comprehensive search queries or filters.

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

[&uarr; top](#top)

<a name="method-list"></a>
### List

This method can be used to get a list of entity items.

It accepts the following paramaters:

| Parameter | description | values |
| --------- | ----------- | ------ |
| limit | limits the number of items to return. The default is `10` and the maximum `1000`. | `1` to `1000` |
| offset | indicates the offset from which to return the items. It can be used to create a pager. The default is `0`. | >= `0` |
| fields | indicates wich fields to `include` or `exclude` for each item. It can be used to get a partial field. The default field depends on the entity type. See below for more details. | array of field names to `include` or `exclude` |
| query | this is the main parameter to search for particular items. It's a classic search query which accepts an extended syntax. The default is no query. See below for more details. | object |
| filter | this allows to filter the results, it can be a simple filter or a logical combination of filters. The default filter depends on the entity type is overriden when the filter parameter is present. | object |
| sort | this allows to sort the results | array of field name and sort direction |

Example:

```
curl -XGET 'http://api.rwdev.org/v0/report/list' -d
```

```json
'{
	"offset": 0,
	"limit": 3,
	"fields": {
		"include": ["title", "primary_country"],
		"exclude": ["primary_country.shortname"]
	},
	"query": {
		"value": "syria humanitarian",
		"fields": ["primary_country^5", "title^2", "body"],
		"operator": "and"
	},
	"filter": {
		"conditions": [{
			"field": "status",
			"value": 1
		},
		{
			"field": "headline"
		}],
		"operator": "and"
	}
}'
```

<a name="method-list-fields"></a>
#### fields

The parameter `field` is an object with 2 properties: `include` and `exclude`. Each property accepts an array of field or sub-field names.

For field names, refer to  the entity description as returned by the **info** method.

Adding a **container** field to the `include` property results in all the sub-fields to be returned:

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
    "country": [
      {
        "id": "13",
        "name": "Afghanistan",
        "iso3": "afg"
      },
      {
        "id": "182",
        "name": "Pakistan",
        "iso3": "pak"
      }
    ]
  }
}
```

In the above example, having selected **country** to include in the result, the full object with its sub-fields (id, name, iso3) is returned.

The same query with **country.name** instead of **country** in `include`:

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
    "country": [
      {
        "name": "Afghanistan"
      },
      {
        "name": "Pakistan"
      }
    ]
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
    "country": [
      {
        "id": "13",
        "name": "Afghanistan"
      },
      {
        "id": "182",
        "name": "Pakistan"
      }
    ]
  }
}
```

<a name="method-list-query"></a>
#### query

This parameter is used to perform full text queries.

It's an object with 3 properties:

| property     | description | values | example |
| ------------ | ----------- | ------ | ------- |
| **value**    | this prorperty corresponds to the query itself. This property is ***mandatory***. | query string | "France title:humanitarian" |
| **fields**   | this property can be used to specify on which fields to perform the search query. It's default to the default field as mentioned in the entity information.   | array of fields names (see [entity information](#method-info) for available fields). | ["title", "country.name"] |
| **operator** | this property can be used to set up the default operator for the query, by default **spaces** are equivalent to ` OR `. | `AND` or `OR` | `AND`: "France AND humanitarian"  |

##### Boost

The field names in the `fields` property can have a suffix in the form `^N` where `N` is a positive integer. This will boost the score of the field to which it is applied, meaning that a term in this field will have more "value" than the same term in another field.

```json
{
  "query": {
    "fields": ["title^5", "body"],
    "value": "humanitarian"
  }
}
```

In the above query, `title` is boosted by 5. If 2 documents have the term `humanitarian`, for one in the `title` and the other in the `body` then, the former one will a better score and will appear first in the list.

##### Extended syntax

The query `value` property accepts an extended syntax.

- **exact phrase**

  By default, the query search each term separated by a space individually.

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

- **parenthesis**

  It's possible to define logical groups inside the query by putting parts into parenthesis:

  ```
  ("situation report" AND humanitarian) OR country:France
  ```

[&uarr; top](#top)

<a name="method-list-filter"></a>
#### filter

The parameter filter is of 2 kinds. It can be a simple filter (field, value) or a logical combination of conditions, each condition being either a filter or another combination of conditions and so on.

The following properties are available:

| property   | description | values |
| ---------- | ----------- | ------ |
| operator   | this property is always available. It corresponds to the logical connector between the filter values or the filter conditions. Default is `AND`. | `AND` or `OR` |
| negate     | This property is always available. It is used to negate the filter, like finding documents not containing the filter value. | `true` or not present |
| field      | This property is mandatory if the filter is a simple filter or **can not** be defined at the same time as `conditions`. | field name |
| value      | This property is mandatory for `range` and `value` type filters otherwise it must not be defined. See the description of the filter types for the accepted values. | single value, array or object |
| conditions | This property is used to combine filters with a logical connector (the `operator` property). It **can not** be defined as the same time as `field` and `value` | array of filters |

#### Simple filter

A simple filter/condition can be of 3 types:

  - **exists**

  Used to filter documents for which the specified field exists (has a value). The `field` property must be the field to check and the `value` property must not be defined. The `operator` property is ignored but the `negate` property can be set to true in order to find documents without the specified field.

  ```json
    {
      "filter" : {
        "field" : "headline"
      }
    }
  ```

  - **range**

  Used to filter by date or numeric range. In that case the `value` property is an object with 2 properties `from` and `to`. A range filter can only be used with fields of type `date` or `number`. The `operator` property is ignored but the `negate` property can be set to true in order to find documents with a field value outside of the range.

    - If only `from` is defined then it will filter by values **greater or equal** to the `from` value.
    - If only `to` is defined then it will filter by values **lower or equal** to the `to` value.
    - If both `from` and `to` are defined then it will filter by values **between** the `from` and `to` values.

  ```json
    {
      "filter" : {
        "field" : "date.created",
        "value" : {
          "from" : 13697412340000,
          "to" : 13697486790000,
        }
      }
    }
  ```

  > **Dates** are expressed in milliseconds since Epoch.

  - **value**

  Used to filter by a value. This is the classic filter. The `value` property can however be either a single value or an array of values. In the latter case, he `operator` property is ignored, otherwise it defined the logical relationship between the values. In any case, the `negate` property can be set to true in order to find documents that don't contain the value.

  ```json
    {
      "filter" : {
        "field" : "country",
        "value" : ["France", "Spain"],
        "operator" : "AND"
      }
    }
  ```

  This filter wll match documents where the country field contains both "France" and "Spain".

##### Conditions