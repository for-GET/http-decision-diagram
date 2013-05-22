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

![HTTP headers status](https://rawgithub.com/andreineculau/http-decision-diagram/master/v4/http-decision-diagram-v4.png)

## Process

 | callback | output | default
:-- | ---: | :--- | :---
I10 | [`method :var`](#method-var) | *Method* | `Operation.method`
 | [`is_method_delete : in`](#is_method_delete--in) | T / F |
J10 | [`process_delete :bin`](#process_delete-bin) | T / F | FALSE
I12 | [`method :var`](#method-var) | *Method* | `Operation.method`
 | [`is_method_put : in`](#is_method_put--in) | T / F |
K12 | [`process_put :bin`](#process_put-bin) | T / F | FALSE
I14 | [`method :var`](#method-var) | *Method* | `Operation.method`
 | [`process_methods :var`](#process_methods-var) | [ *Method* ] | [ POST<br>, PATCH<br>]
 | [`is_method_process : in`](#is_method_process--in) | T / F |
J14 | [`process :bin`](#process-bin) | T / F | FALSE
K14 | [`is_location_set : in`](#is_location_set--in) | T / F |

> FIXME Explanations needed
