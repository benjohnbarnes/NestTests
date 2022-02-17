# NestTests

### What is NestTests?

NestTests supports writing **isolated** XCTests with **shared** common steps and resources. This sounds a
little contradictory, but function ["closure"](https://en.wikipedia.org/wiki/Closure_(computer_programming))
let us do this and still have good ergonomics.

The core idea here is inspired by the [Quick](https://github.com/Quick/Quick) testing framework, but NestTests
takes a quite different approach.

### Why?

Shared test steps and resources can be helpful for testing the behaviour of stateful units. As well as 
reducing repetition, step sharing provides meaningful grouping in tests, helping them to describe themself.

### How

NestTests uses Swift's closures to:

* Create and capture state for individual paths through the tests.
* Ensure test resources are only accessible when they should be accessible.
* Support sharing of state among test steps.
* Allow tests to run in isolation.

