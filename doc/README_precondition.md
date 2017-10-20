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

## Precondition

This block is in charge of precondition checks.

| | callback | output | default
|:-- | ---: | :--- | :---
|G9 | [`has_if_match : in`](#has_if_match--in) | T / F |
| | [`missing_has_precondition : in`](#missing_has_precondition--in) | T / F |
|C9 | [`has_if_match : in`](#has_if_match--in) | T / F |
|C10 | [`etag :var`](#etag-var) | *ETag* |
| | [`if_match_matches : in`](#if_match_matches--in) | T / F
|D10 | [`has_if_unmodified_since : in`](#has_if_unmodified_since--in) | T / F |
|D11 | [`last_modified :var`](#last_modified-var) | *Date* | Now
| | [`if_unmodified_since_matches : in`](#if_unmodified_since_matches--in) | T / F
|E11 | [`has_if_none_match : in`](#has_if_none_match--in) | T / F |
|E12 | [`etag :var`](#etag-var) | *ETag* |
| | [`if_none_match_matches : in`](#if_none_match_matches--in) | T / F
|F12 | [`has_if_modified_since : in`](#has_if_modified_since--in) | T / F |
|F13 | [`last_modified :var`](#last_modified-var) | *Date* | Now
| | [`if_modified_since_matches : in`](#if_modified_since_matches--in) | T / F
|F14 | [`method :var`](#method-var) | *Method* | `Transaction.request.method`
| | [`safe_methods :var`](#safe_methods-var) | [ *Method* ] | [ HEAD<br>, GET<br> OPTIONS<br>, TRACE<br>]
| | [`is_method_safe : in`](#is_method_safe--in) | T / F |
| | [`is_precondition_safe : in`](#is_precondition_safe--in) | T / F |

> FIXME Explanations needed
