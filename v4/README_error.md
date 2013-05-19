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

## Error

 | callback | output | default
:-- | ---: | :--- | :---
N22 | [`error_content_types_provided :var`](#error_content_types_provided-var) | { *CT*<br>: *Handler*<br>}\* | { }
 | [`error_default_content_type_provided :var`](#error_default_content_type_provided-var) | [ *CT*<br>, *Handler*<br>] |
 | [`error_has_accept : in`](#error_has_accept--in) | T / F |
N23 | [`error_content_types_provided :var`](#error_content_types_provided-var) | { *CT*<br>: *Handler*<br>}\* | { }
 | [`error_accept_matches : in`](#error_accept_matches--in) | T / F |
N24 | [`error_content_types_provided:handler :bin`](#error_content_types_provided-handler-var) | T / F |
 | [`error_to_content : in`](#error_to_content--in) | T / F | FALSE

> FIXME Explanations needed
