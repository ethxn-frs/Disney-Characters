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
    
    
    // Send Disney Api Call
    /// Parameters :
    /// -request: Request Instance
    /// -completion : Callback with data or error
    public func execute(_ request: Request, completion: @escaping () -> Void){
        
    }
}
