//
//  CharacterTvShowsCollectionViewCellViewModel.swift
//  Disney Characters
//
//  Created by Etang on 20/01/2024.
//


import Foundation
import UIKit

final class CharacterTvShowCollectionViewCellViewModel {
    
    public let value: String
    public let title: String
    public let iconImageView: UIImage
    
    init(
        value: String
    ) {
        self.value = value
        self.title = "Tv Show"
        self.iconImageView = UIImage(systemName: "play.rectangle.fill")!
    }
}
