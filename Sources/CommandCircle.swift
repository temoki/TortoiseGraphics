import CoreGraphics

class CommandCircle: Command {

    private let radius: CGFloat
    private let extent: CGFloat
    private let steps: Int
    private let commandRight1: CommandRight
    private let commandRightN: CommandRight
    private let commandForward: CommandForward

    init(radius: CGFloat, extent: CGFloat = 360, steps: Int = 0) {
        // Radius
        self.radius = radius

        // Extent
        self.extent = max(-360, min(extent, 360))

        // Step
        let arcLength = radius * Degree(abs(self.extent)).radian.value
        let justSteps = max(Int(arcLength / 3), 1)
        self.steps = steps <= 0 ? justSteps : min(steps, justSteps)

        // Commands
        let baseAngle = (180 - self.extent / CGFloat(self.steps)) * 0.5
        let leftAngle1 = 90 - baseAngle
        let leftAngleN = 2 * leftAngle1
        let distance = 2 * radius * cos(Degree(baseAngle).radian.value)
        self.commandRight1 = CommandRight(angle: -leftAngle1)
        self.commandRightN = CommandRight(angle: -leftAngleN)
        self.commandForward = CommandForward(distance: distance)
    }

    func test(in state: State) -> State {
        var newState = state
        for i in 1 ... self.steps {
            let commandRight = i == 1 ? commandRight1 : commandRightN
            newState = commandRight.test(in: newState)
            newState = commandForward.test(in: newState)
        }
        return commandRight1.test(in: newState)
    }

    func exexute(in state: State, with context: CGContext) -> State {
        var newState = state
        for i in 1 ... self.steps {
            let commandRight = i == 1 ? commandRight1 : commandRightN
            newState = commandRight.exexute(in: newState, with: context)
            newState = commandForward.exexute(in: newState, with: context)
        }
        return commandRight1.exexute(in: newState, with: context)
    }

}
