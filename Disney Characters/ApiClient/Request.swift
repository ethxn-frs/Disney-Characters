//
//  Request.swift
//  Disney Characters
//
//  Created by Etang on 15/01/2024.
//

import Foundation


/// Object that represents single api call
final class Request {
    
    /// API Constants
    private struct Constants {
        static let baseUrl = "https://api.disneyapi.dev"
    }
    
    /// Desired endpoint
    private let endpoint: EndPoint

    /// Path components for API, if any
    private let pathComponents: [String]
    
    /// Query Api for API, if any
    private let queryParameters: [URLQueryItem]
    
    /// Constructed url for the api request
    private var urlSring: String {
        var string = Constants.baseUrl
        string += "/"
        string += endpoint.rawValue
        
        if !pathComponents.isEmpty {
            pathComponents.forEach({
                string += "/\($0)"
            })
        }
        if !queryParameters.isEmpty {
            string += "?"
            let argumentsString = queryParameters.compactMap({
                guard let value = $0.value else {return nil}
                return "\($0.name)=\(value)"
            }).joined(separator: "&")
            
            string += argumentsString
        }
        
        return string
    }
    
    /// Computed & constructed API url
    public var url: URL? {
        return URL(string: urlSring)
    }
    
    /// Desired http method
    public let httpMethod = "GET"
     
    //Mark - Public
    
    
    /// Construct request
    /// - Parameters:
    ///   - endpoint: Target endpoint
    ///   - pathComponents: Collection of path components
    ///   - queryParameters: Collection of queries parameters
    public init(endpoint: EndPoint,
         pathComponents: [String] = [],
         queryParameters: [URLQueryItem] = []) {
        self.endpoint = endpoint
        self.pathComponents = pathComponents
        self.queryParameters = queryParameters
    }
    
    convenience init?(url: URL) {
        var string = url.absoluteString
        if (string.hasPrefix("http://")){
            string = string.replacingOccurrences(of: "http://", with: "https://")
        }
        print(string)
        let trimmed = string.replacingOccurrences(of: Constants.baseUrl+"/", with: "")
        if trimmed.contains("/"){
            let components = trimmed.components(separatedBy: "/")
            if !components.isEmpty {
                let endpointString = components[0]
                if let Endpoint = EndPoint(rawValue: endpointString) {
                    self.init(endpoint: Endpoint)
                    return
                }
            }
        } else if trimmed.contains("?") {
            let components = trimmed.components(separatedBy: "?")
            if !components.isEmpty {
                let endpointString = components[0]
                if let Endpoint = EndPoint(rawValue: endpointString) {
                    self.init(endpoint: Endpoint)
                    return
                }
            }
        }
        return nil
    }
}

extension Request {
    static let listCharactersRequests = Request(endpoint: .character)
}
