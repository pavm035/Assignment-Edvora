//
//  NetworkService.swift
//  Edvora
//

//

import Foundation

/// Generice protocol that performs Network related operations
protocol NetworkService {
    func fetch<T: Decodable>(type: T.Type, with request: URLRequest) async throws -> T
}

extension NetworkService {
    func fetch<T: Decodable>(type: T.Type, with request: URLRequest) async throws -> T {
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.requestFailed(description: "invalid response")
        }
        
        guard httpResponse.statusCode == 200 else {
            throw APIError.responseUnsuccessful(description: "status code \(httpResponse.statusCode)")
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .formatted(.edvora)            
            return try decoder.decode(type, from: data)
        } catch {
            debugPrint("decoding error:", error)
            throw APIError.jsonConversionFailure(description: error.localizedDescription)
        }
    }
}

// Custom date formatter to parse date-time
private extension DateFormatter {
    static let edvora: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-mm-dd'T'HH:mm:ss.SSS'Z'"
        return formatter
    }()
}

// MARK: - URLSession
@available(iOS, deprecated: 15.0, message: "Use the built-in API instead")
extension URLSession {
    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        try await withCheckedThrowingContinuation { continuation in
            let task = self.dataTask(with: request) { data, response, error in
                guard let data = data, let response = response else {
                    let error = error ?? URLError(.badServerResponse)
                    return continuation.resume(throwing: error)
                }
                
                continuation.resume(returning: (data, response))
            }
            
            task.resume()
        }
    }
}
