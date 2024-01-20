//
//  CharacterShortFilmCollectionViewCell.swift
//  Disney Characters
//
//  Created by Etang on 20/01/2024.
//

import UIKit
import Foundation

class CharacterShortFilmCollectionViewCell: UICollectionViewCell {
 
    static let cellIdentifier = "CharacterShortFilmCollectionViewCell"
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setUpConstraints() {
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    public func configure(with viewModel: CharacterShortFilmCollectionViewCellViewModel ) {
        
    }
}

