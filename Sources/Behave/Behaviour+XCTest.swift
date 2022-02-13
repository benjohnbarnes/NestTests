import XCTest

extension XCTestCase {
    
    public func context(_ name: String, test: @escaping () -> [Behaviour]) throws {
        let behaviour = Behaviour(name: name, behaviourFactory: test)
        try behaviour.runAllPaths()
    }
}
