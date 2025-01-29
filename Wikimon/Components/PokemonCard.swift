import SwiftUI

struct PokemonCard: View {
    let species: Species
    @State var image: UIImage?
    var setImage: () async -> UIImage?

    var body: some View {
        ZStack {
            HStack {
                if let image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                } else {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding()
                        .frame(width: 40, height: 40)
                }
                Text(species.name.capitalized)
                    .font(.headline)

                Spacer()
            }
        }
        .frame(height: 50, alignment: .center)
        .task {
            image = await setImage()
        }
    }
}

#Preview {
    PokemonCard(
        species: MockSpecies.mock,
        setImage: {
            UIImage(systemName: "plus")
        }
    )
}
