public protocol Canvas {

    func drawing(drawingBlock: @escaping (Tortoise) -> Void)

    func drawingWithTortoises(count: Int, drawingBlock: @escaping ([Tortoise]) -> Void)

    var color: Color? {get set}

}
