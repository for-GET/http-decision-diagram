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

![HTTP headers status](https://rawgithub.com/andreineculau/http-decision-diagram/master/v4/http-decision-diagram-v4.png)

## alternative

 | callback | output | default
:-- | ---: | :--- | :---
 | [`trace_content_types_provided : in`](#trace_content_types_provided--in) | { *CT*<br>: *Handler*<br>}\* | { }
 | [`default_trace_content_type_provided : in`](#default_trace_content_type_provided--in) | [ *CT*<br>, *Handler*<br>] |
 | [`choice_content_types_provided :var`](#choice_content_types_provided-var) | { *CT*<br>: *Handler*<br>}\* | { }
 | [`default_choice_content_type_provided :var`](#default_choice_content_type_provided-var) | [ *CT*<br>, *Handler*<br>] |
 | [`error_content_types_provided :var`](#error_content_types_provided-var) | { *CT*<br>: *Handler*<br>}\* | { }
 | [`default_error_content_type_provided :var`](#default_error_content_type_provided-var) | [ *CT*<br>, *Handler*<br>] |
 | [`options_content_types_provided :var`](#trace_content_types_provided-var) | { *CT*<br>: *Handler*<br>}\* | { }
 | [`default_options_content_type_provided :var`](#default_trace_content_type_provided-var) | [ *CT*<br>, *Handler*<br>] |
 | [`alternative_type : in`](#alternative_type--in) | String |
 | [`is_alternative_response : in`](#is_alternative_response--in) | T / F |
N22 | [`alternative_type : in`](#alternative_type--in) | String |
 | [`default_alternative_content_type_provided :var`](#default_alternative_content_type_provided-var) | [ *CT*<br>, *Handler*<br>] |
 | [`alternative_has_accept : in`](#alternative_has_accept--in) | T / F |
N23 | [`alternative_type : in`](#alternative_type--in) | String |
 | [`alternative_content_types_provided :var`](#alternative_content_types_provided-var) | { *CT*<br>: *Handler*<br>}\* | { }
 | [`alternative_accept_matches : in`](#alternative_accept_matches--in) | T / F |
N24 | [`alternative_content_types_provided:handler :bin`](#alternative_content_types_provided-handler-var) | T / F |
 | [`alternative_to_content : in`](#alternative_to_content--in) | T / F | FALSE

> FIXME Explanations needed
