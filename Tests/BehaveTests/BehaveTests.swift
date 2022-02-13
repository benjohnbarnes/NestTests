import XCTest
@testable import Behave

final class BehaveTests: XCTestCase {
    
    func testBehaviourFactoryIsRun() throws {
        
        var events = Array<Int>()

        let behaviour = Behaviour(name: "a test") {
            events.append(1)
            return []
        }
        
        try behaviour.runAllPaths()
        
        XCTAssertEqual(events, [1])
    }
    
    func testBehaviourTreeIsRun() throws {
        
        var events = Array<Int>()

        let behaviour = Behaviour(name: "a test") {
            events.append(1)
            return [
                Behaviour(name: "1", behaviourFactory: {
                    events.append(2)
                    return []
                }),
                Behaviour(name: "2", behaviourFactory: {
                    events.append(3)
                    return []
                })
            ]
        }
        
        try behaviour.runAllPaths()
        
        XCTAssertEqual(events, [1, 2, 1, 3])
    }
}
