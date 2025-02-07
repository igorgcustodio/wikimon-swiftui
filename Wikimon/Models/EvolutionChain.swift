import Foundation

/// EvolutionChain model returned from the `getEvolutionChain` endpoint
struct EvolutionChainDetails: Networking.Resource {
    let chain: ChainLink
}

/// ChainLink model returned as part of the EvolutionChainDetails from the `getEvolutionChain` endpoint
struct ChainLink: Decodable {
    let evolvesTo: [ChainLink]?
    let isBaby: Bool?
    let species: Species?

    enum CodingKeys: String, CodingKey {
        case evolvesTo = "evolves_to"
        case isBaby = "is_baby"
        case species
    }

    func allSpecies() -> [Species] {
        var speciesList: [Species] = []

        if let species = species {
            speciesList.append(species)
        }

        if let evolvesTo = evolvesTo?.first {
            speciesList.append(contentsOf: evolvesTo.allSpecies())
        }

        return speciesList
    }
}
