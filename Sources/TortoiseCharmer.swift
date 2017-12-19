import Foundation

class TortoiseCharmer {

    private(set) var tortoises: [Tortoise] = []
    private(set) var commandHistories: [(tortoiseTag: Int, commandIndex: Int)] = []

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
                self.commandHistories.append((tortoiseTag: tortoise.tag,
                                              commandIndex: tortoise.commands.count - 1))
                self.commandedHandler?(self)
            }
            tortoises.append(tortoise)
        }
    }

    @discardableResult
    func charm(with context: GraphicsContext, toFrame index: Int?) -> Int {
        let endIndex = commandHistories.count - 1
        let toIndex = min(max((index ?? endIndex), 0), endIndex)

        context.setup()

        var states = [State](repeating: State(), count: tortoises.count)
        for i in 0..<tortoises.count {
            states[i].canvasSize = context.size
        }

        for (i, history) in commandHistories.enumerated() where i <= toIndex {
            states[history.tortoiseTag] =
                tortoises[history.tortoiseTag]
                    .commands[history.commandIndex]
                    .exexute(in: states[history.tortoiseTag], with: context.cgContext)
        }

        for i in 0..<tortoises.count {
            let state = states[i]
            if state.isVisible {
                tortoises[i].drawTortoise(context.cgContext, state: state)
            }
        }

        context.tearDown()
        return min(toIndex + 1, endIndex)
    }

}
