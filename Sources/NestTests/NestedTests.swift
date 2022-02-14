
import XCTest

extension XCTestCase {

    public func nestTests(_ description: String, _ body: @escaping () throws -> NestedTests) throws {
        let test = NestedTest(description: description, testFactory: body)
        try test.runAllPaths()
    }
}

// MARK: -

struct NestedTest {
    private let description: String
    private let testFactory: () throws -> NestedTests
    
    init(description: String, testFactory: @escaping () throws -> NestedTests) {
        self.description = description
        self.testFactory = testFactory
    }
    
    func runAllPaths() throws {
        try runAll(remakeMe: { self })
    }
    
    private func runAll(remakeMe: () throws -> NestedTest) throws {
        try XCTContext.runActivity(named: description) { _ in
            let children = try testFactory().tests
            let indices = children.indices
            
            for index in indices {
                let child = (index == indices.first ? children : try remakeMe().testFactory().tests)[index]
                let remakeChild = { try remakeMe().testFactory().tests[index] }
                try child.runAll(remakeMe: remakeChild)
            }
        }
    }
}

// MARK: -

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
