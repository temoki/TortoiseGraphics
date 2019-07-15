import CoreGraphics

class CommandHome: Command {

    let setPosition = CommandSetPosition(position: .zero)
    let setHeading = CommandSetHeading(heading: 0)

    func test(in state: State) -> State {
        let newState = setPosition.test(in: state)
        return setHeading.test(in: newState)
    }

    func exexute(in state: State, with context: CGContext) -> State {
        let newState = setPosition.exexute(in: state, with: context)
        return setHeading.exexute(in: newState, with: context)
    }

}
