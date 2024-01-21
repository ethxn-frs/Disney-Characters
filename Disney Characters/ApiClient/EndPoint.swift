//
//  EndPoint.swift
//  Disney Characters
//
//  Created by Etang on 15/01/2024.
//

import Foundation


/// Represents unique api endpoint
@frozen enum EndPoint: String, CaseIterable, Hashable{
    case character
    case filmAndSerie
    case episode
}
