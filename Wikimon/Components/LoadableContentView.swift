import SwiftUI

enum LoadableContentViewState {
    case loading
    case loaded
    case failed
}

struct LoadableContentView<Loading: View, Loaded: View, Failed: View>: View {
    @Binding var state: LoadableContentViewState
    var loading: () -> Loading
    var loaded: () -> Loaded
    var failed: () -> Failed

    public init(
        state: Binding<LoadableContentViewState>,
        @ViewBuilder loading: @escaping () -> Loading,
        @ViewBuilder loaded: @escaping () -> Loaded,
        @ViewBuilder failed: @escaping () -> Failed
    ) {
        _state = state
        self.loading = loading
        self.loaded = loaded
        self.failed = failed
    }

    var body: some View {
        switch state {
        case .loading: loading()
        case .loaded: loaded()
        case .failed: failed()
        }
    }
}
