import SwiftUI

struct LoadableImageView: View {
    @State private var image: UIImage?

    var imageSize: CGFloat
    var imageURL: String?
    let service: LoadableImageService

    init(imageURL: String?, imageSize: CGFloat = 40) {
        self.imageSize = imageSize
        self.imageURL = imageURL
        service = LoadableImageService()
    }

    var body: some View {
        ZStack {
            if let image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: imageSize, height: imageSize)
            } else {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .padding()
                    .frame(width: imageSize, height: imageSize)
            }
        }
        .task {
            guard let imageURL, let data = await service.fetchImage(url: imageURL)
            else { return }
            image = UIImage(data: data)
        }
    }
}

struct LoadableImageRoute: Networking.Route {
    var path: String

    var method: Networking.Method { .GET }
    var body: (any Encodable)? { nil }
    var headers: [String : String] { [:] }
    var queryItems: [URLQueryItem] { [] }
    var usesAbsoluteURL: Bool { true }

    init(path: String) {
        self.path = path
    }
}

final class LoadableImageService: NetworkingService<LoadableImageRoute> {

    func fetchImage(url: String) async -> Data? {
        return try? await request(LoadableImageRoute(path: url))
    }
}
