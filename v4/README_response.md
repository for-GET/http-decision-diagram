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

![HTTP headers status](https://rawgithub.com/andreineculau/http-decision-diagram/master/v4/httpdd.png)

## Response

 | callback | output | default
:-- | ---: | :--- | :---
N3 | [`is_create_done :bin`](#is_create_done-bin) | T / F | `is_process_done :bin`
N6 | [`create_see_other :bin`](#create_see_other-bin) | T / F | `see_other :bin`
 | [`content_types_provided:handler :bin`](#content_types_provided-handler-var) | T / F |
 | [`to_content : in`](#to_content--in) | T / F | FALSE
 - | [`vary :var`](#vary-var) | [ *String* ] |
 - | [`expires :var`](#vary-var) | *Date* |
 - | [`last_modified :var`](#last_modified-var) | *Date* | Now
 - | [`etag :var`](#etag-var) | *ETag* |
N14 | [`is_process_done :bin`](#is_process_done-bin) | T / F | TRUE
N10 | [`see_other :bin`](#see_other-bin) | T / F | FALSE
 | [`path :var`](#path-var) | *URI* |
N9 | [`has_multiple_choices :bin`](#has_multiple_choices-bin) | T / F | FALSE
N8 | [`content_types_provided:handler :bin`](#content_types_provided-handler-var) | T / F |
 | [`to_content : in`](#to_content--in) | T / F | FALSE
- | [`cache :var`](#cache-var) | *String* |
- | [`vary :var`](#vary-var) | [ *String* ] |
- | [`expires :var`](#vary-var) | *Date* |
- | [`last_modified :var`](#last_modified-var) | *Date* | Now
- | [`etag :var`](#etag-var) | *ETag* |

> FIXME Explanations needed
