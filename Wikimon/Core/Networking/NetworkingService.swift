import Foundation

typealias NetworkingService = Networking.NetworkingService

extension Networking {
    class NetworkingService<R: Route> {
        let urlSession: URLSession
        let baseUrl: String

        init(urlSession: URLSession = .shared, baseUrl: String) {
            self.urlSession = urlSession
            self.baseUrl = baseUrl
        }

        func request<T: Resource>(_ route: R) async throws -> T {
            let data: Data? = try await request(route)

            guard let data else {
                throw ResponseError.unexpected
            }

            do {
                return try T.decode(from: data)
            } catch let error as DecodingError {
                throw ResponseError.decodingFailed(underlyingError: error)
            } catch {
                throw ResponseError.unexpected
            }
        }

        func request(_ route: R) async throws -> Data? {
            let requestBuilder = RequestBuilder(baseUrl: route.usesAbsoluteURL ? "" : baseUrl, route: route)

            let request = try requestBuilder.buildRequest()

            let (data, response) = try await urlSession.data(for: request)

            guard let response = response as? HTTPURLResponse else {
                throw ResponseError.noResponse
            }

            switch response.statusCode {
            case 200..<300:
                return data
            case 400..<500:
                throw ResponseError.clientError(code: response.statusCode)
            case 500..<600:
                throw ResponseError.serverError(code: response.statusCode)
            default:
                throw ResponseError.unexpected
            }

        }
    }
}
