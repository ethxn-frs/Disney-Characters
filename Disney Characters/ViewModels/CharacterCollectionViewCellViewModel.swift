//
//  CharacterCollectionViewCellViewModel.swift
//  Disney Characters
//
//  Created by Etang on 16/01/2024.
//

import Foundation

final class  CharacterCollectionViewCellViewModel {
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
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? URLError(.badServerResponse)))
                return
            }
            completion(.success(data))
        }
        task.resume()
    }
}
