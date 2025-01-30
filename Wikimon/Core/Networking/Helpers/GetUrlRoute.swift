import Foundation

struct GetUrlRoute: Networking.Route {
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
