# Diagram changes

These changes do not target specifically the webmachine flow, but more the decisions in the decision diagram and their associated callbacks.


## System callbacks

None



## Request callbacks

* `malformed_request` has been forwarded to `content_types_accepted:handler`
* `known_content_type` has been automated via `content_types_accepted`

### Change of order

```
v3                    v4
--                    --
allowed_methods       allowed_methods
malformed_request*    options
is_authorized         valid_content_headers
is_forbidden          valid_entity_length
valid_content_headers content_types_accepted
known_content_type*   content_types_accepted:handler
valid_entity_length   is_authorized
options               is_forbidden
```

### `is_request_ok` generic catch all

If you need to check for something more at the request-level, then this is the place.



## Accept callbacks

No major changes, just a simplified diagram.


### `is_accept_ok` generic catch all

If you need to change a negative accept resolution, then this is the place. The server is not forced to obey Accept request headers.



## Precondition callbacks

No major changes, just a simplified diagram.

### `precondition_required`

In order to avoid "lost update" problem, you may require a conditional request.

### `is_precondition_ok` generic catch all

If you need to change the precondition resolution, then this is the place.



## Create callbacks

FIXME


## Update callbacks

Major changes, beyond a simplified diagram. This block is now standalone, rather than tightly coupled with the Create and Response block (v3).

* leave success status codes for the Response block to decide
* DELETE simply calls `delete_resource` which acts as `process_delete`
* allow PATCH as POST
* POST/PATCH simply calls `process_post`
* PUT simply calls `is_conflict` which acts as `process_put`

### Renamings

* TBD `delete_resource` to `process_delete`
* TBD `is_conflict` to `process_put`



## Response callbacks

Major changes, beyond a simplified diagram. This block is now in charge of all successful output, decoupled from the Update block (v3).

* all responses, regardless of the flow, go through the same response checks
* check if the operation is (be treated as) async (`request_done`)
* check if the operation generated a response representation
* check if the operation generate more than 1 response representation
