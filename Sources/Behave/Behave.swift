
public struct Behaviour {
    private let name: String
    private let behaviourFactory: () throws -> [Behaviour]
    
    init(name: String, behaviourFactory: @escaping () throws -> [Behaviour]) {
        self.name = name
        self.behaviourFactory = behaviourFactory
    }
    
    public static func context(name: String, _ body: @escaping () throws -> [Behaviour]) -> Behaviour {
        return Behaviour(name: name, behaviourFactory: body)
    }
    
    public static func leaf(name: String, _ body: @escaping () throws -> Void) -> Behaviour {
        return Behaviour(name: name, behaviourFactory: { try body(); return [] })
    }
    
    func runAllPaths() throws {
        try runAll(remakeMe: { self })
    }
    
    private func runAll(remakeMe: () throws -> Behaviour) throws {
        let children = try behaviourFactory()
        let indices = children.indices
        
        for index in indices {
            let child = (index == indices.first ? children : try remakeMe().behaviourFactory())[index]
            let remakeChild = { try remakeMe().behaviourFactory()[index] }
            try child.runAll(remakeMe: remakeChild)
        }
    }
}
