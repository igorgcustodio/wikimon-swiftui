import Foundation

final class SpeciesDetailsService: NetworkingService<GetUrlRoute> {
    func getEvolutionChain(on url: String) async throws -> EvolutionChainDetails {
        return try await request(GetUrlRoute(path: url))
    }
}
