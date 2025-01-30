import SwiftUI

struct SpeciesDetailsView: View {
    @ObservedObject var viewModel: SpeciesDetailsViewModel = SpeciesDetailsViewModel()
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    SpeciesDetailsView()
}
