import Foundation

class TortoiseCharmer {

    private(set) var tortoises: [Tortoise] = []
    private(set) var commandHistories: [(tortoiseTag: Int, commandIndex: Int)] = []

    // ⭐️ Add lock object.
    private let lock = NSLock()

    var commandedHandler: ((TortoiseCharmer) -> Void)?

    init(tortoiseCount: Int = 1) {
        initialize(tortoiseCount: tortoiseCount)
    }

    func initialize(tortoiseCount: Int = 1) {
        assert(tortoiseCount > 0)
        tortoises = []
        commandHistories = []
        for index in 0..<tortoiseCount {
            let tortoise = Tortoise()
            tortoise.tag = index
            tortoise.commandedHandler = { [unowned self] (tortoise) in
                // ⭐️ Lock while writing commandHistories.
                defer { self.lock.unlock() }
                self.lock.lock()
                self.commandHistories.append((tortoiseTag: tortoise.tag,
                                              commandIndex: tortoise.commands.count - 1))
                self.commandedHandler?(self)
            }
            tortoises.append(tortoise)
        }
    }

    @discardableResult
    func charm(with context: GraphicsContext, toFrame index: Int?) -> Int {
        // ⭐️ Lock while reading commandHistories.
        defer { self.lock.unlock() }
        self.lock.lock()

        let endIndex = commandHistories.count - 1
        let toIndex = min(max((index ?? endIndex), 0), endIndex)

        context.setup()

        var states = [State](repeating: State(), count: tortoises.count)
        for index in 0..<tortoises.count {
            states[index].canvasSize = context.size
        }

        for (index, history) in commandHistories.enumerated() where index <= toIndex {
            states[history.tortoiseTag] =
                tortoises[history.tortoiseTag]
                    .commands[history.commandIndex]
                    .exexute(in: states[history.tortoiseTag], with: context.cgContext)
        }

        for index in 0..<tortoises.count {
            let state = states[index]
            if state.isVisible {
                tortoises[index].drawTortoise(context.cgContext, state: state)
            }
        }

        context.tearDown()
        return min(toIndex + 1, endIndex)
    }

}
