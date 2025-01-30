import Foundation

/// Species object returned as part of the `getSpeciesDetails` endpoint
struct SpeciesDetails: Networking.Resource, Hashable {
    let baseHappiness: Int?
    let captureRate: Int?
    let color: Color?
    let eggGroups: [Color]?
    let evolutionChain: EvolutionChain?
    let evolvesFromSpecies: Color?
    let flavorTextEntries: [FlavorTextEntry]?
    let formsSwitchable: Bool?
    let genderRate: Int?
    let genera: [Genus]?
    let generation: Color?
    let growthRate: Color?
    let habitat: Color?
    let hasGenderDifferences: Bool?
    let hatchCounter: Int?
    let id: Int?
    let isBaby: Bool?
    let isLegendary: Bool?
    let isMythical: Bool?
    let name: String?
    let names: [Name]?
    let order: Int?
    let palParkEncounters: [PalParkEncounter]?
    let pokedexNumbers: [PokedexNumber]?
    let shape: Color?
    let varieties: [Variety]?
}

/// EvolutionChain model returned as part of the SpeciesDetails from the `getSpecies` endpoint
struct EvolutionChain: Decodable, Hashable {
    let url: URL
}

struct Color: Decodable, Hashable {
    let name: String?
    let url: String?
}

struct FlavorTextEntry: Decodable, Hashable {
    let flavorText: String?
    let language: Color?
    let version: Color?
}

struct Genus: Decodable, Hashable {
    let genus: String?
    let language: Color?
}

struct Name: Decodable, Hashable {
    let language: Color?
    let name: String?
}

struct PalParkEncounter: Decodable, Hashable {
    let area: Color?
    let baseScore: Int?
    let rate: Int?
}

struct PokedexNumber: Decodable, Hashable {
    let entryNumber: Int?
    let pokedex: Color?
}

struct Variety: Decodable, Hashable {
    let isDefault: Bool?
    let pokemon: Color?
}
