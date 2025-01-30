import SwiftUI

struct PokemonCard: View {
    let species: Species

    var body: some View {
        ZStack {
            HStack {
                LoadableImageView(imageURL: species.imageUrl)
                Text(species.name.capitalized)
                    .font(.headline)

                Spacer()
            }
        }
        .frame(height: 50, alignment: .center)
    }
}

#Preview {
    PokemonCard(
        species: MockSpecies.mock
    )
}
