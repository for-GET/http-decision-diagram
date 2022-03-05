---
layout: post
title: HTTP/REST is not big, nor healthy. It's hell no!
categories: consume serve
tags: software specification kitt rfc pegjs
published: true
comments: true
share: true
---


To get the small things out of the way, the title is intentionally controversial (credits: [Gabriel Iglesias](http://www.youtube.com/watch?v=u5qM5kX2_C0)). But beyond that, it only says that HTTP is more than what the average can handle - after all HTTP/REST [is software design on the scale of decades](http://roy.gbiv.com/untangled/2008/rest-apis-must-be-hypertext-driven).

Another thing to get out of the way - this is not another lame post to be summarized as ["I make no attempt to satisfy a standard if it doesn't feel right."](http://www.vinaysahni.com/best-practices-for-a-pragmatic-restful-api). If anything, it's just another lame post, pointing out some lack of context.

Now that I got your attention, I'll take it step by step - details and views.

<blockquote class="twitter-tweet" data-cards="hidden"><p>Instead of assuming that people are dumb, ignorant, and making mistakes, assume they are smart, doing their best, and that you lack context.</p>&mdash; Nicholas C. Zakas (@slicknet) <a href="https://twitter.com/slicknet/status/300625746966241280">February 10, 2013</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

## (NOT) Simple

When you hear that HTTP/REST is simple, there are high chances that you're reading something on [Rorschach-REST](http://bitworking.org/news/Hi_REST__Lo_REST_and_Everything_in_between_REST) or similar; the least you can do is be on your toes.

It is not simple. If it were, then people wouldn't argue about simplifying it, about levels, etc. That doesn't make it rocket science either, but that's another story.

## (NOT) Easy/trivial

Just like there is complex and complicated, there is also simple and easy.

Despite HTTP being complex, not simple, HTTP seems rather trivial - after all, that is what people seek as convenience. Most people understand a HTTP method, a URI, a payload, a HTTP status code, etc. Some people understand safe methods, idempotent methods, HTTP headers, etc. Using or consuming HTTP is indeed trivial. Even scratching the surface of serving HTTP.

But implementing HTTP by the book is not.

How many know that a HTTP response can have [more than one HTTP status code](http://tools.ietf.org/html/draft-ietf-httpbis-p2-semantics-22#section-6.2.1)? Or that some responses, based on the status code, may or may not have a body, while other must or must not have a body?

How many OTW (one thing well) libraries have you seen out there to handle conneg, dates, etags, parsing and stringifying headers, etc?

## (NOT) Clear

With so much specification around, most of it available for a couple of decades, one would think that every scenario is covered, and that there is no decision left to take, because everything has been thought-out by professionals. It is actually quite the opposite: there are plenty of moments when you'll go like [WAT?](https://www.destroyallsoftware.com/talks/wat) or just go blank, and resign. This is what feeds the whole "it doesn't feel right" philosophy. If you think this cannot be possible, then please send me a link to a perfect HTTP client/server. AFAIK there is no implementation so far that aggregates and is compliant with all the relevant HTTP specifications.

In 2005, [web services were hurting our heads](http://www.mnot.net/blog/2005/01/23/terminology), but in 2013, HTTP isn't any different, if you take it for its literal specifications. Sure, maybe you don't need all of the pieces to get started, but you will need more and more as you build an API along. It's either that, or you'll start reinventing the wheel and ignore the specifications altogether (e.g. ?_method=), and argue against them with your feelings.

<blockquote class="twitter-tweet" data-cards="hidden"><p>.@<a href="https://twitter.com/darrel_miller">darrel_miller</a> @<a href="https://twitter.com/veesahni">veesahni</a> your "feel right" &gt;&gt;&gt; "opinions [...] academic discussions [...] subjective [...] fuzzy" ?! <a href="http://t.co/LdazVOkXw0" title="http://buff.ly/112YTwo">buff.ly/112YTwo</a></p>&mdash; Andrei Neculau (@andreineculau) <a href="https://twitter.com/andreineculau/status/340105368363474945">May 30, 2013</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

How do you treat duplicate query keys? [There isn't any specification on that](http://stackoverflow.com/questions/1746507/authoritative-position-of-duplicate-http-get-query-keys). Maybe there isn't any immediate need for that, but the option of letting things like this unspecified doesn't give any consistent gain either. On the contrary - it hurts interoperability.

[Regular expressions always come in pair](http://www.codinghorror.com/blog/2008/06/regular-expressions-now-you-have-two-problems.html), but even so - why haven't we [simplified emails](http://haacked.com/archive/2007/08/21/i-knew-how-to-validate-an-email-address-until-i.aspx) by means of publishing a simple best practice document? Then we could all rant "you're not following doc X, one page long, with 10 lines implementation". Being too liberal, having to make too many choices, can either end up with [the paradox of choice](http://www.youtube.com/watch?v=1bqMY82xzWo) - no choice or poor choice. If the ad-hoc *technical solution* for validating emails became a regular expression, then what advantages does it bring to keep it so [liberal](http://www.ex-parrot.com/pdw/Mail-RFC822-Address.html) that nobody gets it right? Some because of ignorance, they don't know what is right, some because they don't know how to do it right, and some that cannot argue in favor of doing right no matter how much they'd like that.

Same goes for [URIs](http://blog.lunatech.com/2009/02/03/what-every-web-developer-must-know-about-url-encoding); a flashy example [http://klarna.com](http://klarna.com) = [http://88.80.182.205](http://88.80.182.205) **= [http://1481684685](http://1481684685)** -> WAT?!

> Simplify to amplify.



## Solutions

Let me first rephrase and summarize the problem, and only then follow up with some solutions given the humble context that I have.

HTTP specification is so broad, so dispersed or hyperlinked if you will, and so loosely defined on the other hand, that we are constantly teaching ourselves and one another what HTTP is, and how it is supposed to be implemented or consumed. If you want an analogy - just think of a recipe that doesn't give you the steps, but just the ingredients. You'll follow grand chefs in making that recipe come alive, but you'll still not know how to make the recipe on your own - sometimes you will mess up the order, sometimes you will mess up the times, sometimes you won't have the necessary tools and you'll give up or improvise incorrectly, etc, etc.


### The too-late solution

Things inevitably change. One can already notice some simplifications in the [HTTP 2.0 draft](http://tools.ietf.org/html/draft-ietf-httpbis-http2) (e.g. all header names are lowercase; message meta is all made of headers, special headers marked with a colon prefix replaced method, path, host, scheme, status code). Things like these need to be applauded, and I think there are more in the pipeline. Whatever is of no considerable gain should be stripped down. But by the time the majority upgrades from HTTP/1.1 to HTTP/2.0, and we will be safe to ignore HTTP/1.1 implementations, just like we eventually came to do about some browsers, many years will pass. What do we do until then?

The worst of it all is the possibility that we would repeat history, just under different names now, and still write too liberal RFCs and with too many open ends, and write code willy-nilly as if Internet standards have regular expressions, not [ABNFs](http://www.ietf.org/rfc/rfc2234.txt).


### The by-the-book solution

We need to forget about HTTP methods, headers, status codes, resources, and the faster we do that, the better.

<iframe src="http://player.vimeo.com/video/45768176?title=0&amp;byline=0&amp;portrait=0" width="500" height="375" frameborder="0" webkitAllowFullScreen mozallowfullscreen allowFullScreen></iframe>

<p><a href="http://vimeo.com/45768176">Promote Knowledge Management (2)</a> from <a href="http://vimeo.com/andreineculau">Andrei Neculau</a> on <a href="http://vimeo.com">Vimeo</a>.</p>

And what is the best way to forget, but "not even knowing, in the first place"!

> We can't have it all, and worse yet the desire to have it all and the illusion that we can is one of the principal sources of torture of modern affluent free and autonomous thinkers. *Barry Schwartz [#](http://web.archive.org/web/20130409203650/http://itc.conversationsnetwork.org/shows/detail252.html)*

My efforts go in this direction, as it is rather clear that HTTP APIs will grow in numbers, that I will contribute to that by both consuming and serving them, and that I really don't want to repeatedly implement, nor discuss the same stuff over and over again.

[![#httpdd](https://rawgithub.com/for-GET/http-decision-diagram/master/httpdd.png "#httpdd")](https://rawgithub.com/for-GET/http-decision-diagram/master/httpdd.png)

1. Meet the [HTTP decision diagram](https://github.com/for-GET/http-decision-diagram). Introduced several years ago by [Alan Dean](https://twitter.com/adean) as [http-headers-status](http://code.google.com/p/http-headers-status/) and then built into Erlang, Ruby and Clojure, the diagram is an abstract way to think of a HTTP server implementation. The diagram allows for a binary-transition Finite State Machine to decide on the proper HTTP status code and required HTTP headers. With that in mind, it makes use of defined callbacks, some with boolean, some with mixed outputs to decide what is the next proper transition. You can [watch Sean Cribbs at Øredev Conference](http://vimeo.com/20784244) speaking on how this is helpful and how it (v3; Alan Dean's version) is implemented in Webmachine (Erlang).

1. Meet [an implementation of the v4 diagram's FSM in NodeJS](https://github.com/hyperrest/machine), under the name [hyperrest-machine](https://github.com/hyperrest/machine). An Erlang/Elixir implementation is coming.

1. Meet [a simple iteration of a HTTP server that is using the v4 diagram's FSM](https://github.com/hyperrest/server), under the name [hyperrest-server](https://github.com/hyperrest/server).

1. My plan is to do the same thing (HTTP decision diagram and implementation) for the HTTP client (most probably integrated into [my hypermedia client](https://github.com/hyperrest/client)) and the HTTP cache-proxy.

1. Meet [my first iteration of parsers & generators](https://github.com/andreineculau/otw/tree/master/like/HTTP) for what I call *tokenized* HTTP headers. When I started, I didn't know any better, so despite being smarter software than the average, it is still far from 100% compliance with the specification (I take the liberty, in spite of the usage of regular expressions, to label the weaknesses as being a victim of too liberal mumbo-jumbo; too harsh? then maybe you can have a look at a Set-Cookie header and the comma in the Expires parameter).

1. Meet [my second iteration of parsers & generators & not only](https://github.com/andreineculau/api-pegjs). Again, I don't know any better. I'm using [PEGjs](https://github.com/dmajda/pegjs) for parsing, after [translating a core piece of the HTTP ABNFs](https://github.com/andreineculau/core-pegjs) (why didn't I stick to ABNFs is another bed-time story, but not for tonight). This is really in an infant stage, with code that hasn't yet been pushed, need's testing.

*Note* One comment regarding testing. It's a major problem for my parsers. Why? Well, firstly I do mea culpa - because the reality is that all of this is being done in my spare time ~= no time, so I focus on what brings quick gain and blindly hope that I don't write such bad interfaces (what's behind, you can refactor). But secondly, and somewhat more importantly, it's because except [uritemplate-test](https://github.com/uri-templates/uritemplate-test) there is no other collection of test data for HTTP messages. Am I wrong? So, since there is none, my goal would be to write something simple along those guidelines. I don't just want to write tests for my code that can never be ported easily to another library or another language. HTTP is not about libraries, nor languages. But that will take time, and I'll take it without any trendy sense of urgency.

None of the above software is in a state that I consider production-ready, just to be clear. The philosophy backing it though is production-ready for years now, and for years to come - it's a safe bet for me, but feel free to challenge that in the comments.

I will follow up on these in the weeks to come, but it suffices to say for now that if you agree HTTP is not simple, nor easy, then join the KITT (~KISS) ride: create tools that abstract specifications into customizable tools with sensible defaults.

Otherwise, I wish you good luck in your neverending fight of teaching everyone everything about HTTP/REST.

### The utopian solution

There is one more solution that I put forward, a solution that is not in my power.

Most specifications follow the rule that they only become standards once they have two independent implementations. I won't stop at asking myself how the implementations of HTTP and email looked like, but actually ask for something.. outrageous?!... which is that each specification comes from now on with a technical solution aside. We all (should) know [that language doesn't matter](http://highscalability.com/blog/2013/1/16/what-if-cars-were-rented-like-we-hire-programmers.html) as long as it is not pseudocode - we need software to compile, run and pass tests. If you only wrote ABNFs and words - no standard for you, mister! You write language-agnostic test data (XML, JSON, CSV, etc) and software (Fortran, Assembler, Prolog, Ruby, whatever) to match your ABNFs and words - I bow, master!

And that's not because programmers can't [read](http://haacked.com/archive/2007/02/27/Why_Cant_Programmers._Read.aspx) or [program](http://www.codinghorror.com/blog/2007/02/why-cant-programmers-program.html), but because it simplifies and amplifies - it lets people focus on other matters at hand, that are closer to their domain. I'm lucky to be in a work environment which isn't [fifty-fifty](http://www.codinghorror.com/blog/2004/09/skill-disparities-in-programming.html), but the global environment sounds more like ninety-ten, when it comes to skilled computer scientists, especially on mundane topics like APIs (yes, APIs are mundane, ask computer scientists, not brogrammers).

Repetition needs to be eliminated - you can't just go round with a microwave oven schematics, praying that everyone makes time to understand and find the resources to build one. It's not only time consuming, but at times, it's really impossible to argue. Have you ever heard of the [Status header](https://github.com/bigcompany/know-your-http/blob/master/headers.tex#L136)? Answer: ["what do you have in mind?"](https://github.com/bigcompany/know-your-http/issues/11). And don't be fooled, it's not just the small guys. Heck, the next in line could even be me.

<blockquote class="twitter-tweet" data-cards="hidden"><p>seriously, @<a href="https://twitter.com/github">github</a>? --- curl -sI <a href="https://t.co/Dn3oxwykbx" title="https://github.com">github.com</a> | grep "Status:" --- <a href="https://twitter.com/search/%23http">#http</a></p>&mdash; Andrei Neculau (@andreineculau) <a href="https://twitter.com/andreineculau/status/335605720663851010">May 18, 2013</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

Above all, software and tests make for a great candidate of [eating your own dog food](http://en.wikipedia.org/wiki/Eating_your_own_dog_food).

> You write a specification for URI syntax.

> Oh, it has an ABNF specification? then write a validator and a parser.

> Oh, it's about sending data? then write a generator.

> Oh, you need to test your software? then write some language-agnostic test data.

> Oh, some tests fail, then don't forget that ABNFs are not all of the specification; sometimes not strict enough, sometimes in need of context, sometimes just too complex corner-cases.


## TL;DR

HTTP/REST is not as [simple](http://rest.elkstein.org/) [as some people](http://net.tutsplus.com/tutorials/other/a-beginners-introduction-to-http-and-rest/) [tend](http://tomayko.com/writings/rest-to-my-wife) [to advertise](http://docs.mongodb.org/ecosystem/tools/http-interfaces/) [it](http://tarlogonjava.blogspot.se/2012/04/why-rest-or-simple-vs-easy.html).

Put together, HTTP specifications and extensions go on tens, if not hundreds, of A4 papers. And HTTP/REST is not only complex, but it also requires you to change paradigms, [to stop thinking about code](https://twitter.com/dret/status/326829566381395968), and [to rethink the problem to fit a sound paradigm](http://tech.groups.yahoo.com/group/rest-discuss/message/19372).

Software is [the litmus test](http://en.wikipedia.org/wiki/Litmus_test_(politics)) of each specification. No software? then stop writing poetry, expecting everybody else to have the one and the same interpretation and complaining that nobody understands you. Make the spec a black box that true professionals know how to use, export simple APIs. Make it usable. Delegate and be delegated. Do one thing well.

<iframe width="420" height="315" src="https://www.youtube-nocookie.com/embed/E_rwwEo5YhY?rel=0" frameborder="0" allowfullscreen></iframe>

<blockquote class="twitter-tweet" data-cards="hidden"><p><a href="https://twitter.com/search/%23RESTful">#RESTful</a> or <a href="https://twitter.com/search/%23RESTfool">#RESTfool</a> or <a href="https://twitter.com/search/%23RESTfoul">#RESTfoul</a> or <a href="https://twitter.com/search/%23RESTfail">#RESTfail</a> ? now pick. same, same, but different</p>&mdash; Andrei Neculau (@andreineculau) <a href="https://twitter.com/andreineculau/status/312136503121809408">March 14, 2013</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>


## Errata

1. As [Mike Amundsend](https://twitter.com/mamund/status/344106758731603969) pointed out on good grounds, this post munched HTTP and REST in one go. The two do NOT depend on one another. Theoretically and from a adding-noise perspective, this is bad, but I took the decision to go with the flow - 9 out of 10 posts that I read don't make the difference. They speak about RESTful APIs, and then they explain HTTP terms. The goal of this post is to touch on both worlds - both are fluffy implementation-wise. So until 1) there is a massive decoupling (in perception) between HTTP and REST (i.e. use a different protocol, but keep to a REST architectural style) and 2) both the protocol and the style have hands-on artifacts in line with author's vision - I might be wrong, dead wrong even, but I do not see a convincing point in highlighting the distinction, beyond an academic and an educational one. First let's focus on additions and substractions, and then integrals and primitives. There's a pretty [long](https://twitter.com/veesahni/status/339728727736995840) and [widening](https://twitter.com/search/realtime?q=veesahni%20best%20practices&src=typd) road ahead.