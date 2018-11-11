import Foundation

class TortoiseCharmer {

    private(set) var tortoises: [Tortoise] = []
    private(set) var commandHistories: [(tortoiseTag: Int, commandIndex: Int)] = []
    private var priorCommandHistoriesCount: Int = 0
    private var commandHistoriesUnchangedCount: Int = 0

    var commandedHandler: ((TortoiseCharmer) -> Void)?

    init(tortoiseCount: Int = 1) {
        initialize(tortoiseCount: tortoiseCount)
    }

    func initialize(tortoiseCount: Int = 1) {
        assert(tortoiseCount > 0)
        tortoises = []
        commandHistories = []
        priorCommandHistoriesCount = 0
        commandHistoriesUnchangedCount = 0
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

        // Has the main thread finished adding commands to the tortoises and history?
        // In other words, have the Tortoise commands arrays stabilized?
        // (Defining "stable" as this method being called five times with unchanged counts)
        if priorCommandHistoriesCount == commandHistories.count {
            if commandHistoriesUnchangedCount < 5 {
                commandHistoriesUnchangedCount += 1
            }
        } else {
            // Command histories count changed, reset counter
            commandHistoriesUnchangedCount = 0
        }

        // Commands arrays are not being changed by other thread, so we can use them directly
        if commandHistoriesUnchangedCount == 5 {

            // If so, we can safely use the commands array on each Tortoise instance
            for (index, history) in commandHistories.enumerated() where index <= toIndex {
                states[history.tortoiseTag] =
                    tortoises[history.tortoiseTag]
                        .commands[history.commandIndex]
                        .exexute(in: states[history.tortoiseTag], with: context.cgContext)
            }

        } else {

            // Commands arrays still being changed by other thread.
            //
            // So, make a local copy of the commands array for each Tortoise instance for use in this thread
            // to avoid index out of range errors (when commands array on Tortoise instances are modified by
            // the main thread)
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

        }

        // Save the count of command histories to refer to next time this method is called
        priorCommandHistoriesCount = commandHistories.count

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
