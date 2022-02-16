import XCTest

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
                func remakeChild() throws -> NestedTest { try remakeMe().testFactory().tests[index] }
                let child = (index == indices.first) ? children[index] : try remakeChild()
                try child.runAll(remakeMe: remakeChild)
            }
        }
    }
}
