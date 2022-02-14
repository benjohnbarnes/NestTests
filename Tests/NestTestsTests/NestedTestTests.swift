import NestTests
import XCTest

final class NestedTestTests: XCTestCase {

    func testNestedTestsRunInIsolation() throws {

        try nestTests("Nested tests should run in isolation") {

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
        var log = Array<String>()

        try nestTests("all nested tests are run") {
            log.append("root")
            
            return .nest("nest1") {
                log.append("nest1")
                
                return .leaf("leaf11") {
                    log.append("leaf11")
                }
                .leaf("leaf12") {
                    log.append("leaf12")
                }
            }
            .nest("nest 2") {
                log.append("nest2")
                
                return .leaf("leaf21") {
                    log.append("leaf21")
                }
                .leaf("leaf22") {
                    log.append("leaf22")
                }
            }
        }
        
        XCTAssertEqual(log, [
            "root", "nest1", "leaf11",
            "root", "nest1", "leaf12",
            "root", "nest2", "leaf21",
            "root", "nest2", "leaf22",
        ])
    }
}
