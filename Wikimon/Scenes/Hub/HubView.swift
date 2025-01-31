import SwiftUI

struct HubView: View {
    @ObservedObject var viewModel: HubViewModel = HubViewModel(service: HubService())

    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(viewModel.species) { species in
                        PokemonCard(
                            species: species
                        )
                        .onTapGesture {
                            Task {
                                await viewModel.fetchDetails(for: species)
                            }
                        }
                        .onAppear {
                            Task {
                                if viewModel.species.last?.id == species.id {
                                    await viewModel.fetchPokemon()
                                }
                            }
                        }
                    }
                }
            }
            .background(.shade0)
            .navigationTitle("Pokémon Hub")
            .onAppear {
                Task {
                    await viewModel.fetchPokemon()
                }
            }
            .navigationDestination(item: $viewModel.speciesDetails) { species in
                SpeciesDetailsView(viewModel: SpeciesDetailsViewModel(speciesDetails: species))
            }
        }
    }
}

#Preview {
    HubView()
}
