import SwiftUI

struct SpeciesDetailsView: View {
    @ObservedObject var viewModel: SpeciesDetailsViewModel
    
    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .fill(.mint)
                    .frame(height: 300)

                LoadableImageView(
                    imageURL: viewModel.speciesDetails.imageUrl,
                    imageSize: 200
                )

                VStack {
                    Spacer()

                    Text(viewModel.speciesDetails.name?.capitalized ?? "Invalid name")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding()
                        .foregroundStyle(.white)
                }
            }
            .background(ignoresSafeAreaEdges: .top)
            .frame(height: 300, alignment: .top)

            Text("Evolution chain")
                .font(.title2)
                .padding()
                .foregroundStyle(.black)

            ZStack {
                Rectangle()
                    .fill(.shade1)

                if !viewModel.evolutionSpecies.isEmpty {
                    List {
                        ForEach(viewModel.evolutionSpecies) { species in
                            PokemonCard(species: species)
                        }
                    }
                } else {
                    Text("No Evolution Chain available")
                        .font(.body)
                        .padding()
                        .foregroundStyle(.black)
                }
            }
            .frame(height: 100)

            Spacer()
        }
        .background(.shade0)
        .ignoresSafeArea()
        .onAppear {
            Task {
                await viewModel.fetchEvolutionChain()
            }
        }
    }
}

#Preview {
    SpeciesDetailsView(
        viewModel: SpeciesDetailsViewModel(speciesDetails: MockSpeciesDetails.speciesDetails)
    )
}
