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

## Retrieve

This block is in charge of retrieving the resource.

| | callback | output | default
|:-- | ---: | :--- | :---
|G6 | [`missing :bin`](#missing-bin) | T / F | FALSE
|H7 | [`moved :bin`](#moved-bin) | T / F | FALSE
|H6 | [`moved_permanently :bin`](#moved_permanently-bin) | T / F | FALSE
|H5 | [`moved_temporarily :bin`](#moved_temporarily-bin) | T / F | FALSE
|H4 | [`method :var`](#method-var) | *Method* | `Transaction.request.method`
| | [`create_methods :var`](#create_methods-var) | [ *Method* ] | [ POST<br>]
| | [`is_method_create : in`](#is_method_create--in) | T / F |
| | [`gone_permanently :bin`](#gone_permanently-bin) | T / F | FALSE

> FIXME Explanations needed

### `missing :bin`

Return TRUE if the entire resource or the specific requested representation is missing; return FALSE otherwise.

The return value is in the spirit of the `404 NOT FOUND` status code.

Reference: [HTTPbis](http://tools.ietf.org/html/draft-ietf-httpbis-p2-semantics#section-6.5.4), [RFC2616](http://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html#sec10)

> The 404 (Not Found) status code indicates that the origin server did not find a current representation for the target resource or is not willing to disclose that one exists.
