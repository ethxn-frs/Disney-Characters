//
//  Service.swift
//  Disney Characters
//
//  Created by Etang on 15/01/2024.
//

import Foundation

/// Primary Api service object to get Disney Data
final class Service {
    
    /// Shared singleton intance
    static let shared = Service()
    
    /// Privatized constructor
    private init() {}
    
    enum ServiceError: Error {
        case failedToCreateRequest
        case failedToGetData
    }
    
    
    // Send Disney Api Call
    /// Parameters :
    /// -request: Request Instance
    /// -type: The type of object expected to get back
    /// -completion : Callback with data or error
    public func execute<T: Codable>(
        _ request: Request,
        expecting type: T.Type,
        completion: @escaping (Result<T, Error>) -> Void
    ){
        guard let urlRequest = self.request(from: request) else {
            print("failed to create request")
            completion(.failure(ServiceError.failedToCreateRequest))
            return
        }
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            // Log the URL
            print("URL: \(urlRequest.url?.absoluteString ?? "N/A")")

            // Log the response status code
            if let httpResponse = response as? HTTPURLResponse {
                print("HTTP Status Code: \(httpResponse.statusCode)")
            }

            // Log any error that occurred
            if let error = error {
                print("Error: \(error.localizedDescription)")
                completion(.failure(ServiceError.failedToGetData))
                return
            }

            // Log the received data
            if let data = data {
                let responseData = String(data: data, encoding: .utf8) ?? "N/A"
                //print("Received Data: \(responseData)")
            } else {
                print("No data received")
            }

            // Decode response to object
            do {
                let result = try JSONDecoder().decode(type.self, from: data ?? Data())
                print("Decoding successful")
                completion(.success(result))
            } catch {
                print("Decoding error: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }

        task.resume()

    }
    
    // MARK - Private
    private func request(from Request: Request) -> URLRequest? {
        guard let url = Request.url else {
            return nil
        }
        var request = URLRequest(url: url )
        
        request.httpMethod = Request.httpMethod
        return request
    }
}
