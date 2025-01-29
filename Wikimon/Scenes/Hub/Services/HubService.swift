import Foundation

final class HubService: NetworkingService<HubRoutes> {

    init() {
        super.init(baseUrl: KeyConfig.baseURL)
    }

    func getPokemons(page: Int = 0) async throws -> SpeciesResponse {
        return try await request(.hub(page: page))
    }

    func getPokemonsDetails(for url: String) async throws -> SpeciesDetails {
        return try await request(.generic(url: url))
    }

    func getImage(for id: Int) async throws -> Data? {
        return try await request(.image(id: id))
    }
}
