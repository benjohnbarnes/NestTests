
import XCTest

extension XCTestCase {

    /// Declare a test with nesting. The `NestedTests` returned from `body` will run in isolation from
    /// each other.
    public func nestTests(_ description: String, _ body: @escaping () throws -> NestedTests) throws {
        let test = NestedTest(description: description, testFactory: body)
        try test.runAllPaths()
    }
}
