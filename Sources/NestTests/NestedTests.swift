
public struct NestedTests {
    let tests: [NestedTest]

    private init(tests: [NestedTest] = []) {
        self.tests = tests
    }
    
    public static func nest(_ description: String, _ body: @escaping () throws -> NestedTests) -> NestedTests {
        NestedTests().nest(description, body)
    }
    
    public static func leaf(_ description: String, _ body: @escaping () throws -> Void) -> NestedTests {
        NestedTests().leaf(description, body)
    }
    
    public func nest(_ description: String, _ body: @escaping () throws -> NestedTests) -> NestedTests {
        let test = NestedTest(description: description, testFactory: body)
        return NestedTests(tests: tests + [test])
    }
    
    public func leaf(_ description: String, _ body: @escaping () throws -> Void) -> NestedTests {
        let test = NestedTest(description: description) { try body(); return NestedTests() }
        return NestedTests(tests: tests + [test])
    }
}

