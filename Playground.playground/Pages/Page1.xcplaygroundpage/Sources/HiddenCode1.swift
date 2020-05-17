import TortoiseGraphics

extension Tortoise {
    public func あいさつする() {
        speak("こんにちは！")
    }
    
    public func じこしょうかいする() {
        speak("ぼくのなまえは ほしお です。よろしくね！")
    }
    
    public func うごけ(_ まわるりょう: Double) {
        let すすむりょう = じゅんびする(まわるりょう)
        くりかえす(36) {
            まえへ(すすむりょう)
            みぎへ(まわるりょう)
        }
    }
    
    public func じゅんびする(_ value: Double) -> Double {
        let radian = value * .pi / 180.0
        let x = radius * cos(radian / 2)
        let y = radius * sin(radian / 2)
        penUp()
        setPos(-x, -y)
        penDown()
        return y * 2
    }
    
    private var radius: Double { 200 }
}


