# Overview

The decision diagram is split into standalone blocks

* System
* Request
* Accept
* Create
* Precondition
* Update
* Response

These blocks form a simple workflow, and each of these block follow their own decision flow with sequencial decisions (each with associated callbacks).



## System

This block is in charge of system-level checks:

* is the service available ?
* is the service aware of the request method ?
* is the service able to process the URI ?



## Request

This block is in charge of request-level checks:

* is the request method allowed ?
* is the request method OPTIONS ?
* are the Content-* request headers known/accepted ?
* is the representation size valid ?
* is the representation acceptable ?
* is the representation valid (syntax and semantics) ?
* are the necessary auth-credentials fulfilled ?
* is the operation (method, URI, headers, request representation) allowed ?
* _anything else_ ?



## Accept

This block is in charge of acceptability checks:

* can the resource provide an acceptable content-type ?
* can the resource provide an acceptable language ?
* can the resource provide an acceptable charset ?
* can the resource provide an acceptable encoding ?
* _anything else_ ?


## Create

FIXME



## Precondition

This block is in charge of precondition checks:

* does the representation ETag match ?
* is the representation timestamp lower ?
* does the representation ETag mismatch ?
* is the representation timestamp higher ?
* is precondition required ?
* _anything else_ ?



## Process

This block is in charge of processing the requested operation:

* is the request method DELETE ? then process it
* is the request method POST/PATCH ? then process it
* is the request method PUT ? then process it



## Response

This block is in charge of creating the output:

* is the request done ?
* does the request generate a response representation ?
* does the request generate multiple response representations ?



# Details of the diagram source

* Software: OmniGraffle
* File formats: Omnigraffle, PNG (maybe VDX once it's stable)
* Size: A0 - 84.1 x 59.4 cm
* Grid size: 0.5
* Dot density: 96 dpi
