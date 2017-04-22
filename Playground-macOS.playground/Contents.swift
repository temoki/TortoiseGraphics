import PlaygroundSupport
import TortoiseGraphics
import CoreGraphics

let view = CanvasView(canvasSize: CGSize(width: 300, height: 300))
PlaygroundPage.current.liveView = view

view.canvas.🐢
    .setRGB(0, [0.8, 0.8, 0.8])
    .make("color", 0)
    .repeat(12) { $0
        .setPenWidth(2)
        .right(15)
        .repeat(6) { $0
            .setPenColor { $0.penColor + 1 }
            .forward(50)
            .right(60)
        }
        .setPenWidth(1)
        .right(15)
        .repeat(6) { $0
            .make("color") { $0["color"] + 1 }
            .setPenColor { $0["color"] }
            .forward(20)
            .right(60)
        }
    }
    .setPenColor(1)
    .home()

//view.draw()
view.animate(atTimeInterval: 0.1) {
    print("FINISHED")
}
