import Foundation

final class HubService: NetworkingService<HubRoutes> {
    func getPokemons(page: Int = 0) async throws -> SpeciesResponse {
        return try await request(.hub(page: page))
    }

    func getPokemonsDetails(for url: String) async throws -> SpeciesDetails {
        return try await request(.generic(url: url))
    }
}
