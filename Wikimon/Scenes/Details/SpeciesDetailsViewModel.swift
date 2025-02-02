import SwiftUI

final class SpeciesDetailsViewModel: ObservableObject {
    @Published var evolutionSpecies: [Species] = []
    @Published var loadableState: LoadableContentViewState = .loading

    let speciesDetails: SpeciesDetails
    private let service: SpeciesDetailsService

    init(
        speciesDetails: SpeciesDetails,
        service: SpeciesDetailsService = SpeciesDetailsService()
    ) {
        self.speciesDetails = speciesDetails
        self.service = service
    }

    @MainActor
    func fetchEvolutionChain() async {
        guard let evolutionChainUrl = speciesDetails.evolutionChain?.url else {
            loadableState = .failed("No evolution chain available for this species")
            return
        }

        do {
            let evolution = try await service.getEvolutionChain(on: evolutionChainUrl)
            evolutionSpecies = evolution.chain.allSpecies()
            loadableState = .loaded
        } catch {
            loadableState = .failed("Failed to fetch evolution chain")
        }
    }
}
