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

## Process

| | callback | output | default
|:-- | ---: | :--- | :---
|J10 | [`method :var`](#method-var) | *Method* | `Transaction.request.method`
| | [`is_method_head_get : in`](#is_method_head_get--in) | T / F |
|J11 | [`method :var`](#method-var) | *Method* | `Transaction.request.method`
| | [`is_method_delete : in`](#is_method_delete--in) | T / F |
|K11 | [`process_delete :bin`](#process_delete-bin) | T / F | FALSE
|J13 | [`method :var`](#method-var) | *Method* | `Transaction.request.method`
| | [`is_method_put : in`](#is_method_put--in) | T / F |
|K13 | [`process_partial_put :bin`](#process_partial_put-var) | T / F | FALSE
|K14 | [`process_has_conflict :bin`](#process_has_conflict-bin) | T / F | FALSE
|J14 | [`method :var`](#method-var) | *Method* | `Transaction.request.method`
| | [`process_methods :var`](#process_methods-var) | [ *Method* ] | [ POST<br>, PATCH<br>]
| | [`is_method_process : in`](#is_method_process--in) | T / F |
|L14 | [`process :bin`](#process-bin) | T / F | FALSE

> FIXME Explanations needed

### `process_partial_put :bin`

Return TRUE if the request doesn't have a "full" representation of the resource, where "full" is defined by each resource.

By default, this callback could check for the presence of a _Content-Range_ request header, but that header is not "implemented" by this diagram, so the default for now is to return FALSE.

Reference: [RFC7231](http://tools.ietf.org/html/rfc7231#section-4.3.4)
