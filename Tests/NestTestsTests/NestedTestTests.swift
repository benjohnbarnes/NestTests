import NestTests
import XCTest

final class NestedTestTests: XCTestCase {

    func testNestedTestsRunInIsolation() throws {

        try nestTests("Nested tests run in isolation") {
            
            var events = Array<String>()
            events.append("root")
            
            return .context("message11 is appended") {
                events.append("message11")
                
                return .context("message21 is appended") {
                    events.append("message21")

                    return .then("messages are [root, message11, message21]") {
                        XCTAssertEqual(events, ["root", "message11", "message21"])
                    }
                }
                .context("message22 is appended") {
                    events.append("message22")
                    
                    return .then("messages are [root, message11, message22]") {
                        XCTAssertEqual(events, ["root", "message11", "message22"])
                    }
                }
            }
            .context("message21 is appended") {
                events.append("message21")
                
                return .then("messages are [root, message21") {
                    XCTAssertEqual(events, ["root", "message21"])
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
            .context("nest1") {
                .then("leaf11") { leafLog.append("leaf11") }
                .then("leaf12") { leafLog.append("leaf12") }
            }
            .context("nest 2") {
                .then("leaf21") { leafLog.append("leaf21") }
                .then("leaf22") { leafLog.append("leaf22") }
            }
        }
        
        XCTAssertEqual(leafLog, ["leaf11", "leaf12", "leaf21", "leaf22"])
    }
}


