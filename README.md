# RACTesting #

The goals of this repository are:

* Teach functional reactive programming (FRP) and Reactive Cocoa thru examples.

* Be a "cookbook" of examples for you to use as a reference.


## Functional Reactive Programming #

Program inputs come in all different forms (touch events, timers, network
events, etc). We use state to combine various inputs and produce outputs.

State is bad. Rather than relying on state between input and output, FRP
allows you to establish relationships between inputs and outputs. When 
input changes, output changes.

Functional Reactive Programming allows you to establish relationships between
input and output. For example, when a boolean value changes, a UI button is 
enabled or disabled. Establishing relationships allows us to avoid keeping
interim state between the input and output.

