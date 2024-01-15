//
//  GetCharactersResponse.swift
//  Disney Characters
//
//  Created by Etang on 15/01/2024.
//

import Foundation

struct GetAllCharactersResponse: Codable{
    struct Info: Codable {
        let totalPages: Int
        let count: Int
        let previousPage: String?
        let nextPage: String?
    }
    
    let info: Info
    let data: [Character]
}
