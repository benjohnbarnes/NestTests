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
                let child = (index == indices.first ? children : try remakeMe().testFactory().tests)[index]
                let remakeChild = { try remakeMe().testFactory().tests[index] }
                try child.runAll(remakeMe: remakeChild)
            }
        }
    }
}
