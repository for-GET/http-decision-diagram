-module(template).

-export([ init/1
        %% Webmachine Basic Callbacks ------------------------------------------
        , ping/2
        , service_available/2
        , known_methods/2
        , uri_too_long/2
        , allowed_methods/2
        , malformed_request/2
        , is_authorized/2
        , forbidden/2
        , valid_content_headers/2
        , known_media_type/2
        , valid_entity_length/2
        , options/2
        %% Webmachine Accept Callbacks -----------------------------------------
        , content_types_provided/2
        , language_available/2
        , charsets_provided/2
        , encodings_provided/2
        %% Webmachine Resource Doesn't Exist Callbacks -------------------------
        , variances/2
        , resource_exists/2
        %% Webmachine Conditional Callbacks ------------------------------------
        , generate_etag/2
        , last_modified/2
        %% Webmachine Update Callbacks -----------------------------------------
        , delete_resource/2
        , delete_completed/2
        , post_is_create/2
        , create_path/2
        , process_post/2
        , is_conflict/2
        %% Webmachine Create Callbacks -----------------------------------------
        , moved_permanently/2
        , previously_existed/2
        , moved_temporarily/2
        , allow_missing_post/2
        %% Webmachine Output Callbacks -----------------------------------------
        , expires/2
        , multiple_choices/2
        , finish_request/2
        ]).

init(_DispatcherConfigList) ->
  Context = orddict:new(),
  %% Maybe enable wmtrace
  %% {{trace, "./"}, Context}.
  {ok, Context}.

%% Webmachine Basic Callbacks --------------------------------------------------

%% B13 - 503 Service Unavailable
ping(ReqData, Context) ->
  %% Respond to ping with pong
  {pong, ReqData, Context}.

%% B13 - 503 Service Unavailable
service_available(ReqData, Context) ->
  %% Save URI {id} into Context
  Id = wrq:path_info(id, ReqData),
  Context2 = orddict:store(id, Id, Context),
  {true, ReqData, Context2}.

%% B12 - 501 Not Implemented
known_methods(ReqData, Context) ->
  %% Check what methods does webmachine know
  {[ 'GET'
   , 'HEAD'
   , 'POST'
   , 'PATCH'
   , 'PUT'
   , 'DELETE'
   %% , 'TRACE'
   %% , 'CONNECT'
   , 'OPTIONS'
   ], ReqData, Context).

%% B11 - 414 Request URI too long
uri_too_long(ReqData, Context) ->
  %% Check if URI is too long
  {false, ReqData, Context}.

%% B10 - 405 Method Not Allowed
allowed_methods(ReqData, Context) ->
  %% Maybe check resource state
  {[ 'GET'
   , 'HEAD'
   , 'PATCH'
   , 'DELETE'
   , 'OPTIONS'
   ], ReqData, Context}.

%% B09 - 400 Bad Request
malformed_request(ReqData, Context) ->
  %% Check known media type
  %% [PLACEHOLDER]
  %% Check JSON syntax
  %% [PLACEHOLDER]
  %% Check JSON Schema
  %% [PLACEHOLDER]
  %% Translate MT to Context:args
  %% [PLACEHOLDER]
  {false, ReqData, Context}.

%% B08 - 401 Unauthorized
is_authorized(ReqData, Context) ->
  %% Get auth info for token
  %% [PLACEHOLDER]
  %% Check if token is valid
  {true, ReqData, Context}.

%% B07 - 403 Forbidden
forbidden(ReqData, Context) ->
  %% Check if {Method, URI, Headers} is forbidden
  %% Do NOT check against Context:args
  %% FIXME Where do you check if Context:args are forbidden ?
  {false, ReqData, Context}.

%% B06 - 501 Not Implemented
valid_content_headers(ReqData, Context) ->
  %% Check if 'Content-*' headers are valid
  {true, ReqData, Context}

%% B05 - 415 Unsupported Media Type
known_media_type(ReqData, Context) ->
  %% Check known media type
  {true, ReqData, Context}.

%% B04 - 413 Request Entity Too Large
valid_entity_length(ReqData, Context) ->
  %% Maybe check media type
  %% [PLACEHOLDER]
  %% Check if request entity is too large
  {true, ReqData, Context}.

%% B03 - 200 OK
options(ReqData, Context) ->
  %% Headers for OPTIONS, if request is OPTIONS
  [].

%% Webmachine Accept Callbacks -------------------------------------------------

%% C03
%% C04 - 406 Not Acceptable
content_types_provided(ReqData, Context) ->
  %% Check if content-type is available
  %% Specify content-type output handlers [{media-type, handler}]
  %% Or as [{{media-type,[{param, value}]}, handler}]
  [].
  %% FIXME - should webmachine enforce 406 on no match?

%% D04
%% D05 - 406 Not Acceptable
language_available(ReqData, Context) ->
  %% Check if language is available
  {true, ReqData, Context}.

%% E05
%% E06 - 406 Not Acceptable
charsets_provided(ReqData, Context) ->
  %% Check if charset is available
  %% Specify output charsets handlers [{charset, handler}]
  {no_charset, ReqData, Context}.

%% F06
%% FIXME SET RESP HEADER Content-Type
%% F07 - 406 Not Acceptable
encodings_provided(ReqData, Context) ->
  %% Check if encoding is available
  %% Specify encoding output handlers [{encoding, handler}]
  [{"identity"}, fun(X) -> X end}].

%% Webmachine Resource Doesn't Exist Callbacks ---------------------------------

%% G07
%% content_types_provided, encodings_provided, charsets_provided (wdc:variances)
variances(ReqData, Context) ->
  %% Request headers for building the response Vary header
  %% other than Accept, Accept-Encoding, Accept-Charset, Accept-Language
  {[], ReqData, Context}.
%% FIXME SET RESP HEADER Vary
resource_exists(ReqData, Context) ->
  %% Maybe read from DB
  %% [PLACEHOLDER]
  %% Check if resource exists
  {true, ReqData, Context}.

%% Webmachine Conditional Callbacks --------------------------------------------

%% G08
%% G09
%% G11 - 412 Precondition Failed
generate_etag(ReqData, Context) ->
  %% Maybe generate ETag by hashing the output from content-type output handler
  {undefined, ReqData, Context}.

%% H10
%% H11
%% H12 - 412 Precondition Failed
last_modified(ReqData, Context) ->
  %% Maybe generate Last-Modified from DB
  {undefined, ReqData, Context}.

%% I12
%% I13
%% K13
%% generate_etag again
%% J18 - 304 Not Modified / 412 Precondition Failed

%% L13
%% L14
%% L15
%% L17 - 304 Not Modified
%% last_modified again

%% Webmachine Update Callbacks -------------------------------------------------

%% M16
%% M20 - 500 Internal Server Error
delete_resource(ReqData, Context) ->
  %% Process DELETE
  {false, ReqData, Context}.
%% 202 Accepted
delete_completed(ReqData, Context) ->
  %% Check if DELETE is sync
  {true, ReqData, Context}.


%% N16
%% N11 - 303 See Other
post_is_create(ReqData, Context) ->
  %% Check if POST should as PUT to an unknown URI
  %% FIXME POST_as_PUT should just continue to o16 (there can be a conflict if create_path is)
  {false, ReqData, Context}.
create_path(ReqData, Context) ->
  %% Create a URI for a POST (as PUT)
  %% Set response Location header
  {undefined, ReqData, Context}.
process_post(ReqData, Context) ->
  %% Process POST
  {false, ReqData, Context}.

%% O16
%% O14 - 409 Conflict
is_conflict(ReqData, Context) ->
  %% Check if PUT is conflict
  {false, ReqData, Context}.
%% content_types_accepted, knownw_media_type, content_types_accepted:handler (accept_helper)

%% Webmachine Create Callbacks -------------------------------------------------

%% H7 - 412 Precondition Failed
%% I7
%% I4 - 301 Moved Permanently + SET RESP HEADER Location
moved_permanently(ReqData, Context) ->
  %% Check if resource has moved permanently
  {false, ReqData, Context}.
%% P3 - 409 Conflict
%% is_conflict
%% content_types_accepted, known_media_type, content_types_accepted:handler (accept_helper)

%% K7
previously_existed(ReqData, Context) ->
  %% Check if resource has previously existed
  {false, ReqData, Context}.
%% K5 - 301 Moved Permanently + SET RESP HEADER Location
%% moved_permanently
%% L5 - 307 Moved Temporarily + SET RESP HEADER Location
moved_temporarily(ReqData, Context) ->
  %% Check if resource has moved temporarily
  {false, ReqData, Context}.
%% M5 - 410 Gone
%% N5 - 410 Gone
allow_missing_post(ReqData, Context) ->
  %% Check if you can POST to a missing resource
  {false, ReqData, Context}.

%% L7 - 404 Not Found
%% M7 - 404 Not Found

%% Webmachine Output Callbacks -------------------------------------------------

%% P11 - 201 Created
%% O20 - 204 No Content

%% O18 - 200 OK
%% FIXME why build body only for GET & HEAD ?
%% generate_etag again
%% last_modified again
expires(ReqData, Context) ->
  %% Generate Expires
  {undefined, ReqData, Context}.
%% content_types_provided again
%% content_types_provided:handler
%% charsets_provided again
%% encodings_provided again
multiple_choices(ReqData, Context) ->
  %% Check if resource gives multiple representations
  {false, ReqData, Context}.

%% respond(Code)
%% generate_etag
%% expires
finish_request(ReqData, Context) ->
  %% Last touches
  {true, ReqData, Context}.
