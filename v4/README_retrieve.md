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

![HTTP headers status](https://rawgithub.com/andreineculau/http-decision-diagram/master/v4/http-decision-diagram-v4.png)

## Retrieve

This block is in charge of retrieving the resource.

 | callback | output | default
:-- | ---: | :--- | :---
G8 | [`missing :bin`](#missing-bin) | T / F | FALSE
H6 | [`moved :bin`](#moved-bin) | T / F | FALSE
I6 | [`moved_permanently :bin`](#moved_permanently-bin) | T / F | FALSE
J6 | [`moved_temporarily :bin`](#moved_temporarily-bin) | T / F | FALSE
K6 | [`method :var`](#method-var) | *Method* | `Operation.method`
 | [`create_methods :var`](#create_methods-var) | [ *Method* ] | [ POST<br>]
 | [`is_method_create : in`](#is_method_create--in) | T / F |
 | [`moved_is_method_create : in`](#moved_is_method_create--in) | T / F | `is_method_create`

> FIXME Explanations needed
