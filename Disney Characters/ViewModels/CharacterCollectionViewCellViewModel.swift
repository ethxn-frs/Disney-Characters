//
//  CharacterCollectionViewCellViewModel.swift
//  Disney Characters
//
//  Created by Etang on 16/01/2024.
//

import Foundation

final class  CharacterCollectionViewCellViewModel: Hashable, Equatable {

    public let characterName: String
    private let characterImageURl: URL?
    
    /// MARK - Init
    init(
        characterName: String,
        characterImageURl: URL?
        
    ){
        self.characterName = characterName
        self.characterImageURl = characterImageURl
        
    }
    
    public func fetchImage(completion: @escaping (Result<Data, Error>) -> Void) {
        
        guard let url = characterImageURl else {
            completion(.failure(URLError(.badURL)))
            return
        }
        ImageLoader.shared.downloadImage(url, completion: completion)
    }
    
    // MARK - Hashable
    
    static func == (lhs: CharacterCollectionViewCellViewModel, rhs: CharacterCollectionViewCellViewModel) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(characterName)
        hasher.combine(characterImageURl)
    }
    
}
