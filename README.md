# http-headers-status (fork of [http-headers-status](http://code.google.com/p/http-headers-status/))

An activity diagram to describe the resolution of HTTP response status codes, given various headers.

And it goes on Twitter as [#httpdd](https://twitter.com/search/realtime?q=httpdd) - HTTP Decision Diagram.


# Why is this helpful?

Watch [Webmachine: Focus on Resources - Sean Cribbs](http://vimeo.com/20784244) from [&Oslash;redev Conference](http://vimeo.com/user4280938) on [Vimeo](http://vimeo.com).


# Goal

This repository's goal is to build on previous work, and set a "standard" in terms of a HTTP decision diagram.

In doing so, we take a snapshot of the current [Webmachine](https://github.com/basho/webmachine) callbacks that are linked to [Alan Dean](https://twitter.com/adean)'s [v3 decision diagram](https://raw.github.com/andreineculau/http-headers-status/master/v3/http-headers-status-v3.png), and trying to do constructive criticism and addressing the issues with

* clearer definitions of the steps implied by the existing callbacks
* possibly adding new callbacks
* possibly a new v4 diagram

Take it also as a process of gaining [context](https://twitter.com/slicknet/status/300625746966241280), while the existing callbacks and the existing diagram may be spot on.


# Possible roadmap

* `✔ 2013-02-17` project published
* `✔ 2013-02-17` v3 wm - reasoning about [webmachine's implementation](v3/webmachine_resource.erl)
* `✔ 2013-02-19` v4 draft - reasoning about [a cleaner decision diagram](v4/http-headers-status-v4.png)


* `_ 2013-03-xx` v3 wm - reasoning about wrapping the v4 flow around the v3 flow
* `_ 2013-03-31` v4 draft - finalize


* `_ 2013-05-xx` v4 wm - fork ?


# Quicklinks

* [v3 decision diagram](v3/http-headers-status-v3.png)
* [webmachine_decision_core](https://github.com/basho/webmachine/blob/master/src/webmachine_decision_core.erl)


* [v4 draft decision diagram](v4/http-headers-status-v4.png)


# Kudos to

* [Alan Dean](https://twitter.com/adean) (author of http-headers-status) for thinking straight way before many of us, and sharing his thoughts http://code.google.com/p/http-headers-status/ .

* [Basho](https://twitter.com/basho) and their [Webmachine](https://github.com/basho/webmachine/wiki) for incorporating Alan's work. Same goes for [Sean Cribbs](https://twitter.com/seancribbs), not only behind Basho's Webmachine, but also behind [Webmachine-Ruby](https://github.com/seancribbs/webmachine-ruby).

* [Loïc Hoguin](https://twitter.com/lhoguin) and his [cowboy](https://github.com/extend/cowboy) for working in the same direction, but with [a less sexy outcome](https://raw.github.com/nevar/cowboy/a597393265d9d69df3f9b0fe660087a208e86641/guide/rest_flow_diagram.svg) :)

* [Philipp Meier](https://twitter.com/ordnungswprog) and his [clojure-liberator](http://clojure-liberator.github.com/) for working in the same direction, but with [a less sexy outcome](http://philipp.meier.name/t/liberator-flow-color.png) :)

## Others

* [Cyril Rohr](https://twitter.com/crohr) - http://crohr.me/journal/2011/http-status-codes-flowchart.html


# License

MIT
