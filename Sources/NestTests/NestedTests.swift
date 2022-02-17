
/// A group of tests that should run in isolation from each other, but which capture shared resources.
public struct NestedTests {
    
    let tests: [NestedTest]

    private init(tests: [NestedTest] = []) {
        self.tests = tests
    }
    
    /// A test step with further nested test steps.
    public static func when(_ description: String, _ body: @escaping () throws -> NestedTests) -> NestedTests {
        NestedTests().when(description, body)
    }
    
    /// A test step with no further nested steps.
    public static func then(_ description: String, _ body: @escaping () throws -> Void) -> NestedTests {
        NestedTests().then(description, body)
    }
    
    /// A test step with further nested test steps.
    public func when(_ description: String, _ body: @escaping () throws -> NestedTests) -> NestedTests {
        let test = NestedTest(description: description, testFactory: body)
        return NestedTests(tests: tests + [test])
    }
    
    /// A test step with no further nested steps.
    public func then(_ description: String, _ body: @escaping () throws -> Void) -> NestedTests {
        let test = NestedTest(description: description) { try body(); return NestedTests() }
        return NestedTests(tests: tests + [test])
    }
}

