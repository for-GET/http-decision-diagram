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

## Precondition

This block is in charge of precondition checks.

 | callback | output | default
:-- | ---: | :--- | :---
C9 | [`if_match_filter : in`](#if_match_filter--in) | T / F |
C10 | [`etag :var`](#etag-var) | *ETag* |
 | [`if_match_matches : in`](#if_match_matches--in) | T / F
D10 | [`if_unmodified_since_filter : in`](#if_unmodified_since_filter--in) | T / F |
D11 | [`last_modified :var`](#last_modified-var) | *Date* | Now
 | [`if_unmodified_since_matches : in`](#if_umodified_since_matches--in) | T / F
E11 | [`if_none_match_filter : in`](#if_none_match_filter--in) | T / F |
E12 | [`etag :var`](#etag-var) | *ETag* |
 | [`if_none_match_matches : in`](#if_none_match_matches--in) | T / F
F12 | [`if_modified_since_filter : in`](#if_modified_since_filter--in) | T / F |
F13 | [`last_modified :var`](#last_modified-var) | *Date* | Now
 | [`if_modified_since_matches : in`](#if_modified_since_matches--in) | T / F
F15 | [`method :var`](#method-var) | *Method* | `Operation.method`
 | [`is_method_get_head : in`](#is_method_get_head--in) | T / F |
G13 | [`is_precondition_ok :bin`](#is_precondition_ok-bin) | T / F | TRUE
H7 | [`if_match_filter : in`](#if_match_filter--in) | T / F |
