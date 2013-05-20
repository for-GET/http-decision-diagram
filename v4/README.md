# http-headers-status

An activity diagram to describe the resolution of HTTP response status codes, given various headers, implemented via semantical callbacks.

And it goes on Twitter as [#httpdd](https://twitter.com/search/realtime?q=httpdd) - HTTP Decision Diagram.

## Diagram

* [PNG](http-headers-status-v4.png) (export)
* [Omnigraffle](http-headers-status-v4.graffle) (source)
    * Size: A0 - 84.1 x 59.4 cm
    * Grid size: 0.5
    * Dot density: 96 dpi

## Overview

The decision diagram is split into standalone color-coded blocks

1. [System](README_system.md) (white)
1. [Request](README_request.md) (blue)
1. [Accept](README_accept.md) (green)
1. [Retrieve](README_retrieve.md) (white)
1. [Precondition](README_precondition.md) (yellow)
1. Create/Process
    * [Create](README_create.md) (violet)
    * [Process](README_process.md) (red)
1. [Response](README_response.md) (cyan)
1. [Error](README_error.md) (gray)

![HTTP headers status](https://rawgithub.com/andreineculau/http-headers-status/master/v4/http-headers-status-v4.png)


---

## Callback Types

**NOTE** All variables referenced below may have specific variances from the under_score notation - camelCase, PascalCase, etc. - when implemented.

The decision diagram makes use of different types of callbacks to get request or resource specific information. Regardless of the type though, each callback MUST

* have read-write access to 2 variables: `Operation` and `Context`
* refrain from doing more/less than what the decision block states
* have pertinent *defaults*

### Operation structure

`Operation` MUST be a key-value structure, initialized when receiving the request, with the following keys:

* `method` = Original HTTP method
* `uri` = Key-value of URI parts and their value. Keys outside [RFC3986](http://tools.ietf.org/html/rfc3986) can be defined inside this structure.
    * `source` = Full original URI e.g. 'http://user:pass@example.com:8080/p/a/t/h?query=string#fragment'
    * `scheme` = Lowercase scheme e.g. 'http'
    * `userinfo` = e.g. 'user:pass'
    * `host` = Lowercase host e.g. 'example.com'
    * `port` = e.g. '8080'
    * `authority` = Concatenated userinfo, lowercased host and port e.g. 'user:pass@example.com:8080'
    * `path` = e.g. '/p/a/t/h'
    * `query` = e.g. '?query=string'
    * `fragment` = e.g. '#fragment'
* `headers` = Key-value of lowercase header names and their values
    * `accept` =
    * `accept-language` =
    * `accept-charset` =
    * `accept-encoding` =
    * `content-type` =
    * `content-length` =
* `accept` = *AcceptHeader*
* `expect` = *ExpectHeader*
* `if-match` = *IfMatchHeader*
* `if-modified-since` = *IfUnmodifiedSinceHeader*
* `if-none-match` = *IfNoneMatchHeader*
* `if-unmodified-since` = *IfModifiedSinceHeader*
* `representation` =
* `response` =
    * `allow` = *AllowHeader*
    * `chosen_content-type` =
    * `chosen_language` =
    * `chosen_charset` =
    * `chosen_encoding` =
    * `content-encoding` = *ContentEncodingHeader*
    * `content-type` = *ContentTypeHeader*
    * `content-language` = *ContentLanguageHeader*
    * `status_code` =
    * `headers` =
    * `representation` =

### Context structure

*Context* MUST be whatever the resource developer desires. It MUST be irrelevant to the decision flow. For the sake of clarity though, in this documentation you may find these references:

* `entity` =
* `response` =
    * `entity` =
* `error` =
    * `entity` =


### Built-in callbacks `: in`
Some callbacks MUST be built-in by the system, and thus they are not explicitly marked on the diagram. They are not specific to the resource or the request and they are an implementation of HTTP-specific logic.

### Resource decision callbacks `:bin`
Resource logic is coded in these callbacks as an answer to binary questions - TRUE or FALSE. These callbacks have the power to end the decision flow early.

### Resource variable callbacks `:var`
Resource logic is coded in these callbacks as variable values. Each callback defines the type that it handles, and returning an unexpected type or value will yield _500 Internal Server Error_. These callbacks do NOT have the power to end the decision flow early.
