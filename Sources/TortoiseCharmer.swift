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
        for index in 0..<tortoises.count {
            states[index].canvasSize = context.size
        }

        // Make a copy of the array of commands for each Tortoise
        var commandsToRun = [ Int: [Command] ]()
        for (index, tortoise) in tortoises.enumerated() {
            commandsToRun[index] = tortoise.commands
        }

        // Now iterate over all the commands in the command history and run
        // using the copy of commands for each tortoise (saved a moment ago)
        for (index, history) in commandHistories.enumerated() where index <= toIndex {

            // Get commands out of the dictionary for the current tortoise
            if let commands = commandsToRun[history.tortoiseTag] {

                // Actually run the command at the given index
                states[history.tortoiseTag] = commands[history.commandIndex]
                    .exexute(in: states[history.tortoiseTag], with: context.cgContext)

            }
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
