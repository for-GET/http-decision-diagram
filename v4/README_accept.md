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

![HTTP headers status](http-headers-status-v4.png)

## Accept

This block is in charge of request payload acceptance checks.

 | callback | output | default
:-- | ---: | :--- | :---
C1 | [`default_content_type_provided :var`](#default_content_type_provided-var) | [ *CT*<br>, *Handler*<br>] |
 | [`accept_filter : in`](#accept_filter--in) | T / F |
C2 | [`content_types_provided :var`](#content_types_provided-var) | { *CT*<br>: *Handler*<br>}\* | { }
 | [`accept_matches : in`](#accept_matches--in) | T / F |
D2 | [`default_language_provided :var`](#default_language_provided-var) | [ *Lang*<br>, *Handler*<br>] |
 | [`accept_language_filter : in`](#accept_language_filter--in) | T / F |
D3 | [`languages_provided :var`](#languages_provided-var) | { *Lang*<br>: *Handler*<br>}\* | { }
 | [`accept_language_matches : in`](#accept_language_matches--in) | T / F |
E3 | [`default_charset_provided :var`](#default_charset_provided-var) | [ *Charset*<br>, *Handler*<br>] |
 | [`accept_charset_filter : in`](#accept_charset_filter--in) | T / F |
E4 | [`charsets_provided :var`](#charsets_provided-var) | { *Charset*<br>: *Handler*<br>}\* | { }
 | [`accept_charset_matches : in`](#accept_charset_matches--in) | T / F |
F4 | [`default_encoding_provided :var`](#default_encoding_provided-var) | [ *Encoding*<br>, *Handler*<br>] | [ IDENTITY, IDENTITY_HANDLER ]
 | [`accept_encoding_filter : in`](#accept_encoding_filter--in) | T / F |
F5 | [`encodings_provided :var`](#encodings_provided-var) | { *Encoding*<br>: *Handler*<br>}\* | { }
 | [`accept_encoding_matches : in`](#accept_encoding_matches--in) | T / F |
E6 | [`is_accept_ok :bin`](#is_accept_ok-bin) | T / F | TRUE
