import SwiftUI

final class SpeciesDetailsViewModel: ObservableObject {
    @Published var evolutionSpecies: [Species] = []

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
            print("No evolution chain available")
            return
        }

        do {
            let evolution = try await service.getEvolutionChain(on: evolutionChainUrl)
            evolutionSpecies = evolution.chain.allSpecies()
        } catch {
            print(error)
        }
    }
}
