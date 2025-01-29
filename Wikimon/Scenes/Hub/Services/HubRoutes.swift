import Foundation

enum HubRoutes {
    case hub(page: Int)
    case image(id: Int)
    case generic(url: String)
}

extension HubRoutes: Networking.Route {
    var path: String {
        return switch self {
        case .hub:
            "pokemon-species"
        case let .image(id):
            "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id).png"
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

    var usesAbsoluteURL: Bool {
        return switch self {
        case .hub:
            false
        case .image, .generic:
            true
        }
    }

    var queryItems: [URLQueryItem] {
        return switch self {
        case let .hub(page):
            [
                URLQueryItem(name: "offset", value: (20 * page).description),
                URLQueryItem(name: "limit", value: "20"),
            ]
        default:
            []
        }
    }
}
