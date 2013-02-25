# Overview

The decision diagram is split into standalone color-coded blocks

1. System (white)
1. Request (blue)
1. Accept (green)
1. Resource Exists (white)
1. Precondition (yellow)
1. Create/Update
    * Create (violet)
    * Update (red)
1. Response (cyan)
1. Error (black)
1. Final (white)

These blocks form a simple linear workflow, and each of these block follow their own decision flow with linear decisions, each with associated callbacks.



# Callback Types

Regardless of the type, each callback MUST

* refrain from doing more or less than what the decision block states
* have pertinent defaults

## Built-in callbacks `:in`
Some callbacks MUST be built-in by the system, and thus they are not explicitly marked on the diagram. They are not specific to the resource or the request and they are an implementation of HTTP-specific logic.

## Resource decision callbacks `:bin`
Resource logic is coded in these callbacks as an answer to binary questions - TRUE or FALSE. These callbacks have the power to end the decision flow early.

## Resource variable callbacks `:var`
Resource logic is coded in these callbacks as variable values. Each callback defines the type that it handles, and returning an unexpected type or value will yield _500 Internal Server Error_. These callbacks do NOT have the power to end the decision flow early.



# Blocks

## System

This block is in charge of "system"-level (request agnostic) checks:

### B15
* is `service_available :bin` ?

### B14
* `method_override :var`

    > output: method(string) or FALSE(bool)  
    > default: _X-HTTP-Method-Override_ if requested, or FALSE

* `method_in_known_methods :in` ?
    * `known_methods :var`

        > output: list of methods(array of strings)  
        > default: ['OPTIONS', 'HEAD', 'GET', 'POST', 'PATCH', 'PUT', 'DELETE', 'TRACE', 'CONNECT']

### B13
* is `uri_too_long :bin` ?
    > default: FALSE



## Request

This block is in charge of request-level checks:

1. is the request method allowed ?
1. is the request method OPTIONS ?
1. are the Content-* request headers known/accepted ?
1. is the representation size valid ?
1. is the representation acceptable ?
1. is the representation valid (syntax and semantics) ?
1. are the necessary auth-credentials fulfilled ?
1. is the operation (method, URI, headers, request representation) allowed ?
1. _anything else_ ?



## Accept

This block is in charge of acceptability checks:

1. can the resource provide an acceptable content-type ?
1. can the resource provide an acceptable language ?
1. can the resource provide an acceptable charset ?
1. can the resource provide an acceptable encoding ?
1. _anything else_ ?



## Precondition

This block is in charge of precondition checks:

1. does the representation ETag match ?
1. is the representation timestamp lower ?
1. does the representation ETag mismatch ?
1. is the representation timestamp higher ?
1. is precondition required ?
1. _anything else_ ?



## Create

FIXME



## Process

This block is in charge of processing the requested operation:

1. is the request method DELETE ? then process it
1. is the request method POST/PATCH ? then process it
1. is the request method PUT ? then process it



## Response

This block is in charge of creating the output:

1. is the request done ?
1. does the request generate a response representation ?
1. does the request generate multiple response representations ?



## Error

FIXME



## Final

FIXME



# Details of the diagram source

1. Software: OmniGraffle
1. File formats: Omnigraffle, PNG (maybe VDX once it's stable)
1. Size: A0 - 84.1 x 59.4 cm
1. Grid size: 0.5
1. Dot density: 96 dpi
