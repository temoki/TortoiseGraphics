import Foundation

protocol TortoiseDelegate: class {

    func tortoiseDidInitialized(_ state: TortoiseState)

    func tortoiseDidChangePosition(_ state: TortoiseState)

    func tortoiseDidChangeHeading(_ state: TortoiseState)

    func tortoiseDidChangePen(_ state: TortoiseState)

    func tortoiseDidChangeShape(_ state: TortoiseState)

    func tortoiseDidRequestToFill(_ state: TortoiseState)

    func tortoiseDidRequestToClear(_ state: TortoiseState)

}
