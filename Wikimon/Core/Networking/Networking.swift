import Foundation

enum Networking {
    enum Method: String {
        case GET, POST, PUT, DELETE
    }

    protocol Route {
        var path: String { get }
        var method: Method { get }
        var body: Encodable? { get }
        var headers: [String: String] { get }
        var queryItems: [URLQueryItem] { get }
        var timeout: TimeInterval { get }
        var cachePolicy: URLRequest.CachePolicy { get }
    }

    enum ResponseError: Error {
        case noResponse
        case unexpected
        case decodingFailed
        case clientError(Int)
        case serverError(Int)
        case unkonwn
    }

    protocol Resource: Decodable {
        static func decode(from: Data) throws -> Self
    }

    struct RequestBuilder {
        enum RequestError: Error {
            case badUrl
            case encodingFailed
            case invalidQueryItems
        }

        let route: Route

        func buildRequest() throws -> URLRequest {
            guard var url = URL(string: route.path)
            else {
                throw RequestError.badUrl
            }

            if !route.queryItems.isEmpty {
                var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
                components?.queryItems = route.queryItems

                if let componentUrl = components?.url {
                    url = componentUrl
                } else {
                    throw RequestError.invalidQueryItems
                }
            }

            var request = URLRequest(
                url: url,
                cachePolicy: route.cachePolicy,
                timeoutInterval: route.timeout
            )

            request.httpMethod = route.method.rawValue

            for header in route.headers {
                request.setValue(header.value, forHTTPHeaderField: header.key)
            }

            if route.method != .GET, let body = route.body {
                do {
                    let data = try JSONEncoder().encode(body)
                    request.httpBody = data
                } catch {
                    throw RequestError.encodingFailed
                }
            }

            return request
        }
    }
}

extension Networking.Route {
    var timeout: TimeInterval { 60 }
    var cachePolicy: URLRequest.CachePolicy { .reloadIgnoringLocalCacheData }
}

extension Networking.Resource {
    static func decode(from data: Data) throws -> Self {
        try JSONDecoder().decode(Self.self, from: data)
    }
}
