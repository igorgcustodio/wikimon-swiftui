import SwiftUI

struct HubView: View {
    @ObservedObject var viewModel: HubViewModel = HubViewModel(service: HubService())

    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(viewModel.species) { species in
                        PokemonCard(
                            species: species,
                            setImage: {
                                guard let data = await viewModel.fetchImage(for: species)
                                else { return nil }

                                return UIImage(data: data)
                            }
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
                .listStyle(PlainListStyle())
            }
            .navigationTitle("Pokémon Hub")
            .task {
                await viewModel.fetchPokemon()
            }
            .navigationDestination(item: $viewModel.speciesDetails) { species in
                SpeciesDetailsView()
            }
        }
    }
}

#Preview {
    HubView()
}
