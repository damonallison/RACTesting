# RACTesting #

The goals of this repository are:

* Teach functional reactive programming (FRP) and Reactive Cocoa thru examples.

* Be a "cookbook" of RAC examples for you to use as a reference. 
  The RAC documentation is terrific, hopefully these examples reinforce 
  or exceed that documentation.

## Functional Reactive Programming #

Program inputs come in all different forms (touch events, timers, network
events, etc). Programmers use state to combine various inputs and produce
outputs.

State is bad. Rather than relying on state between input and output, FRP
allows you to establish relationships between inputs and outputs. When 
input changes, output changes.

For example, when a boolean value changes, a UI button is  enabled or disabled. 
Establishing relationships allows us to avoid keeping interim state 
between the input and output.

RAC provides functional constructs like map, filter, reduce, combine, etc on 
sequences and streams of values.

## RAC 3.0 ##

[The Future Of ReactiveCocoa by Justin Spahr-Summers • GitHub Reactive Cocoa Developer Conference]
 (https://www.youtube.com/watch?v=ICNjRS2X8WM&list=PL0lo9MOBetEEXnrrP5pwZxSkGvaDBGdOC&index=2)

Justin Spahr-Summers spoke on the future of RAC. Watch it if you're interested
in the future of RAC. RAC 3.0 was in early discussion at the time. He discusses 
along with the more-functional-than-objc swift migration
inevitably in the works, there is likely a lot of work to be done before 3.0 
ships. 


* RAC 3.0 : deleting API.

* Encourages "cold" signals everywhere. He recognized the confusion caused
  around "hot" and "cold" signals and wants that confusion gone. He claimed
  that the enumerable (pull) observable (push) support solves this confusion.

* Erik Meijer : "Duals" : Enumerables (pull) / Observables (push)

* Observer == subscriber - they get pushed events.
* Observable == signal

* Hot Signal -> Observables (always alive, pushing events)
* Cold Signal -> Enumerables (consumer pulls (promise events))

* RACSequence goes away - turns into an enumerator.
* RACCommand ("worst API I've built")


[Reactive Cocoa Developer Conference • Panel Q&A and Discussion]
(https://www.youtube.com/watch?v=NzKp2AjnMMM&index=4&list=PL0lo9MOBetEEXnrrP5pwZxSkGvaDBGdOC)

* RACSignal - all type information is lost. Generics will fix that.

* RAC 3.0 will offer the "ideal" version of RAC w/ backwards compatibility to 
bridge 2.0 and 3.0. Swift / Obj-C provides a nice clean break to move RAC 
to an ideal state without pulling baggage forward. 

* Does swift obsolete RAC?
* No : swift provides functional constructs but doesn't provide the asynchronous 
ability that RAC provides.

* Delegates conflate two patterns - observing (functions that return void), 
and delegation (returning data from the delegate).
Observer (good for RAC). True delegates (that return value) - implement 
delegate methods as you typically would.

* 3.0 "promised based enumeration" (generators) is better than today's 
RACSequence which is not asynchronous.

* 3.0 == Enumerables / Observables


* PromiseKit is good for single events. Streams are a superset of promises
  and are much more capable than promises alone.

* Bolts. What does RAC do that Bolts does not? Bolts is just promises. 
  Bolts are based on .NET's TPL. RAC combines all event types into a common 
  idiom (a signal). Promises are a subset of RAC. 

Interesting that RAC is based on Microsoft's Rx library. Bolts is based on 
.NET's TPL (task parallel library).
	
* Enumerable (pull (i/o)) / observables (push).

* Multicasting is gone in 3.0. Multicasting (hot signals) - do the work once,
  then broadcast to all subscribers. Multicasting is going away in 3.0 in favor
  of observers. Network requests are the common pattern here. 

* RAC has a high learning curve. 3.0 will be simplier to use and lower the 
  barrier to entry.


# TODO #

* map / filterMap
* RACScheduler
* mapReplace
* RAC_DEBUG_SIGNAL_NAMES (environment variable)
* "Hot" signal example : multiple subscribers to the same signal.
* Chaining independent operations.
* Parallel operations.



