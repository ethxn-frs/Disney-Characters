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
    public let endpoint: EndPoint
    
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
        if (string.hasPrefix("http://")) {
            string = string.replacingOccurrences(of: "http://", with: "https://")
        }
        print(string)
        let trimmed = string.replacingOccurrences(of: Constants.baseUrl+"/", with: "")
        if trimmed.contains("?") {
            let components = trimmed.components(separatedBy: "?")
            if !components.isEmpty, components.count >= 2 {
                let endpointString = components[0]
                let queryItemsString = components[1]
                
                let queryItems: [URLQueryItem] = queryItemsString.components(separatedBy: "&").compactMap({
                    guard $0.contains("=") else {
                        return nil
                    }
                    let parts = $0.components(separatedBy: "=")
                    
                    return URLQueryItem(
                        name: parts[0],
                        value: parts[1])
                })
                if let Endpoint = EndPoint(rawValue: endpointString) {
                    self.init(endpoint: Endpoint, queryParameters: queryItems)
                    return
                }
            }
        } else if trimmed.contains("/") {
            var components = trimmed.components(separatedBy: "/")
            if !components.isEmpty {
                if (components[0].contains("s")){
                    components[0] = components[0].replacingOccurrences(of: "s", with: "")
                }
                let endPointString = components[0] // Endpoint
                var pathComponents: [String] = []
                if components.count > 1 {
                    pathComponents = components
                    pathComponents.removeFirst()
                }
                if let endpoint = EndPoint(
                    rawValue: endPointString
                ) {
                    self.init(endpoint: endpoint, pathComponents: pathComponents)
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
