//
//  Character.swift
//  Disney Characters
//
//  Created by Etang on 15/01/2024.
//

import Foundation

struct Character: Codable {
    
    let _id: Int
    let films:[String]
    let shortFilms:[String]
    let tvShows:[String]
    let videoGames:[String]
    let parkAttractions:[String]
    let allies:[String]
    let enemies:[String]
    let name:String
    let imageUrl:String?
    let url:String
}
