import Foundation

struct MessageToLiveView: Codable {

    struct TortoiseMessage: Codable {
        var uuid: UUID
        var state: TortoiseState
    }

    struct CanvasMessage: Codable {
        var color: Color
    }

    struct LiveViewMessage: Codable {
    }

    enum Message {
        case tortoiseDidInitialize(TortoiseMessage)
        case tortoiseDidChangePosition(TortoiseMessage)
        case tortoiseDidChangeHeading(TortoiseMessage)
        case tortoiseDidChangePen(TortoiseMessage)
        case tortoiseDidChangeShape(TortoiseMessage)
        case tortoiseDidRequestFill(TortoiseMessage)
        case tortoiseDidRequestClear(TortoiseMessage)
        case canvadDidChangeBackgroud(CanvasMessage)
        case canvasDidRequestReset(CanvasMessage)
    }

    var message: Message

}

extension MessageToLiveView.Message: Codable {

    private enum CodingKeys: String, CodingKey, CaseIterable {
        case tortoiseDidInitialize
        case tortoiseDidChangePosition
        case tortoiseDidChangeHeading
        case tortoiseDidChangePen
        case tortoiseDidChangeShape
        case tortoiseDidRequestFill
        case tortoiseDidRequestClear
        case canvasDidChangeBackgroud
        case canvasDidRequestClear
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let tortoiseMessage = try container.decodeIfPresent(MessageToLiveView.TortoiseMessage.self, forKey: .tortoiseDidInitialize) {
            self = .tortoiseDidInitialize(tortoiseMessage)
        } else if let tortoiseMessage = try container.decodeIfPresent(MessageToLiveView.TortoiseMessage.self, forKey: .tortoiseDidChangePosition) {
            self = .tortoiseDidChangePosition(tortoiseMessage)
        } else if let tortoiseMessage = try container.decodeIfPresent(MessageToLiveView.TortoiseMessage.self, forKey: .tortoiseDidChangeHeading) {
            self = .tortoiseDidChangeHeading(tortoiseMessage)
        } else if let tortoiseMessage = try container.decodeIfPresent(MessageToLiveView.TortoiseMessage.self, forKey: .tortoiseDidChangePen) {
            self = .tortoiseDidChangePen(tortoiseMessage)
        } else if let tortoiseMessage = try container.decodeIfPresent(MessageToLiveView.TortoiseMessage.self, forKey: .tortoiseDidChangeShape) {
            self = .tortoiseDidChangeShape(tortoiseMessage)
        } else if let tortoiseMessage = try container.decodeIfPresent(MessageToLiveView.TortoiseMessage.self, forKey: .tortoiseDidRequestFill) {
            self = .tortoiseDidRequestFill(tortoiseMessage)
        } else if let tortoiseMessage = try container.decodeIfPresent(MessageToLiveView.TortoiseMessage.self, forKey: .tortoiseDidRequestClear) {
            self = .tortoiseDidRequestClear(tortoiseMessage)
        } else if let canvasMessage = try container.decodeIfPresent(MessageToLiveView.CanvasMessage.self, forKey: .canvasDidChangeBackgroud) {
            self = .canvadDidChangeBackgroud(canvasMessage)
        } else if let canvasMessage = try container.decodeIfPresent(MessageToLiveView.CanvasMessage.self, forKey: .canvasDidRequestClear) {
            self = .canvasDidRequestReset(canvasMessage)
        } else {
            throw DecodingError.dataCorrupted(.init(codingPath: CodingKeys.allCases,
                                                    debugDescription: "Does not match any CodingKey."))
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .tortoiseDidInitialize(let tortoiseMessage):
            try container.encode(tortoiseMessage, forKey: .tortoiseDidInitialize)
        case .tortoiseDidChangePosition(let tortoiseMessage):
            try container.encode(tortoiseMessage, forKey: .tortoiseDidChangePosition)
        case .tortoiseDidChangeHeading(let tortoiseMessage):
            try container.encode(tortoiseMessage, forKey: .tortoiseDidChangeHeading)
        case .tortoiseDidChangePen(let tortoiseMessage):
            try container.encode(tortoiseMessage, forKey: .tortoiseDidChangePen)
        case .tortoiseDidChangeShape(let tortoiseMessage):
            try container.encode(tortoiseMessage, forKey: .tortoiseDidChangeShape)
        case .tortoiseDidRequestFill(let tortoiseMessage):
            try container.encode(tortoiseMessage, forKey: .tortoiseDidRequestFill)
        case .tortoiseDidRequestClear(let tortoiseMessage):
            try container.encode(tortoiseMessage, forKey: .tortoiseDidRequestClear)
        case .canvadDidChangeBackgroud(let canvasMessage):
            try container.encode(canvasMessage, forKey: .canvasDidChangeBackgroud)
        case .canvasDidRequestReset(let liveViewMessage):
            try container.encode(liveViewMessage, forKey: .canvasDidRequestClear)
        }
    }

}
