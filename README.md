# NestTests

### What is NestTests?

NestTests supports writing **isolated** XCTests with **shared** common steps and resources. While these 
perhaps seem contradictory claims, they can be readily achieved with pretty decent ergonomics.

### Why?

Shared test steps and resources are helpful for testing the behaviour of stateful systems. As well as reducing
repetition, step sharing provides meaningful grouping in tests, helping them to describe themself.

### Inspiration

The core idea here is inspired by the [Quick](https://github.com/Quick/Quick) testing framework, but NestTests
takes a quite different approach.

NestTests relies on Swift's first class functions and their capacity to close over and capture state. By using
this facility, tests can be written in a fluid and natural way, while guaranteeing they run in isolation.
