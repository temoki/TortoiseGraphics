import CoreGraphics

protocol Command {

    func test(in state: State) -> State

    func exexute(in state: State, with context: CGContext) -> State

}
