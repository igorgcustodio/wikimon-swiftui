import Foundation

/// EvolutionChain model returned from the `getEvolutionChain` endpoint
struct EvolutionChainDetails: Decodable, Networking.Resource {
    let chain: ChainLink
}

/// ChainLink model returned as part of the EvolutionChainDetails from the `getEvolutionChain` endpoint
struct ChainLink: Decodable {
    let species: Species
    let evolvesTo: [ChainLink]
}
