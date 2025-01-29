import Foundation

/// Species object returned as part of the `getSpeciesDetails` endpoint
struct SpeciesDetails: Networking.Resource {
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
struct EvolutionChain: Decodable {
    let url: URL
}

struct Color: Decodable {
    let name: String?
    let url: String?
}

struct FlavorTextEntry: Decodable {
    let flavorText: String?
    let language: Color?
    let version: Color?
}

struct Genus: Decodable {
    let genus: String?
    let language: Color?
}

struct Name: Decodable {
    let language: Color?
    let name: String?
}

struct PalParkEncounter: Decodable {
    let area: Color?
    let baseScore: Int?
    let rate: Int?
}

struct PokedexNumber: Decodable {
    let entryNumber: Int?
    let pokedex: Color?
}

struct Variety: Decodable {
    let isDefault: Bool?
    let pokemon: Color?
}
