# http-headers-status (fork of [http-headers-status](http://code.google.com/p/http-headers-status/))

An activity diagram to describe the resolution of HTTP response status codes, given various headers.

# Goal

This repository's goal is to build on previous work, and set a "standard" in terms of a HTTP decision diagram.

In doing so, we take a snapshot of the current [Webmachine](https://github.com/basho/webmachine) callbacks that are linked to [Alan Dean](https://twitter.com/adean)'s decision diagram (v3), and trying to do constructive criticism and addressing the issues with

* clearer definitions of the steps implied by the existing callbacks
* adding new callbacks
* possibly a v4 diagram

Take it also as a process of gaining [context](https://twitter.com/slicknet/status/300625746966241280), while the callbacks and the diagram may be spot on.


# Kudos to

* [Alan Dean](https://twitter.com/adean) (author of http-headers-status) for thinking straight way before many of us, and sharing his thoughts http://code.google.com/p/http-headers-status/ .

* [Basho](https://twitter.com/basho) and their [Webmachine](https://github.com/basho/webmachine/wiki) for incorporating Alan's work. Same goes for [Sean Cribbs](https://twitter.com/seancribbs), the person behind Basho's Webmachine, for [Webmachine-Ruby](https://github.com/seancribbs/webmachine-ruby).

* [Loïc Hoguin](https://twitter.com/lhoguin) and his [cowboy](https://github.com/extend/cowboy) for working in the same direction, but with [a less sexy outcome](https://raw.github.com/nevar/cowboy/a597393265d9d69df3f9b0fe660087a208e86641/guide/rest_flow_diagram.svg) :)

* [Philipp Meier](https://twitter.com/ordnungswprog) and his [clojure-liberator](http://clojure-liberator.github.com/) for working in the same direction, but with [a less sexy outcome](http://philipp.meier.name/t/liberator-flow-color.png) :)

## Others

* [Cyril Rohr](https://twitter.com/crohr) - http://crohr.me/journal/2011/http-status-codes-flowchart.html


# License

MIT
