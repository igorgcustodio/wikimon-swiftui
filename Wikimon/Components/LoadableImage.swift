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

final class LoadableImageService: NetworkingService<GetUrlRoute> {

    func fetchImage(url: String) async -> Data? {
        return try? await request(GetUrlRoute(path: url))
    }
}
