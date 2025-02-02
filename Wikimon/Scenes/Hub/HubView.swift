import SwiftUI

struct HubView: View {
    @ObservedObject var viewModel: HubViewModel = HubViewModel(service: HubService())

    var body: some View {
        NavigationStack {
            VStack {
                LoadableContentView(
                    state: $viewModel.loadableState) {
                        Text("Loading Pokémon list")
                    }
                loaded: {
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
                failed: { error in
                    Text(error)
                }
            }
            .background(.shade0)
            .navigationTitle("Pokémon Hub")
            .onAppear {
                Task {
                    await viewModel.fetchPokemon()
                }
            }
            .sheet(item: $viewModel.speciesDetails) { species in
                SpeciesDetailsView(viewModel: SpeciesDetailsViewModel(speciesDetails: species))
            }
        }
    }
}

#Preview {
    HubView()
}
