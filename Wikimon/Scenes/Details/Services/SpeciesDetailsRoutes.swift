import Foundation

enum SpeciesDetailsRoutes {
    case generic(url: String)
}

extension SpeciesDetailsRoutes: Networking.Route {
    var path: String {
        return switch self {
        case let .generic(url):
            url
        }
    }

    var method: Networking.Method {
        .GET
    }

    var body: (any Encodable)? {
        nil
    }

    var headers: [String : String] {
        [:]
    }

    var queryItems: [URLQueryItem] {
        []
    }

    var usesAbsoluteURL: Bool {
        true
    }
}
