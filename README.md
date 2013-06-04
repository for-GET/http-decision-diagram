# http-decision-diagram

An activity diagram to describe the resolution of HTTP response status codes, given various headers, implemented via semantical callbacks.

And it goes on Twitter as [#httpdd](https://twitter.com/search/realtime?q=httpdd) - HTTP Decision Diagram.

This is a fork of Alan Dean's [http-headers-status](http://code.google.com/p/http-headers-status/).


## Roadmap

* v3
    * [X] `2013-02-17` [diagram](https://rawgithub.com/andreineculau/http-decision-diagram/master/v3/http-headers-status-v3.png) - analyze
    * [X] `2013-02-17` webmachine's implementation - analyze [webmachine_resource](https://github.com/basho/webmachine/blob/master/src/webmachine_resource.erl) and [webmachine_decision_core](https://github.com/basho/webmachine/blob/master/src/webmachine_decision_core.erl)
* **v4**
    * [X] `2013-02-19` 1st draft
    * [~] `2013-08-31` [DIAGRAM](https://rawgithub.com/andreineculau/http-decision-diagram/master/v4/http-decision-diagram-v4.png)
    * [~] `2013-08-31` [EXPLANATION](v4/README.md)
    * [_] `2013-08-31` implementation in node/elixir/erlang


## Why, why, why

### Why is this helpful?

Watch [Webmachine: Focus on Resources - Sean Cribbs](http://vimeo.com/20784244) from [&Oslash;redev Conference](http://vimeo.com/user4280938) on [Vimeo](http://vimeo.com).

Sean also has a good rundown of [why an FSM is a good match for a protocol specification/implementation](http://seancribbs.com/tech/2012/01/16/webmachine-vs-grape/).


### Goal

This repository's goal is to build on previous work, and set a "standard" in terms of a HTTP decision diagram and necessary callbacks.

In doing so, we take a snapshot of the current [Webmachine](https://github.com/basho/webmachine) callbacks that are linked to [Alan Dean](https://twitter.com/adean)'s [v3 decision diagram](https://rawgithub.com/andreineculau/http-decision-diagram/master/v3/http-headers-status-v3.png), and trying to do constructive criticism and addressing the issues with

* clearer definitions of the steps implied by the existing callbacks
* adding new callbacks
* a new v4 diagram

Take it also as a process of gaining [context](https://twitter.com/slicknet/status/300625746966241280), while the existing callbacks and the existing diagram may be spot on.


## Kudos to

* [Alan Dean](https://twitter.com/adean) (author of http-headers-status) for thinking straight, way before many of us, and sharing his thoughts http://code.google.com/p/http-headers-status/ .

* [Basho](https://twitter.com/basho) and their [Webmachine](https://github.com/basho/webmachine/wiki) for incorporating Alan's work. Same goes for [Sean Cribbs](https://twitter.com/seancribbs), not only behind Basho's Webmachine, but also behind [Webmachine-Ruby](https://github.com/seancribbs/webmachine-ruby).

* [Loïc Hoguin](https://twitter.com/lhoguin) and his [cowboy](https://github.com/extend/cowboy) for working in the same direction, but with [a less sexy outcome](https://raw.github.com/nevar/cowboy/a597393265d9d69df3f9b0fe660087a208e86641/guide/rest_flow_diagram.svg) :)

* [Philipp Meier](https://twitter.com/ordnungswprog) and his [clojure-liberator](http://clojure-liberator.github.com/) for working in the same direction, but with [a less sexy outcome](http://philipp.meier.name/t/liberator-flow-color.png) :)

### Others

* [Cyril Rohr](https://twitter.com/crohr) - http://crohr.me/journal/2011/http-status-codes-flowchart.html


## License

MIT
