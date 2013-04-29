# Overview

The decision diagram is split into standalone color-coded blocks

1. [System](#system) (white)
1. [Request](#request) (blue)
1. [Accept](#accept) (green)
1. [Retrieve](#retrieve) (white)
1. [Precondition](#precondition) (yellow)
1. Create/Process
    * [Create](#create) (violet)
    * [Process](#process) (red)
1. [Response](#response) (cyan)
1. [Error](#error) (gray)


---

# Callback Types

**NOTE** All variables referenced below may have specific variances from the under_score notation - camelCase, PascalCase, etc.

The decision diagram makes use of different types of callbacks to get request or resource specific information. Regardless of the type though, each callback MUST

* have read-write access to 2 variables: `Operation` and `Context`
* refrain from doing more/less than what the decision block states
* have pertinent *defaults*

## Operation structure

`Operation` MUST be a key-value structure, initialized when receiving the request, with the following keys:

* `method` = Original HTTP method
* `uri` = Key-value of URI parts and their value. Keys outside [RFC3986](http://tools.ietf.org/html/rfc3986) can be defined inside this structure.
    * `source` = Full original URI e.g. 'http://user:pass@example.com:8080/p/a/t/h?query=string#fragment'
    * `scheme` = Lowercase scheme e.g. 'http'
    * `userinfo` = e.g. 'user:pass'
    * `host` = Lowercase host e.g. 'example.com'
    * `port` = e.g. '8080'
    * `authority` = Concatenated userinfo, lowercased host and port e.g. 'user:pass@example.com:8080'
    * `path` = e.g. '/p/a/t/h'
    * `query` = e.g. '?query=string'
    * `fragment` = e.g. '#fragment'
* `headers` = Key-value of lowercase header names and their values
    * `accept` =
    * `accept-language` =
    * `accept-charset` =
    * `accept-encoding` =
    * `content-type` =
    * `content-length` =
* `expect_extensions` = Extensions found in `Operation.headers.expect`
* `content_headers` = Content-* headers found in `Operation.headers`
* `representation` =
* `response` =
    * `chosen_content_type` =
    * `chosen_language` =
    * `chosen_charset` =
    * `chosen_encoding` =
    * `status_code` =
    * `headers` =
    * `representation` =

## Context structure

*Context* MUST be whatever the resource developer desires. It MUST be irrelevant to the decision flow. For the sake of clarity though, in this document you will find these references:

* `request_entity` =
* `entity` =

## Built-in callbacks `: in`
Some callbacks MUST be built-in by the system, and thus they are not explicitly marked on the diagram. They are not specific to the resource or the request and they are an implementation of HTTP-specific logic.

## Resource decision callbacks `:bin`
Resource logic is coded in these callbacks as an answer to binary questions - TRUE or FALSE. These callbacks have the power to end the decision flow early.

## Resource variable callbacks `:var`
Resource logic is coded in these callbacks as variable values. Each callback defines the type that it handles, and returning an unexpected type or value will yield _500 Internal Server Error_. These callbacks do NOT have the power to end the decision flow early.


---

# System

This block is in charge of "system"-level (request agnostic) checks.

 | callback | output | default
:-- | ---: | :--- | :---
H26 | [`start : in`](#start--in) | T / F | TRUE
B23 | [`is_service_available :bin`](#is_service_available-bin) | T / F | TRUE
B22 | [`is_uri_too_long :bin`](#is_uri_too_long-bin) | T / F | FALSE
B21 | [`method :var`](#method-var) | *Method* | `Operation.method`
 | [`implemented_methods :var`](#implemented_methods-var) | [ *Method* ] | [ OPTIONS<br>, HEAD<br>, GET<br>, POST<br>, PATCH<br>, PUT<br>, DELETE<br>, TRACE<br>]
 | [`is_method_implemented : in`](#is_method_implemented--in) | T / F |
B20 | [`implemented_content_headers :var`](#implemented_content_headers-var) | [ *HeaderName* ] | [ content-encoding<br>, content-language<br>, content-length<br>, content-md5<br>, content-type<br>]
 | [`are_content_headers_implemented : in`](#are_content_headers_implemented--in) | T / F |
B19 | [`is_functionality_implemented :bin`](#is_functionality_implemented-bin) | T / F | TRUE
B18 | [`implemented_expect_extensions :var`](#implemented_expect_extensions-var) | [ *ExtensionName* ] | []
 | [`are_expect_extensions_implemented : in`](#are_expect_extensions_implemented--in) | T / F |



## `start : in`

Prepare *Operation* for the request.

Return TRUE if succeeded; return FALSE otherwise.

## `is_service_available :bin`

Return TRUE if the resource is accepting requests; return FALSE otherwise.

Reference: [HTTPbis](http://tools.ietf.org/html/draft-ietf-httpbis-p2-semantics-22#section-6.6.4), [RFC2616](http://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html#sec10.5.4)

> The 503 (Service Unavailable) status code indicates that the server is currently unable to handle the request due to a temporary overload or scheduled maintenance, which will likely be alleviated after some delay.  The server MAY send a Retry-After header field (Section 7.1.3) to suggest an appropriate amount of time for the client to wait before retrying the request.

> > Note: The existence of the 503 status code does not imply that a server has to use it when becoming overloaded.  Some servers might simply refuse the connection.

## `is_uri_too_long :bin`

Return TRUE if the URI is too long; return FALSE otherwise.

Reference: [HTTPbis](http://tools.ietf.org/html/draft-ietf-httpbis-p2-semantics-22#section-6.5.12), [RFC2616](http://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html#sec10.4.15)

> The 414 (URI Too Long) status code indicates that the server is refusing to service the request because the request-target (Section 5.3 of [Part1]) is longer than the server is willing to interpret. This rare condition is only likely to occur when a client has improperly converted a POST request to a GET request with long query information, when the client has descended into a "black hole" of redirection (e.g., a redirected URI prefix that points to a suffix of itself), or when the server is under attack by a client attempting to exploit potential security holes.

> A 414 response is cacheable unless otherwise indicated by the method definition or explicit cache controls (see Section 4.1.2 of [Part6]).

## `method :var`

If you allow the HTTP method to be overridden (e.g. via the _X-HTTP-Method-Override_ header) then return the intended method; return `Operation.method` otherwise.

Reference: [Google Data APIs](https://developers.google.com/gdata/docs/2.0/basics#DeletingEntry)

> If your firewall does not allow DELETE, then do an HTTP POST and set the method override header as follows: `X-HTTP-Method-Override: DELETE`.

## `implemented_methods :var`

Return a list of HTTP methods that are implemented by the system.

## `is_method_implemented : in`

Return TRUE if `Operation.method` is in `implemented_methods :var`; return FALSE otherwise.

## `implemented_content_headers :var`

Return a list of Content-* headers that are implemented by the system.

## `are_content_headers_implemented : in`

Return TRUE if `Operation.content_headers` is a subset of `implemented_content_headers :var`; return FALSE otherwise

## `is_functionality_implemented :bin`

Return TRUE if the requested functionality (other than methods and content headers) is implemented; return FALSE otherwise.

Reference: [HTTPbis](http://tools.ietf.org/html/draft-ietf-httpbis-p2-semantics-22#section-6.6.2), [RFC2616](http://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html#sec10.5.2)

> The 501 (Not Implemented) status code indicates that the server does not support the functionality required to fulfill the request.  This is the appropriate response when the server does not recognize the request method and is not capable of supporting it for any resource.

> A 501 response is cacheable unless otherwise indicated by the method definition or explicit cache controls (see Section 4.1.2 of [Part6]).

## `implemented_expect_extensions :var`

Return a list of Expect extensions that are implemented by the system.

## `are_expect_extensions_implemented : in`

Return True if extensions in `Operation.expect_extensions` is a subset of `implemented_expect_extensions :var`

Reference: [HTTPbis](http://tools.ietf.org/html/draft-ietf-httpbis-p2-semantics-22#section-6.5.14), [RFC2616](http://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html#sec10.4.18)

> The 417 (Expectation Failed) status code indicates that the expectation given in the request's Expect header field (Section 5.1.1) could not be met by at least one of the inbound servers.



---

## Request

This block is in charge of request-level checks.

 | callback | output | default
:-- | ---: | :--- | :---
B11 | [`allowed_methods :var`](#allowed_methods-var) | [ *Method* ] | [ OPTIONS<br>, HEAD<br>, GET<br>, POST<br>, PATCH<br>, PUT<br>, DELETE<br>, TRACE<br>]
 | [`is_method_allowed : in`](#is_method_allowed--in) | T / F |
B10 | [`is_authorized :bin`](#is_authorized-bin) | T / F | TRUE
 | [`auth_challenges :var`](#auth_challenges-var) | [ *AuthChallenge* ] | [ ]
B9 | [`method :var`](#method-var) | *Method* | `Operation.method`
 | [`is_method_trace : in`](#is_method_trace--in) | T / F |
 | [`trace_sensitive_headers :var`](#trace_sensitive_headers-var) | [ *HeaderName* ] | [ Authentication<br>, Cookies<br>]
 | [`process_trace : in`](#process_trace--in) | |
B8 | [`method :var`](#method-var) | *Method* | `Operation.method`
 | [`is_method_options : in`](#is_method_options--in) | T / F |
 | [`options_headers :var`](#options_headers-var) | { *Header*<br>: *Value* } | { Allow<br>: `allowed_methods :var`<br>, Accept-Patch<br>: `patch_content_types_accepted :var`}
 | [`process_options : in`](#process_options--in) | |
B7 | [`payload_exists : in`](#payload_exists--in) | T / F |
B6 | [`is_payload_too_large :bin`](#is_payload_too_large-bin) | T / F | TRUE
B5 | [`post_content_types_accepted :var`](#content_types_accepted-var) | { *CT*<br>: *Handler* } | { }
 | [`patch_content_types_accepted :var`](#content_types_accepted-var) | { *CT*<br>: *Handler* } | { }
 | [`put_content_types_accepted :var`](#content_types_accepted-var) | { *CT*<br>: *Handler* } | { }
 | [`content_types_accepted :var`](#content_types_accepted-var) | { *CT*<br>: *Handler* } | { }
 | [`is_content_type_accepted : in`](#is_content_type_accepted--in) | T / F |
B4 | [`content_types_accepted:handler :bin`](#content_types_accepted-handler-bin) | T / F |
B3 | [`is_forbidden :bin`](#is_forbidden-bin) | T / F | FALSE
B2 | [`is_request_ok :bin`](#is_request_ok-bin) | T / F | TRUE


## `allowed_methods :var`

Return a list of allowed methods for this resource.

## `is_method_allowed : in`

Return TRUE if `Operation.method` in `allowed_methods :var`; return FALSE otherwise.

Reference: [HTTPbis](http://tools.ietf.org/html/draft-ietf-httpbis-p2-semantics-22#section-6.5.5), [RFC2616](http://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html#sec10.4.6)

> The 405 (Method Not Allowed) status code indicates that the method specified in the request-line is known by the origin server but not supported by the target resource.  The origin server MUST generate an Allow header field in a 405 response containing a list of the target resource's currently supported methods.

> A 405 response is cacheable unless otherwise indicated by the method definition or explicit cache controls (see Section 4.1.2 of [Part6]).

## `is_authorized :bin`

Return TRUE if this request has valid authentication credentials; return FALSE otherwise.

Reference: [HTTPbis](http://tools.ietf.org/html/draft-ietf-httpbis-p7-auth-22#section-3.1), [RFC2616](http://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html#sec10.4.2)

> The 401 (Unauthorized) status code indicates that the request has not been applied because it lacks valid authentication credentials for the target resource.  The origin server MUST send a WWW-Authenticate header field (Section 4.4) containing at least one challenge applicable to the target resource.  If the request included authentication credentials, then the 401 response indicates that authorization has been refused for those credentials.  The client MAY repeat the request with a new or replaced Authorization header field (Section 4.1).  If the 401 response contains the same challenge as the prior response, and the user agent has already attempted authentication at least once, then the user agent SHOULD present the enclosed representation to the user, since it usually contains relevant diagnostic information.

## `auth_challenges :var`

If `is_authorized :bin` returned FALSE, then you must return a list of at least one challenge to be used as the _WWW-Authenticate_ response header.

## `is_method_trace : in`

Return TRUE if the `method :var` is TRACE; FALSE otherwise.

## `trace_sensitive_headers :var`

Return a list of headers that should be treated as sensitive, and thus hidden from the TRACE response.

## `process_trace : in`

Set `Operation.response.headers.content-type` to `message/http` and `Operation.response.body` to `Operation.headers` (except `trace_sensitive_headers :var`).

Return TRUE if succeeded; return FALSE otherwise.

Reference: [HTTPbis](http://tools.ietf.org/html/draft-ietf-httpbis-p2-semantics-22#section-4.3.8), [RFC2616](http://www.w3.org/Protocols/rfc2616/rfc2616-sec9.html#sec9.8)

> The TRACE method requests a remote, application-level loop-back of the request message.  The final recipient of the request SHOULD reflect the message received, excluding some fields described below, back to the client as the message body of a 200 (OK) response with a Content-Type of "message/http" (Section 7.3.1 of [Part1]).  The final recipient is either the origin server or the first server to receive a Max-Forwards value of zero (0) in the request (Section 5.1.2).

> A client MUST NOT send header fields in a TRACE request containing sensitive data that might be disclosed by the response.  For example, it would be foolish for a user agent to send stored user credentials [Part7] or cookies [RFC6265] in a TRACE request.  The final recipient SHOULD exclude any request header fields from the response body that are likely to contain sensitive data.

> TRACE allows the client to see what is being received at the other end of the request chain and use that data for testing or diagnostic information.  The value of the Via header field (Section 5.7.1 of [Part1]) is of particular interest, since it acts as a trace of the request chain.  Use of the Max-Forwards header field allows the client to limit the length of the request chain, which is useful for testing a chain of proxies forwarding messages in an infinite loop.

> A client MUST NOT send a message body in a TRACE request.

> Responses to the TRACE method are not cacheable.

## `is_method_options :in`

Return TRUE if the `method :var` is OPTIONS; FALSE otherwise.

## `options :var`

Return a key-value headers and their values.

By default _Allow_ will point to `allowed_methods :var` and _Accept-Patch_ to `patch_content_types_accepted :var`.

## `process_options : in`

Set `options :var` as `Operation.response.headers`.

Return TRUE if succeeded; return FALSE otherwise.

Reference: [HTTPbis](http://tools.ietf.org/html/draft-ietf-httpbis-p2-semantics-22#section-4.3.7), [RFC2616](http://www.w3.org/Protocols/rfc2616/rfc2616-sec9.html#sec9.2)

> The OPTIONS method requests information about the communication options available on the request/response chain identified by the effective request URI.  This method allows a client to determine the options and/or requirements associated with a resource, or the capabilities of a server, without implying a resource action.

> [...]

> A server generating a successful response to OPTIONS SHOULD send any header fields that might indicate optional features implemented by the server and applicable to the target resource (e.g., Allow), including potential extensions not defined by this specification.  The response payload, if any, might also describe the communication options in a machine or human-readable representation.  A standard format for such a representation is not defined by this specification, but might be defined by future extensions to HTTP.  A server MUST generate a Content-Length field with a value of "0" if no payload body is to be sent in the response.

> [...]
-->

## `payload_exists : in`

Return TRUE if the request has a payload (`Operation.headers.content-length` greater than 0); return FALSE otherwise.

## `is_payload_too_large :bin`

Return TRUE if the request payload is too large; return FALSE otherwise.

Reference: [HTTPbis](http://tools.ietf.org/html/draft-ietf-httpbis-p2-semantics-22#section-6.5.11), [RFC2616](http://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html#sec10.4.14)

> The 413 (Payload Too Large) status code indicates that the server is refusing to process a request because the request payload is larger than the server is willing or able to process.  The server MAY close the connection to prevent the client from continuing the request.

> If the condition is temporary, the server SHOULD generate a Retry-After header field to indicate that it is temporary and after what time the client MAY try again.

## `post_content_types_accepted :var`

Return a list of key-value POST content-types and their handlers (i.e. deserializers to `Context.request_entity`).

By default, handle `application/x-www-form-urlencoded`.

## `patch_content_types_accepted :var`

Return a list of key-value PATCH content-types and their handlers (i.e. deserializers to `Context.request_entity`).

## `put_content_types_accepted :var`

Return a list of key-value PUT content-types and their handlers (i.e. deserializers to `Context.request_entity`).

## `content_types_accepted :var`

Return a list of key-value content-types and their handlers (i.e. deserializers to `Context.request_entity`).

By default it will call the callback specific to the request method.

## `is_content_type_accepted :in`

Return TRUE if `Operation.headers.content-type` matches keys of `content_types_accepted :var`; return FALSE otherwise.

The matching must follow specific rules. FIXME

Reference: [HTTPbis](http://tools.ietf.org/html/draft-ietf-httpbis-p2-semantics-22#section-6.5.13), [RFC2616](http://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html#sec10.4.16)

> The 415 (Unsupported Media Type) status code indicates that the origin server is refusing to service the request because the payload is in a format not supported by the target resource for this method.  The format problem might be due to the request's indicated Content-Type or Content-Encoding, or as a result of inspecting the data directly.

## `content_types_accepted:handler :bin`

Deserialize `Operation.representation` into `Context.request_entity`.

Return TRUE if succeeded; return FALSE otherwise.

## `is_forbidden :bin`

Return TRUE if the semantics of the request (e.g. `Operation.method`, `Context.request_entity`) trigger a forbidden operation; return FALSE otherwise.

Reference: [HTTPbis](http://tools.ietf.org/html/draft-ietf-httpbis-p2-semantics-22#section-6.5.3), [RFC2616](http://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html#sec10.4.4)

> The 403 (Forbidden) status code indicates that the server understood the request but refuses to authorize it.  A server that wishes to make public why the request has been forbidden can describe that reason in the response payload (if any).

> If authentication credentials were provided in the request, the server considers them insufficient to grant access.  The client SHOULD NOT repeat the request with the same credentials.  The client MAY repeat the request with new or different credentials.  However, a request might be forbidden for reasons unrelated to the credentials.

> An origin server that wishes to "hide" the current existence of a forbidden target resource MAY instead respond with a status code of 404 (Not Found).

## `is_request_ok :bin`

If you want to validate the request beyond the implemented decisions, this is the place to do it.

Return TRUE if the request looks ok; return FALSE otherwise.


---

# Accept

This block is in charge of request payload acceptance checks.

 | callback | output | default
:-- | ---: | :--- | :---
C1 | [`accept_filter : in`](#accept_filter--in) | T / F |
 | [`default_content_type_provided :var`](#default_content_type_provided-var) | [ *CT*<br>, *Handler*<br>] |
C2 | [`content_types_provided :var`](#content_types_provided-var) | { *CT*<br>: *Handler*<br>}\* | { }
 | [`accept_matches : in`](#accept_matches--in) | T / F |
D2 | [`accept_language_filter : in`](#accept_language_filter--in) | T / F |
D3 | [`languages_provided :var`](#languages_provided-var) | { *Lang*<br>: *Handler*<br>}\* | { }
 | [`accept_language_matches : in`](#accept_language_matches--in) | T / F |
E3 | [`accept_charset_filter : in`](#accept_charset_filter--in) | T / F |
E4 | [`charsets_provided :var`](#charsets_provided-var) | { *Charset*<br>: *Handler*<br>}\* | { }
 | [`accept_charset_matches : in`](#accept_charset_matches--in) | T / F |
F4 | [`accept_encoding_filter : in`](#accept_encoding_filter--in) | T / F |
F5 | [`encodings_provided :var`](#encodings_provided-var) | { *Encoding*<br>: *Handler*<br>}\* | { }
 | [`accept_encoding_matches : in`](#accept_encoding_matches--in) | T / F |
E6 | [`is_accept_ok :bin`](#is_accept_ok-bin) | T / F | TRUE


---

# Retrieve

This block is in charge of retrieving the resource.

 | callback | output | default
:-- | ---: | :--- | :---
G6 | [`exists :bin`](#exists-bin) | T / F | TRUE



---

# Precondition

This block is in charge of precondition checks.

 | callback | output | default
:-- | ---: | :--- | :---
C9 | [`if_match_filter : in`](#if_match_filter--in) | T / F |
C10 | [`etag :var`](#etag-var) | *ETag* | ''
 | [`if_match_matches : in`](#if_match_matches--in) | T / F
D10 | [`if_unmodified_since_filter : in`](#if_unmodified_since_filter--in) | T / F |
D11 | [`last_modified :var`](#last_modified-var) | *Date* | Now
 | [`if_unmodified_since_matches : in`](#if_umodified_since_matches--in) | T / F
E11 | [`if_none_match_filter : in`](#if_none_match_filter--in) | T / F |
E12 | [`etag :var`](#etag-var) | *ETag* | ''
 | [`if_none_match_matches : in`](#if_none_match_matches--in) | T / F
F12 | [`if_modified_since_filter : in`](#if_modified_since_filter--in) | T / F |
F13 | [`last_modified :var`](#last_modified-var) | *Date* | Now
 | [`if_modified_since_matches : in`](#if_modified_since_matches--in) | T / F
F15 | [`method :var`](#method-var) | *Method* | `Operation.method`
 | [`is_method_get_head : in`](#is_method_get_head--in) | T / F |
G13 | [`is_precondition_ok :bin`](#is_precondition_ok-bin) | T / F | TRUE
I6 | [`if_match_filter : in`](#if_match_filter--in) | T / F |


---

# Retrieve

FIXME


---

# Create

FIXME


---

# Process

This block is in charge of processing the requested operation:

1. is the request method DELETE ? then process it
1. is the request method POST/PATCH ? then process it
1. is the request method PUT ? then process it


---

# Response

This block is in charge of creating the output:

1. is the request done ?
1. does the request generate a response representation ?
1. does the request generate multiple response representations ?


---

# Error

FIXME

