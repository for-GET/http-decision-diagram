# http-decision-diagram

An activity diagram to describe the resolution of HTTP response status codes, given various headers, implemented via semantical callbacks.

And it goes on Twitter as [#httpdd](https://twitter.com/search/realtime?q=httpdd) - HTTP Decision Diagram.

**This is part of a bigger effort: [for-GET HTTP](https://github.com/for-GET/README).**

The diagram follows the indications in [RFC7230](https://tools.ietf.org/html/rfc7230) [RFC7231](https://tools.ietf.org/html/rfc7231) [RFC7232](https://tools.ietf.org/html/rfc7232) [RFC7233](https://tools.ietf.org/html/rfc7233) [RFC7234](https://tools.ietf.org/html/rfc7234) [RFC7235](https://tools.ietf.org/html/rfc7235), and fills in the void where necessary. Under no circumstances does this diagram override the HTTP specifications. If it does, please file an issue as soon as possible.

**[See the documentation here](doc/README.md).**

![HTTP headers status](https://rawgithub.com/for-GET/http-decision-diagram/master/httpdd.png)

---

---

## Why, why, why

### Why is this helpful?

Watch [Webmachine: Focus on Resources - Sean Cribbs](http://vimeo.com/20784244) from [&Oslash;redev Conference](http://vimeo.com/user4280938) on [Vimeo](http://vimeo.com).

Sean also has a good rundown of [why an FSM is a good match for a protocol specification/implementation](http://seancribbs.com/tech/2012/01/16/webmachine-vs-grape/).


### Goal

This repository's goal is to build on previous work, and set a "reference" in terms of a HTTP decision diagram and necessary callbacks.

In doing so, we take a snapshot of the current [Webmachine](https://github.com/basho/webmachine) callbacks that are linked to [Alan Dean](https://twitter.com/adean)'s [http-headers-status](http://code.google.com/p/http-headers-status), and trying to do constructive criticism and addressing outstanding issues

* in a v4 diagram
* by adding/modifying Webmachine's callbacks
* with clear definitions of the steps/logic implied by the callbacks
* with a diagram described as FSM thanks to [Cosmogol](http://tools.ietf.org/html/draft-bortzmeyer-language-state-machines), with a JSON AST export.

Take it also as a process of gaining [context](https://twitter.com/slicknet/status/300625746966241280), while the existing callbacks and the existing diagram may be spot on.


## Kudos to

* [Alan Dean](https://twitter.com/adean) (author of http-headers-status) for thinking straight, way before many of us, and sharing his thoughts http://code.google.com/p/http-headers-status .

* [Basho](https://twitter.com/basho) and their [Webmachine](https://github.com/basho/webmachine/wiki) for incorporating Alan's work. Same goes for [Sean Cribbs](https://twitter.com/seancribbs), not only behind Basho's Webmachine, but also behind [Webmachine-Ruby](https://github.com/seancribbs/webmachine-ruby).

* [Loïc Hoguin](https://twitter.com/lhoguin) and his [cowboy](https://github.com/extend/cowboy) for working in the same direction, but with [a less sexy outcome](https://raw.github.com/nevar/cowboy/a597393265d9d69df3f9b0fe660087a208e86641/guide/rest_flow_diagram.svg) :)

* [Philipp Meier](https://twitter.com/ordnungswprog) and his [clojure-liberator](http://clojure-liberator.github.com/) for working in the same direction, but with [a less sexy outcome](http://philipp.meier.name/t/liberator-flow-color.png) :)

* [Stephane Bortzmeyer](https://twitter.com/bortzmeyer), another straight thinker, for coming up with [Cosmogol](http://tools.ietf.org/html/draft-bortzmeyer-language-state-machines)

### Others

* [Cyril Rohr](https://twitter.com/crohr) - http://crohr.me/journal/2011/http-status-codes-flowchart.html


## License

[Apache 2.0](LICENSE)
