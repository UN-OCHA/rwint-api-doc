## Getting Started using the ReliefWeb API

The ReliefWeb API was originally designed internally to help power a mobile web view of the [Reliefweb.int](http://Reliefweb.int) website.  It has since been developed to allow for the public to access and make use of ReliefWeb data programatically.  

This first 1.0 release of the API has been designed to allow for easy self discovery of data and hierarchy via a self documenting API structure.  API reference documentation has been published using SWAGGER, a tool that allows you to experiment and explore how various API calls work directly within the documentation.  The API has also been designed to allow for future augmentation and improvement once we'e heard your feedback and ideas for improvement!

###How to get started with development

- [Accessing the API](#access)
    - [The API endpoint](#api-url)
- [Call Structure](#setup)
- [API Reference](#reference)

<a name="access"></a>
#### Accessing the API


<a name="api-url"></a>
### API URL

While this remains a Reliefweb Labs project, the url for API calls is:

```
http://api.rwlabs.org
```

<a name="setup"></a>
### API Structure
Any call to the API returns a `JSON` object.

Calls follow the pattern:

```
http://APIURL/VERSION/[ENTITY/[METHOD|ITEMID[?PARAMETERS]]]
```

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

<a name="reference"></a>
### API Reference
[Visit the API  Reference](/api_reference.md)
