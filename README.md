# http-decision-diagram

An activity diagram to describe the resolution of HTTP response status codes, given various headers, implemented via semantical callbacks.

And it goes on Twitter as [#httpdd](https://twitter.com/search/realtime?q=httpdd) - HTTP Decision Diagram.

**This is part of a bigger effort: [for-GET HTTP](https://github.com/for-GET/README).**

The diagram follows the indications in [RFC7230](https://tools.ietf.org/html/rfc7230) [RFC7231](https://tools.ietf.org/html/rfc7231) [RFC7232](https://tools.ietf.org/html/rfc7232) [RFC7233](https://tools.ietf.org/html/rfc7233) [RFC7234](https://tools.ietf.org/html/rfc7234) [RFC7235](https://tools.ietf.org/html/rfc7235), and fills in the void where necessary. Under no circumstances does this diagram override the HTTP specifications. If it does, please file an issue as soon as possible.

**The diagram is also available in [SVG](http://for-get.github.io/http-decision-diagram/httpdd.fsm.html) and [JSON](httpdd.fsm.json) format exported from the [Cosmogol](httpdd.fsm.cosmogol) source. [See the documentation here](doc/README.md).**

![HTTP headers status](https://rawgithub.com/for-GET/http-decision-diagram/master/httpdd.png)

---

# cache-retrieve and cache-store

[Darrel Miller](http://www.bizcoder.com/caching-is-hard-draw-me-a-picture) started something similar to HTTP decision diagram, in terms of deciding whether to cache (store) or not a HTTP response, and whether to respond to a HTTP request with a cached HTTP response or not.

**The cache-retrieve diagram is available in [SVG](http://for-get.github.io/http-decision-diagram/httpdd.fsm.html?httpdd-cache-retrieve.fsm.json) and [JSON](httpdd-cache-retrieve.fsm.json) format exported from the [Cosmogol](httpdd-cache-retrieve.fsm.cosmogol) source.**

**The cache-store diagram is available in [SVG](http://for-get.github.io/http-decision-diagram/httpdd.fsm.html?httpdd-cache-store.fsm.json) and [JSON](httpdd-cache-store.fsm.json) format exported from the [Cosmogol](httpdd-cache-store.fsm.cosmogol) source.**

---

## [README more](README.more.md)

## License

[Apache 2.0](LICENSE)
