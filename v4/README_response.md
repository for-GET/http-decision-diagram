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

![HTTP headers status](http-headers-status-v4.png)

## Response

 | callback | output | default
:-- | ---: | :--- | :---
N11 | [`is_process_done :bin`](#is_process_done-bin) | T / F | TRUE
N12 | [`content_types_provded:handler :bin`](#content_types_provided-handler-var) | T / F |
N13 | [`has_multiple_choices :bin`](#has_multiple_choices-bin) | T / F | FALSE
[`cache :var`](#cache-var) | *String* |
[`vary :var`](#vary-var) | [ *String* ] | [ 'Accept'<br>, 'Accept-Charset'<br>, 'Accept-Encoding'<br>, 'Accept-Language'<br>]
[`expires :var`](#vary-var) | *Date* |
[`last_modified :var`](#last_modified-var) | *Date* | Now
[`etag :var`](#etag-var) | *ETag* |

> FIXME Explanations needed
