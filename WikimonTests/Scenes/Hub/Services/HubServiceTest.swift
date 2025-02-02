import Testing
@testable import Wikimon

struct HubServiceTest {
    private let service: HubService
    private let mockSession: MockURLSession

    init() {
        self.mockSession = MockURLSession()
        self.service = HubService(urlSession: mockSession)
    }

    @Test func getPokemons() async throws {
        let json = """
        {
            "results": [
                { "name": "bulbasaur", "url": "https://pokeapi.co/api/v2/pokemon-species/1/" }
            ]
        }
        """.data(using: .utf8)!

        mockSession.mockData = json

        let response = try await service.getPokemons(page: 0)

        #expect(response.results.first?.name == "bulbasaur")
    }
}
