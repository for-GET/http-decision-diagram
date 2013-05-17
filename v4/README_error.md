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
O19 | [`is_error_response : in`](#is_error_response--in) | T / F |
O20 | [`default_content_type_provided :var`](#default_content_type_provided-var) | [ *CT*<br>, *Handler*<br>] |
 | [`accept_filter : in`](#accept_filter--in) | T / F |
O21 | [`error_content_types_provided :var`](#error_content_types_provided-var) | { *CT*<br>: *Handler*<br>}\* | { }
 | [`error_accept_matches : in`](#error_accept_matches--in) | T / F |
O22 | [`error_content_types_provded:handler :bin`](#error_content_types_provided-handler-var) | T / F |

> FIXME Explanations needed
