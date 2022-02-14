import Behave
import XCTest

final class NestedTestTests: XCTestCase {

    func testNestedTest() throws {
        var log = Array<String>()

        try nestedTest("some simple test") {
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
