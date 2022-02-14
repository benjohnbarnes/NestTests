
import XCTest

extension XCTestCase {

    public func nestTests(_ description: String, _ body: @escaping () throws -> NestedTests) throws {
        let test = NestedTest(description: description, testFactory: body)
        try test.runAllPaths()
    }
}
