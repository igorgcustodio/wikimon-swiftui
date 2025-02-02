import Foundation
@testable import Wikimon

class MockURLSession: URLSessionProtocol {
    var mockData: Data?
    var mockResponse: URLResponse?
    var mockError: Error?
    var statusCode: Int = 200

    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        if let error = mockError {
            throw error
        }

        let data = mockData ?? Data()
        let response = mockResponse ?? HTTPURLResponse(
            url: request.url!,
            statusCode: statusCode,
            httpVersion: nil,
            headerFields: nil
        )!

        return (data, response)
    }
}
