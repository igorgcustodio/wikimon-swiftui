import SwiftUI

struct HubView: View {
    @ObservedObject var viewModel: HubViewModel = HubViewModel(service: HubService())

    var body: some View {
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
                        .onAppear {
                            Task {
                                if viewModel.species.last?.id == species.id {
                                    await viewModel.fetchPokemon()
                                }
                            }
                        }
                        .onTapGesture {
                            Task {
                                await viewModel.fetchDetails(for: species)
                            }
                        }
                }
            }
        }
        .padding()
        .task {
            await viewModel.fetchPokemon()
        }
    }
}

#Preview {
    HubView()
}
