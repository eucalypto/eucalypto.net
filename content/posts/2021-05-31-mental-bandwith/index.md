---
date: "2021-05-31"
type: "post"
image: "/posts/2021-05-31-mental-bandwith/mental-bandwidth.webp"
title: "Human Limitations: Mental Bandwidth / Capacity"
---

Since I started considering myself a professional software engineer, I started asking different questions while coding. For example:
- Does this class really need to know the internals of that other class/module?
- How can I make this class dumber, i.e. make it know less about other modules?
- Should this method/functionality really be in that class, or would it make more sense to move it into another class?

Those kinds of questions have one common goal: To _reduce the amount of details_ that **I** have to keep in mind while coding, and the same for the next person that has to maintain/extend this module.

I call it _mental bandwidth_ or _mental capacity_. We software engineers pride ourselves to be smart, but we’re still only human and the problems we face go orders of magnitudes beyond what the most intelligent human can handle in complexity.

We play with language here. When I say, this class knows those modules, what I’m actually saying is: When I work on this class, **I** need to know about those modules as well. (There are also other dimensions like independent deployability.)

All of our advanced frameworks, design patterns, principles, and processes; all of them are there because of one reason: our *human limitations*.

So my take-home message is: Let’s **embrace our human limitations** and continue to find elegant workarounds that allow us to _tackle even more complex problems_.
