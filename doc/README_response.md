1. [System](README_system.md) (white)
1. [Request](README_request.md) (blue)
1. [Accept](README_accept.md) (green)
1. [Retrieve](README_retrieve.md) (white)
1. [Precondition](README_precondition.md) (yellow)
1. Create/Process
    * [Create](README_create.md) (violet)
    * [Process](README_process.md) (red)
1. [Response](README_response.md) (cyan)
1. [Alternative](README_alternative.md) (gray)

![HTTP headers status](https://rawgithub.com/for-GET/http-decision-diagram/master/httpdd.png)

## Response

| | callback | output | default
|:-- | ---: | :--- | :---
|N3 | [`is_create_done :bin`](#is_create_done-bin) | T / F | `is_process_done :bin`
|N6 | [`create_see_other :bin`](#create_see_other-bin) | T / F | `see_other :bin`
| | [`content_types_provided:handler :bin`](#content_types_provided-handler-var) | T / F |
| | [`to_content : in`](#to_content--in) | T / F | FALSE
| - | [`to_resource_content :bin`](#is_resource_content-bin) | T / F |
| - | [`content_location :var`](#content_location-var) | *URI* |
| - | [`vary :var`](#vary-var) | [ [ *HeaderName* ] ] |
| - | [`expires :var`](#vary-var) | *Date* |
| - | [`last_modified :var`](#last_modified-var) | *Date* | Now
| - | [`etag :var`](#etag-var) | *ETag* |
|N14 | [`is_process_done :bin`](#is_process_done-bin) | T / F | TRUE
|N10 | [`see_other :bin`](#see_other-bin) | T / F | FALSE
| | [`path :var`](#path-var) | *URI* |
|N9 | [`has_multiple_choices :bin`](#has_multiple_choices-bin) | T / F | FALSE
|N8 | [`content_types_provided:handler :bin`](#content_types_provided-handler-var) | T / F |
| | [`to_content : in`](#to_content--in) | T / F | FALSE
| - | [`to_resource_content :bin`](#is_resource_content-bin) | T / F |
| - | [`content_location :var`](#content_location-var) | *URI* |
| - | [`cache :var`](#cache-var) | *String* |
| - | [`vary :var`](#vary-var) | [ [ *HeaderName* ] ] |
| - | [`expires :var`](#vary-var) | *Date* |
| - | [`last_modified :var`](#last_modified-var) | *Date* | Now
| - | [`etag :var`](#etag-var) | *ETag* |

> FIXME Explanations needed

### `to_resource_content :bin`

Return TRUE if the content is resource content, as in this content would be the response to a GET/HEAD request to the resource identified by the _Content-Location_ header.

By default, this returns TRUE if a _Content_Location_ header has been set (e.g. during the `create` or `process` callback).

### `content_location :var`

Return a _Content-Location_ header.

By default, this returns an already set _Content-Location_ response header or the location of the request target i.e. the resource would reply with its own content.
