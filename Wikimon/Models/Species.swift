import Foundation

/// Response from the `getSpeciesList` endpoint
struct SpeciesResponse: Networking.Resource {
    let count: Int
    let results: [Species]
}

/// Species object returned as part of the `SpeciesResponse` object from the `getSpeciesList` endpoint
struct Species: Decodable, Identifiable {
    let id = UUID()
    let name: String
    let url: URL

    enum CodingKeys: CodingKey {
        case name
        case url
    }

    var specieIdentifier: Int? {
        Int(url.lastPathComponent)
    }
}

#if DEBUG
struct MockSpecies {
    static var mock = Species(name: "bulbasaur", url: URL(string: "https://pokeapi.co/api/v2/pokemon-species/1/")!)
}
#endif
