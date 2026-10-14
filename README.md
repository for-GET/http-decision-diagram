# http-decision-diagram

An activity diagram to describe the resolution of HTTP response status codes, given various headers, implemented via semantical callbacks.

And it goes on Twitter as [#httpdd](https://twitter.com/search/realtime?q=httpdd) - HTTP Decision Diagram.

**This is part of a bigger effort: [for-GET HTTP](https://github.com/for-GET/README).**

The diagram follows the indications in [RFC9110](https://datatracker.ietf.org/doc/html/rfc9110) [RFC9111](https://datatracker.ietf.org/doc/html/rfc9111) [RFC9112](https://datatracker.ietf.org/doc/html/rfc9112), and fills in the void where necessary (see also [RFC6585](https://datatracker.ietf.org/doc/html/rfc6585) [RFC7725](https://datatracker.ietf.org/doc/html/rfc7725) [RFC8470](https://datatracker.ietf.org/doc/html/rfc8470) [RFC9211](https://datatracker.ietf.org/doc/html/rfc9211) [RFC9213](https://datatracker.ietf.org/doc/html/rfc9213)). Under no circumstances does this diagram override the HTTP specifications. If it does, please file an issue as soon as possible.

Out of scope: 510 (Not Extended, [RFC2774](https://datatracker.ietf.org/doc/html/rfc2774) — Historic), 207/208/508 (WebDAV), 226 (IM Used, RFC 3229). [Details](doc/README.md#diagram).

**The diagram is also available in [PNG/JPEG/SVG](http://for-get.github.io/http-decision-diagram/httpdd.fsm.html) and [JSON](httpdd.fsm.json) format exported from the [Cosmogol](httpdd.fsm.cosmogol) source. [See the documentation here](doc/README.md).**

![HTTP headers status](https://github.com/for-GET/http-decision-diagram/blob/master/httpdd.fsm.png?raw=true)

---

# cache-retrieve and cache-store

[Darrel Miller](http://www.bizcoder.com/caching-is-hard-draw-me-a-picture) started something similar to HTTP decision diagram, in terms of deciding whether to cache (store) or not a HTTP response, and whether to respond to a HTTP request with a cached HTTP response or not.

**Retrieval decisions follow [RFC9111](https://datatracker.ietf.org/doc/html/rfc9111):** `no-cache` (request or storage) forces revalidation, `stale-while-revalidate` serves stale while revalidating, and `must-revalidate` (and the storage `no-cache` directives) prevent serving stale responses.

**The cache-retrieve diagram is available in [PNG/JPEG/SVG](http://for-get.github.io/http-decision-diagram/httpdd.fsm.html?httpdd-cache-retrieve.fsm.json) and [JSON](httpdd-cache-retrieve.fsm.json) format exported from the [Cosmogol](httpdd-cache-retrieve.fsm.cosmogol) source.**

**The cache-store diagram is available in [PNG/JPEG/SVG](http://for-get.github.io/http-decision-diagram/httpdd.fsm.html?httpdd-cache-store.fsm.json) and [JSON](httpdd-cache-store.fsm.json) format exported from the [Cosmogol](httpdd-cache-store.fsm.cosmogol) source.**

---

## [README more](README.more.md)

## License

[Apache 2.0](LICENSE)

## Stargazers over time

[![Stargazers over time](https://starchart.cc/for-GET/http-decision-diagram.svg)](https://starchart.cc/for-GET/http-decision-diagram)
