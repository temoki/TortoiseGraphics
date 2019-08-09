import Foundation

struct MessageToLiveView: Codable {
    
    struct TortoiseMessage: Codable {
        var uuid: UUID
        var state: TortoiseState
    }
    
    struct CanvasMessage: Codable {
        var color: Color
    }
    
    enum Message {
        case initialize(TortoiseMessage)
        case changePosition(TortoiseMessage)
        case changeHeading(TortoiseMessage)
        case changePen(TortoiseMessage)
        case changeShape(TortoiseMessage)
        case requestFill(TortoiseMessage)
        case requestClear(TortoiseMessage)
        case changeBackgroud(CanvasMessage)
    }
    
    var message: Message

}

extension MessageToLiveView.Message: Codable {
    
    private enum CodingKeys: String, CodingKey, CaseIterable {
        case initialize
        case changePosition
        case changeHeading
        case changePen
        case changeShape
        case requestFill
        case requestClear
        case changeBackgroud
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let tortoiseMessage = try container.decodeIfPresent(MessageToLiveView.TortoiseMessage.self, forKey: .initialize) {
            self = .initialize(tortoiseMessage)
        } else if let tortoiseMessage = try container.decodeIfPresent(MessageToLiveView.TortoiseMessage.self, forKey: .changePosition) {
            self = .changePosition(tortoiseMessage)
        } else if let tortoiseMessage = try container.decodeIfPresent(MessageToLiveView.TortoiseMessage.self, forKey: .changeHeading) {
            self = .changeHeading(tortoiseMessage)
        } else if let tortoiseMessage = try container.decodeIfPresent(MessageToLiveView.TortoiseMessage.self, forKey: .changePen) {
            self = .changePen(tortoiseMessage)
        } else if let tortoiseMessage = try container.decodeIfPresent(MessageToLiveView.TortoiseMessage.self, forKey: .changeShape) {
            self = .changeShape(tortoiseMessage)
        } else if let tortoiseMessage = try container.decodeIfPresent(MessageToLiveView.TortoiseMessage.self, forKey: .requestFill) {
            self = .requestFill(tortoiseMessage)
        } else if let tortoiseMessage = try container.decodeIfPresent(MessageToLiveView.TortoiseMessage.self, forKey: .requestClear) {
            self = .requestClear(tortoiseMessage)
        } else if let canvasMessage = try container.decodeIfPresent(MessageToLiveView.CanvasMessage.self, forKey: .changeBackgroud) {
            self = .changeBackgroud(canvasMessage)
        } else {
            throw DecodingError.dataCorrupted(.init(codingPath: CodingKeys.allCases,
                                                    debugDescription: "Does not match any CodingKey."))
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .initialize(let tortoiseMessage):
            try container.encode(tortoiseMessage, forKey: .initialize)
        case .changePosition(let tortoiseMessage):
            try container.encode(tortoiseMessage, forKey: .changePosition)
        case .changeHeading(let tortoiseMessage):
            try container.encode(tortoiseMessage, forKey: .changeHeading)
        case .changePen(let tortoiseMessage):
            try container.encode(tortoiseMessage, forKey: .changePen)
        case .changeShape(let tortoiseMessage):
            try container.encode(tortoiseMessage, forKey: .changeShape)
        case .requestFill(let tortoiseMessage):
            try container.encode(tortoiseMessage, forKey: .requestFill)
        case .requestClear(let tortoiseMessage):
            try container.encode(tortoiseMessage, forKey: .requestClear)
        case .changeBackgroud(let canvasMessage):
            try container.encode(canvasMessage, forKey: .changeBackgroud)
        }
    }
    
}
/*
 case tortoiseDidInitialize(UUID, TortoiseState)
 case tortoiseDidChangePosition(UUID, TortoiseState)
 case tortoiseDidChangeHeading(UUID, TortoiseState)
 case tortoiseDidChangePen(UUID, TortoiseState)
 case tortoiseDidChangeShape(UUID, TortoiseState)
 case tortoiseDidRequestToFill(UUID, TortoiseState)
 case tortoiseDidRequestToClear(UUID, TortoiseState)
 case tortoiseDidAddToOtherCanvas(UUID, TortoiseState)
 case canvasDidChangeBackground(Color)
*/
