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
K1 | [`method :var`](#method-var) | *Method* | `Operation.method`
 | [`is_method_put : in`](#is_method_put--in) | T / F |
K2 | [`previously_existed :bin`](#previously_existed-bin) | T / F | FALSE
K4 | [`method :var`](#method-var) | *Method* | `Operation.method`
 | [`create_methods :var`](#create_methods-var) | [ *Method* ] | [ POST<br>]
 | [`is_method_for_creation : in`](#is_method_for_creation--in) | T / F |
L1 | [`moved_permanently :bin`](#moved_permanently-bin) | T / F | FALSE
L2 | [`moved_permanently :bin`](#moved_permanently-bin) | T / F | FALSE
L3 | [`moved_temporarily :bin`](#moved_temporarily-bin) | T / F | FALSE
L4 | [`method :var`](#method-var) | *Method* | `Operation.method`
 | [`create_methods :var`](#create_methods-var) | [ *Method* ] | [ POST<br>]
 | [`is_method_for_creation : in`](#is_method_for_creation--in) | T / F |
L5 | [`path :var`](#path-var) | *String* |
 | [`create_path : in`](#create_path--in) | T / F |
L6 | [`create :bin`](#create-bin) | T / F | FALSE
O6 | [`create_put :bin`](#create_put-bin) | T / F | `process_put`
N8 | [`is_location_set : in`](#is_location_set--in) | T / F |
