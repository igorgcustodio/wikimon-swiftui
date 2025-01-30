import SwiftUI

struct SpeciesDetailsView: View {
    @ObservedObject var viewModel: SpeciesDetailsViewModel = SpeciesDetailsViewModel()
    
    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .fill(.mint)
                    .frame(height: 300)

                Image("bulbasaur")
                    .resizable()
                    .frame(width: 200, height: 200, alignment: .center)

                VStack {
                    Spacer()

                    Text("Bulbasaur")
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

                PokemonCard(species: MockSpecies.mock) {
                    UIImage(named: "bulbasaur")
                }
            }
            .frame(height: 100)

            Spacer()
        }
        .background(.shade0)
        .ignoresSafeArea()
    }
}

#Preview {
    SpeciesDetailsView()
}
