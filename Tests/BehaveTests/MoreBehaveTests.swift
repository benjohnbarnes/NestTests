import Behave
import XCTest

final class MoreBehaveTests: XCTestCase {

    func testHowATestMightGetWritten() throws {
        try context("root") {
            var events = Array<String>()
            events.append("root")
            
            return [
                .context(name: "n1", {
                    events.append("n1")
                    
                    return [
                        .leaf(name: "l11", {
                            events.append("l11")
                            XCTAssertEqual(events, ["root", "n1", "l11"])
                        }),
                        .leaf(name: "l12", {
                            events.append("l12")
                            XCTAssertEqual(events, ["root", "n1", "l12"])
                        })
                    ]
                }),
                .context(name: "n2", {
                    events.append("n2")
                    
                    return [
                        .leaf(name: "l21", {
                            events.append("l21")
                            XCTAssertEqual(events, ["root", "n2", "l21"])
                        }),
                        .leaf(name: "l22", {
                            events.append("l22")
                            XCTAssertEqual(events, ["root", "n2", "l22"])
                        })
                    ]
                })
            ]
        }
    }
    
    func testWithoutTestableImport() throws {
        // You are not expected to have state outside of the test.
        var log = Array<String>()
        
        try context("root") {
            log.append("root")
            
            return [
                .context(name: "nest1", {
                    log.append("nest1")
                                        
                    return [
                        .leaf(name: "l11", {
                            log.append("l11")
                        }),
                        .leaf(name: "l12", {
                            log.append("l12")
                        })
                    ]
                }),
                .context(name: "nest2", {
                    log.append("nest2")
                    
                    return [
                        .leaf(name: "l21", {
                            log.append("l21")
                        }),
                        .leaf(name: "l22", {
                            log.append("l22")
                        })
                    ]
                })
            ]
        }
        
        XCTAssertEqual(log, [
            "root", "nest1", "l11",
            "root", "nest1", "l12",
            "root", "nest2", "l21",
            "root", "nest2", "l22"
        ])
    }
}
