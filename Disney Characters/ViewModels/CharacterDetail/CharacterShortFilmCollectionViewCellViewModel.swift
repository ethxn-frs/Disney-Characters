//
//  CharacterShortFilmCollectionViewCellViewModel.swift
//  Disney Characters
//
//  Created by Etang on 20/01/2024.
//

import Foundation
import UIKit

final class CharacterShortFilmCollectionViewCellViewModel {
    
    public let value: String
    public let title: String
    public let iconImageView: UIImage
    
    init(
        value: String
    ) {
        self.value = value
        self.title = "Short Film"
        self.iconImageView = UIImage(systemName: "film.circle")!
    }
}
