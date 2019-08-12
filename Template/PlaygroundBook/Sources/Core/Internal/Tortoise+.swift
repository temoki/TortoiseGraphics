import Foundation

extension Tortoise {

    static func randomName() -> String {
        return names.randomElement() ?? "Geochelone"
    }

    static let names: [String] = [
        "Aldabracheys",
        "Astrochelys",
        "Centrochelys",
        "Chelonoidis",
        "Chersina",
        "Chersobius",
        "Geochelone",
        "Gopherus",
        "Homopus",
        "Indotestudo",
        "Kinixys",
        "Malacochersus",
        "Manouria",
        "Pyxis",
        "Stigmochelys",
        "Testudo"
    ]

}
