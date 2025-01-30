import Foundation

/// Species object returned as part of the `getSpeciesDetails` endpoint
struct SpeciesDetails: Networking.Resource, Hashable {
    let evolutionChain: EvolutionChain?
    let id: Int?
    let isBaby: Bool?
    let name: String?

    enum CodingKeys: String, CodingKey {
        case evolutionChain = "evolution_chain"
        case id
        case isBaby = "is_baby"
        case name
    }

    var imageUrl: String? {
        guard let id
        else { return nil }
        return "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id).png"
    }
}

/// EvolutionChain model returned as part of the SpeciesDetails from the `getSpecies` endpoint
struct EvolutionChain: Decodable, Hashable {
    let url: String?
}

#if DEBUG
enum MockSpeciesDetails {
    static var speciesDetails: SpeciesDetails {
        SpeciesDetails(
            evolutionChain: EvolutionChain(url: "https://pokeapi.co/api/v2/evolution-chain/1"),
            id: 2,
            isBaby: true,
            name: "Bulbasaur"
        )
    }
}
#endif
