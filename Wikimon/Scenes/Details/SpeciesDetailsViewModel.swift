import Foundation

final class SpeciesDetailsViewModel: ObservableObject {
    @Published var speciesDetails: SpeciesDetails

    private let service: SpeciesDetailsService
    private var evolutionChain: EvolutionChainDetails?

    init(
        speciesDetails: SpeciesDetails,
        service: SpeciesDetailsService = SpeciesDetailsService()
    ) {
        self.speciesDetails = speciesDetails
        self.service = service
    }

    @MainActor
    func fetchEvolutionChain() async {
        print(speciesDetails.evolutionChain)
        guard let evolutionChainUrl = speciesDetails.evolutionChain?.url?.absoluteString else {
            print("No evolution chain")
            return
        }

        do {
            evolutionChain = try await service.getEvolutionChain(on: evolutionChainUrl)
            print(evolutionChain)
        } catch {
            print(error)
        }
    }
}
