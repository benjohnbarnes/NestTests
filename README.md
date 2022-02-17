# NestTests

### What is NestTests?

NestTests supports writing **isolated** XCTests with **shared** common steps and resources. This sounds a
little contradictory, but function ["closure"](https://en.wikipedia.org/wiki/Closure_(computer_programming))
lets us do this and keep nice test writing ergonomics.

The core idea here is inspired by the [Quick](https://github.com/Quick/Quick) testing framework, but NestTests
takes a quite different approach. It uses Swift language features and its compiler to ensure correct resource
management and access, and maintain test run isolation.

### Why?

Shared test steps can be helpful for testing the behaviour of stateful units. As well as reducing repetition, 
step sharing provides meaningful grouping in tests, helping them describe themself.

### How

NestTests uses Swift's closures to:

* Create and capture state for individual paths through the tests.
* Ensure test resources are only accessible in the scope where they should be available, preventing any need to muck about with force unwraps.
* Supports sharing of state and set up among test steps while allowing a guarantee that state is **isolated** for every possible path combination.
