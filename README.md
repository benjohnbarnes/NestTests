# NestTests

### What is it?

NestTests supports writing **isolated** XCTests with shared common steps.

### Why?

The shared steps that NestTests supports are helpful for testing the behaviour of stateful systems. As well 
as reducing repetition, step sharing provides meaningful grouping in tests that help them describe themself.

### Inspiration

The core idea in NestTests is inspired by the Quick testing framework but it takes a very different approach.
NestTest relies on Swift's first class functions and their capacity closure and capture of state. By using
this facility tests can be written in a fluid and natural way.
