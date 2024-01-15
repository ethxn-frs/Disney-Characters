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
            completion(.failure(ServiceError.failedToCreateRequest))
            return
        }
        
        let task = URLSession.shared.dataTask(with: urlRequest){
            data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(ServiceError.failedToGetData))
                return
            }
            
            // Decode reponse to object
            do {
                let result = try JSONDecoder().decode(type.self, from: data)
                completion(.success(result))
            }
            catch {
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
