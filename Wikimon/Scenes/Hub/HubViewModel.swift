import Foundation

final class HubViewModel: ObservableObject {
    @Published var species: [Species] = []
    @Published var speciesDetails: SpeciesDetails?
    @Published var loadableState: LoadableContentViewState = .loading

    private let service: HubService
    private var count = 0
    private var currentIndex = 0
    private let offset = 20 // hard-coded offset

    init(service: HubService) {
        self.service = service
    }

    @MainActor
    func fetchPokemon() async {
        do {
            if currentIndex != 0, currentIndex * offset >= count { return }
            let response = try await service.getPokemons(page: currentIndex)
            count = response.count
            species.append(contentsOf: response.results)
            currentIndex += 1
            loadableState = .loaded
        } catch {
            loadableState = .failed("Failed to fetch Pokemon list")
        }
    }

    @MainActor
    func fetchDetails(for species: Species) async {
        do {
            loadableState = .loading
            speciesDetails = try await service.getPokemonsDetails(for: species.url.absoluteString)
            loadableState = .loaded
        } catch {
            loadableState = .loaded // We still want to see the Pokemon list
        }
    }
}
