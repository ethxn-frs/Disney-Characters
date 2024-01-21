//
//  CharacterFilmAndSerieCollectionViewCellViewModel.swift
//  Disney Characters
//
//  Created by Etang on 20/01/2024.
//

import UIKit
import Foundation

final class CharacterFilmCollectionViewCellViewModel {
    
    public let value: String
    public let title: String
    public let iconImageView: UIImage
    
    init(
        value: String
    ) {
        self.value = value
        self.title = "Film"
        self.iconImageView = UIImage(systemName: "movieclapper")!
    }
}
