import TortoiseGraphics
import PlaygroundSupport

public typealias すうじ = Double

public func かめをよぶ() -> Tortoise {
    let size = CGSize(width: 800, height: 800)
    let liveView = PlaygroundCanvasLiveView(size: size)
    PlaygroundPage.current.liveView = liveView
    let tortoise = Tortoise()
    liveView.canvas.add(tortoise)
    tortoise.penSize(5)
    return tortoise
}

public func speak(_ message: String) {
    print("🐢「\(message)」")
}

extension Tortoise {
    
    public func くりかえす(_ かいすう: Int, _ block: (()->Void)) {
        self.repeat(かいすう, block)
    }
    public func `repeat`(_ number: Int, _ block: (()->Void)) {
        guard number > 0 else { return }
        for _ in (0..<number) {
            block()
        }
    }
    
    public func じゅんびする(_ まわるりょう: すうじ) -> すうじ {
        let radian = まわるりょう * .pi / 180.0
        let x = radius * cos(radian / 2)
        let y = radius * sin(radian / 2)
        penUp()
        setPos(-x, -y)
        penDown()
        return y * 2
    }
    
    private var radius: Double { 200 }
    
}

