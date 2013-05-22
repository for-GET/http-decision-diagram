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

## Retrieve

This block is in charge of retrieving the resource.

 | callback | output | default
:-- | ---: | :--- | :---
G6 | [`exists :bin`](#exists-bin) | T / F | TRUE

> FIXME Explanations needed
