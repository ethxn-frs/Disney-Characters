//
//  CharacterDetailViewViewModel.swift
//  Disney Characters
//
//  Created by Etang on 17/01/2024.
//

import Foundation

final class CharacterDetailViewViewModel {
    
    private let character: Character
    
    init(character: Character) {
        self.character = character
    }
    
    public var title: String {
        character.name.uppercased()
    }
}
