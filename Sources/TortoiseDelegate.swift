import Foundation

protocol TortoiseDelegate: class {

    func tortoiseDidInitialized(_ uuid: UUID, _ state: TortoiseState)

    func tortoiseDidChangePosition(_ uuid: UUID, _ state: TortoiseState)

    func tortoiseDidChangeHeading(_ uuid: UUID, _ state: TortoiseState)

    func tortoiseDidChangePen(_ uuid: UUID, _ state: TortoiseState)

    func tortoiseDidChangeShape(_ uuid: UUID, _ state: TortoiseState)

    func tortoiseDidRequestToFill(_ uuid: UUID, _ state: TortoiseState)

    func tortoiseDidRequestToClear(_ uuid: UUID, _ state: TortoiseState)

    func tortoiseDidAddToOtherCanvas(_ uuid: UUID, _ state: TortoiseState)

}
