import NestTests
import XCTest

final class NestedTestTests: XCTestCase {

    func testNestedTestsRunInIsolation() throws {
        try nestTests("Nested tests run in isolation") {
            var events = Array<String>()
            events.append("root")
            
            return .nest("Nest 1") {
                events.append("nest1")
                
                return .leaf("Leaf 1 1") {
                    events.append("leaf11")
                    XCTAssertEqual(events, ["root", "nest1", "leaf11"])
                }
                .leaf("Leaf 1 2") {
                    events.append("leaf12")
                    XCTAssertEqual(events, ["root", "nest1", "leaf12"])
                }
            }
            .nest("Nest 2") {
                events.append("nest2")
                
                return .leaf("Leaf 2 1") {
                    events.append("leaf21")
                    XCTAssertEqual(events, ["root", "nest2", "leaf21"])
                }
                .leaf("Leaf 2 2") {
                    events.append("leaf22")
                    XCTAssertEqual(events, ["root", "nest2", "leaf22"])
                }
            }
        }
    }

    func testAllNestedTestsAreRun() throws {
        
        // You must avoid a test using state that is declared outside of `nestTests` because NestTests
        // can't provide isolation of such state between tests.
        //
        // This is a test of `nestTests` itself, for which external state needs to be used.
        //
        var leafLog = Array<String>()

        try nestTests("all nested tests are run") {
            .nest("nest1") {
                .leaf("leaf11") { leafLog.append("leaf11") }
                .leaf("leaf12") { leafLog.append("leaf12") }
            }
            .nest("nest 2") {
                .leaf("leaf21") { leafLog.append("leaf21") }
                .leaf("leaf22") { leafLog.append("leaf22") }
            }
        }
        
        XCTAssertEqual(leafLog, ["leaf11", "leaf12", "leaf21", "leaf22"])
    }
}
