import Foundation

struct MessageToRemote: Codable {

    enum Message {
        case canvasSize(Vec2D)
        case canvasColor(Color)
    }

    var message: Message

}

extension MessageToRemote.Message: Codable {

    private enum CodingKeys: String, CodingKey, CaseIterable {
        case canvasSize
        case canvasColor
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let value = try container.decodeIfPresent(Vec2D.self, forKey: .canvasSize) {
            self = .canvasSize(value)
        } else if let value = try container.decodeIfPresent(Color.self, forKey: .canvasColor) {
            self = .canvasColor(value)
        } else {
            throw DecodingError.dataCorrupted(.init(codingPath: CodingKeys.allCases,
                                                    debugDescription: "Does not match any CodingKey."))
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .canvasSize(let value):
            try container.encode(value, forKey: .canvasSize)
        case .canvasColor(let value):
            try container.encode(value, forKey: .canvasColor)
        }
    }

}
