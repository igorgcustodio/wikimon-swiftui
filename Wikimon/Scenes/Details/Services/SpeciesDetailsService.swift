import Foundation

final class SpeciesDetailsService: NetworkingService<SpeciesDetailsRoutes> {
    func getEvolutionChain(on url: String) async throws -> EvolutionChainDetails {
        return try await request(.generic(url: url))
    }
}
