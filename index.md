---
layout: "index"
---

<a name="top"></a>
# ReliefWeb API - Documentation

This is the documentation for the ReliefWeb API.

The API allows to fetch content from [ReliefWeb](http://reliefweb.int) like the latest headlines, job offers or disasters.

## Table of contents

- [**General information**](#general-information)
- [**Version**](#version)
- [**Entities**](#entities)
- [**Parameters**](#parameters)
- [**Methods**](#methods)
  - [info](#method-info)
  - [list](#method-list)
  - [item ID](#method-item-id)
- [**Examples**](#examples)


<a name="general-information"></a>
## General information

Any call to the API returns a `JSON` object.

The `HTTP status code` of the response indicates what happened during the call.

If a call is successful the status code is `200` and the relevant data is in the `data` property of the object.

In case of error, in addition to the appropriate status code, a message is set in the `error` property of the object.

> For convenience, the **status** code is also always present in the JSON object.

Example of a successful call:

```
http://api.rwdev.org/v0/report/list?limit=1
```

Returns

```json

{
	"version": 0,
	"satus": 200,
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

Example of an error due to a bad syntax:

```
http://api.rwdev.org/v0/report/list?limit=1&fields=country
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

The status code are as follows:

| code    | type    | description |
| ------- | ------- | ----------- |
| **200** | success | ***Successful API call.*** The data is in the `data` property of the JSON object. |
| **400** | error   | ***Syntax error.*** The passed parameters couldn't be parsed due to a syntax error, for example: wrong usage of a parameter, invalid operator etc. |
| **404** | error   | ***API endpoint not found.*** Call to a method or an endpoint that doesn't exist like using the ID of a document that has been removed. |
| **405** | error   | ***HTTP method not allowed.*** For example trying to call an endpoint using the method `PUT` while only `GET` is supported. |
| **410** | error   | ***Deprecated API version.*** Call to a version of the API that has been deprecated. |
| **500** | error   | ***Internal server error.*** Problem in the API itself. |
| **503** | error   | ***The service is currently unavailable.*** A possible cause is maintenance. |

> In case of error, a hopefully explicit enough error message is defined in the `error` property of the JSON object.

[&uarr; top](#top)


<a name="version"></a>
## Version

The current available version is a beta version labeled **`v0`**.

Calling the API with just the version number allows to discover the available API endpoints:

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

Returns:

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

| field property     | description | values |
| ------------------ | ----------- | ------ |
| **type**           | Indicates what kind of value the field can contain. If type is not present for a field, then it means this field a container that can not be used directly unless `default` is defined. | `boolean`, `date`, `number` or `string` |
| **default**        | Indicates that using the field for search for example will default to the field indicated in this property. | another field name |
| **exact**          | Indicates that the field can also be used to match an exact value by appending `.exact` to the name of the field when querying or filtering. | `true` or not present |
| **multi**          | Indicates that the field can contain a single value or an array of values. | `true` or not present |
| **sortable**       | Indicates the field can be used to sort the the results. | `true` or non present |
| **not_searchable** | Indicates that the field, can not be used in the filters or query but its value can fetch. | `true` or non present |
| **format**         | Indicates the format of the content of the field. Currently it's not defined (no special format) or set to `markdown` (see [Markdown](http://daringfireball.net/projects/markdown/)). | currently `markdown` or non present |

> **Dates** are expressed in milliseconds since Epoch.

> **Exact** fields can be used to match an exact term or phrase. Searching for ***Sudan*** in `country.name.exact` will match documents tagged with ***Sudan*** but not documents tagged with ***South Sudan***.

> Some fields in **markdown** format can contain relative links to [ReliefWeb](http://reliefweb.int) reports like `[Some title](/node/123456)` and should be replaced with absolute links before transforming the text into html for example.

##### Container fields.

Fields without the `type` property defined are `container` fields. They are useful in 2 ways:

- searching

  If the `default` property is defined then it can be used in `queries` and `filters` *(see [method list - query](#method-list-query) or [method list - filter](#method-list-filter))*. In that case searching in the `container` field is equivalent to searching in the `default` field. It allows to shorten the syntax and if the `default` field is a `common` field type then it also allows to search in several sub-fields at once (see below for `common` fields).

- getting results

  Selecting a `container` field to be returned will result in all the subfields to be returned at the same time *(see [method list - fields](#method-list-fields))*.

For example the definition for the `primary_country` field is as follow:

```json
{
	"primary_country": {
		"default": "primary_country.common"
	},
	"primary_country.id": {
		"type": "number"
	},
	"primary_country.name": {
		"type": "string",
		"exact": true,
		"sortable": true
	},
	"primary_country.shortname": {
		"type": "string",
		"exact": true,
		"sortable": true
	},
	"primary_country.iso3": {
		"type": "string",
		"exact": true,
		"sortable": true
	}
}
```

Searching in the `primary_country` field means searching in the `primary_country.common` which as described below is equivalent to searching in `primary_country.name`, `primary_country.shortname` and `primary_country.iso3` at the same time.

```json
{
  "query": {
    "fields": ["primary_country"],
    "value": "DR Congo"
  }
}
```

Setting the `primary_contry` field as field to include in the results will give:

```json
{
  "primary_country" : {
    "id" : 75,
    "name" : "Democratic Republic of the Congo",
    "shortname" : "DR Congo",
    "iso3" : "cod"
  }
}
```

##### Common fields

Some `default` fields have the suffix `.common`, they are a match to all the other `string` fields with the same base name.

Searching in the `primary_country` means searching in the `country.common` field which is equivalent to searching searching in the `country.name`, `country.shortname` and `country.iso3` fields.

It allows for shorter and more comprehensive search queries or filters.

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

This method can be used to get a list of entity items.

It accepts the following paramaters:

| parameter  | description | values |
| ---------- | ----------- | ------ |
| **limit**  | Indicates the maximum number of items to return. The default is `10` and the maximum `1000`. | `1` to `1000` |
| **offset** | Indicates the offset from which to return the items. It can be used to create a pager. The default is `0`. | >= `0` |
| **fields** | Indicates wich fields to `include` or `exclude` for each item. It can be used to get a partial field. The default field depends on the entity type. See below for more details. | array of field names to `include` or `exclude` |
| **query**  | This is the main parameter to search for particular items. It's a classic search query which accepts an extended syntax. The default is no query. See below for more details. | object |
| **filter** | This allows to filter the results, it can be a simple filter or a logical combination of filters. The default filter depends on the entity type is overriden when the filter parameter is present. | object |
| **sort**   | This allows to sort the results | array of field name and sort direction |

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
	"satus": 200,
	"data": {
		"type": "report",
		"time": 83,
		"total": 4,
		"count": 3,
		"list": [{
			"id": "572174",
			"score": 4.3886194,
			"fields": {
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
#### Query

This parameter is used to perform full text queries.

It's an object with 3 properties:

| property     | description | values | example |
| ------------ | ----------- | ------ | ------- |
| **value**    | This prorperty corresponds to the query itself. It is ***mandatory***. | query string | "situation report Kenya"
| **fields**   | This property can be used to specify on which fields to perform the search query. It defaults to the `default_field` as mentioned in the entity information (see [entity information](#method-info) for available fields).   | array of fields names | ["title", "country"]
| **operator** | This property can be used to set up the logical connector between the terms of the query, by default **spaces** are interprated as ` OR `. | `AND` or `OR` | `AND` &rarr; "humanitarian AND report" |

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

In the above query, `title` is boosted by 5. If 2 documents have the term `humanitarian`, for one in the `title` and the other in the `body` then, the former one will be have a better score and be considered as more relevant and will appear first in the list.

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
#### Filter

The parameter filter is of 2 kinds. It can be a simple filter (field, value) or a logical combination of conditions, each condition being either a filter or another combination of conditions and so on.

The following properties are available:

| property   | description | values |
| ---------- | ----------- | ------ |
| operator   | this property is always available. It corresponds to the logical connector between the filter values or the filter conditions. Default is `AND`. | `AND` or `OR` |
| negate     | This property is always available. It is used to negate the filter, like finding documents not containing the filter value. | `true` or not present |
| field      | This property is mandatory if the filter is a simple filter or **can not** be defined at the same time as `conditions`. | field name |
| value      | This property is mandatory for `range` and `value` type filters otherwise it must not be defined. See the description of the filter types for the accepted values. | single value, array or object |
| conditions | This property is used to combine filters with a logical connector (the `operator` property). It **can not** be defined as the same time as `field` and `value` | array of filters |

##### Simple filter

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

A filter with the `conditions` property defined correspond to a logical connection between the filters indicated in the `conditions` array. The `operator` will define the relationship between the filters. The `negate` property can also be defined to filter documents that don't match either all the conditions (operator `AND`) or at least one of the conditions (operator `OR`).

Each condition can be either a simple filter as described above or another *conditional* filter.

```json
{
  "filter" : {
    "operator" : "AND",
    "conditions" : [
      {
        "field" : "title",
        "value" : "humanitarian"
      },
      {
        "field" : "date.created",
        "value" : {
          "from" : 13697412340000
        }
      }
    ]
  }
}
```

The above filter will return documents with both `humanitarian` in the title and created after `Tue, 28 May 2013 11:40:34 GMT` (`13697412340000` in milliseconds).

Conditional filter can also be nested as illustrated below:

```json
{
  "filter" : {
    "operator" : "AND",
    "conditions" : [
      {
        "field" : "title",
        "value" : "humanitarian"
      },
      {
        "operator" : "OR",
        "conditions" : [
          {
            "field" : "country",
            "value" : "DR Congo"
          },
          {
            "field" : "source",
            "value" : "OCHA"
          }
        ]
      }
    ]
  }
}
```

The above filter will return documents with `humanitarian` in the title and either `DR Congo` as country or `OCHA` as source.

#### Sort

The sort parameters accepts an array of **sortable** field names with the sort direction appended to the field name: `:desc` or `:asc`. See [entity information](#method-info) for details about sortable fields. The order of the field names in the array will determine the priority of the sorting.

```json
{
  "sort" : ["date:desc", "title:asc"]
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
curl -XGET 'http://api.rwdev.org/v0/report/573658'
```

Returns:

```json
{
	"version": 0,
	"satus": 200,
	"data": {
		"type": "report",
		"id": 573658,
		"item": {
			"id": "573658",
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

This "method" accepts only 1 parameter:

| parameter  | description | values |
| ---------- | ----------- | ------ |
| **fields** | Indicates wich fields to `include` or `exclude` in the item data. See [method list - fields](#method-list-fields) for more details. | array of field names to `include` or `exclude` |


<a name="examples"></a>
## Examples

**Latest 10 headlines**

```
curl -XGET 'http://api.rwdev.org/v0/report/list' -d
```

```json
'{
  "limit" : 5,
  "fields" : {
    "include" : ["primary_country.name", "title"]
  },
  "filter" : {
    "field" : "headline"
  },
  "sort" : ["date.created:desc"]
}'
```

or

```
http://api.rwdev.org/v0/report/list?limit=5&fields[include][0]=primary_country.name&fields[include][1]=title&filter[field]=headline&sort[0]=date.created:desc
```

Returns:

```json
{
	"version": 0,
	"satus": 200,
	"data": {
		"type": "report",
		"time": 2,
		"total": 586,
		"count": 5,
		"list": [{
			"id": "573782",
			"score": 1,
			"fields": {
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

```
curl -XGET 'http://api.rwdev.org/v0/report/list' -d
```

```json
'{
  "limit" : 1,
  "fields" : {
    "include" : ["title", "file.preview"]
  },
  "query" : {
    "value" : "primary_country:Syria format:map"
  },
  "filter" : {
    "field" : "file.preview"
  },
  "sort" : ["date.created:desc"]
}'
```

or

```
http://api.rwdev.org/v0/report/list?limit=1&fields[include][0]=title&fields[include][1]=file.preview&query[value]=primary_country:Syria format:map&filter[field]=file.preview&sort[0]=date.created:desc
```

Returns:

```json
{
	"version": 0,
	"satus": 200,
	"data": {
		"type": "report",
		"time": 2,
		"total": 1,
		"count": 1,
		"list": [{
			"id": "573773",
			"score": 2.1177814,
			"fields": {
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