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

## Create

 | callback | output | default
:-- | ---: | :--- | :---
J2 | [`existed :bin`](#existed-bin) | T / F | FALSE
K2 | [`moved_permanently :bin`](#moved_permanently-bin) | T / F | FALSE
K3 | [`moved_temporarily :bin`](#moved_temporarily-bin) | T / F | FALSE
K4 | [`method :var`](#method-var) | *Method* | `Operation.method`
 | [`create_methods :var`](#create_methods-var) | [ *Method* ] | [ POST<br>]
 | [`is_method_create : in`](#is_method_create--in) | T / F |
 | [`existed_is_method_create : in`](#existed_is_method_create--in) | T / F | `is_method_create`
J5 | [`method :var`](#method-var) | *Method* | `Operation.method`
 | [`create_methods :var`](#create_methods-var) | [ *Method* ] | [ POST<br>, PUT<br>]
 | [`is_method_create : in`](#is_method_create--in) | T / F |
K5 | [`method :var`](#method-var) | *Method* | `Operation.method`
 | [`is_method_put : in`](#is_method_put--in) | T / F |
 | [`create_is_method_put : in`](#create_is_method_put--in) | T / F | `is_method_put : in`
N5 | [`create_put :bin`](#create_put-bin) | T / F | `process_put`
K6 | [`path :var`](#path-var) | *String* |
 | [`create_path : in`](#create_path--in) | T / F |
M6 | [`create :bin`](#create-bin) | T / F | FALSE
N6 | [`is_location_set : in`](#is_location_set--in) | T / F |
 | [`create_is_location_set : in`](#create_is_location_set--in) | T / F | `is_location_set : in`

> FIXME Explanations needed
