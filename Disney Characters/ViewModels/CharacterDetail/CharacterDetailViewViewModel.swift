//
//  CharacterDetailViewViewModel.swift
//  Disney Characters
//
//  Created by Etang on 17/01/2024.
//

import UIKit
import Foundation

final class CharacterDetailViewViewModel {
    
    private let character: Character
    private let imageUrlDefault = "https://upload.wikimedia.org/wikipedia/commons/thumb/7/7f/Replacement_character.svg/800px-Replacement_character.svg.png"
    
    enum SectionType {
        case photo(viewModel: CharacterPhotoCollectionViewCellViewModel)
        case films(viewModels: [CharacterFilmCollectionViewCellViewModel])
        case shortFilms(viewModels: [CharacterShortFilmCollectionViewCellViewModel])
        case tvShow(viewModels: [CharacterTvShowCollectionViewCellViewModel])
        case videosGames(viewModels: [CharacterVideoGameCollectionViewCellViewModel])
        
    }
    
    public var sections: [SectionType] = []
    
    // MARK - Init
    
    init(character: Character) {
        self.character = character
        setUpSections()
    }
    
    private func setUpSections() {
        
        sections = [
            .photo(viewModel: .init(imageUrl: URL(string: character.imageUrl ?? imageUrlDefault))),
            .films(viewModels: character.films.compactMap ({
                return CharacterFilmCollectionViewCellViewModel( value: $0)
            })),
            .shortFilms(viewModels: character.shortFilms.compactMap ({
                return CharacterShortFilmCollectionViewCellViewModel( value: $0)
            })),
            .tvShow(viewModels: character.tvShows.compactMap ({
                return CharacterTvShowCollectionViewCellViewModel( value: $0)
            })),
            .videosGames(viewModels: character.videoGames.compactMap({
                return CharacterVideoGameCollectionViewCellViewModel(value: $0)
            }))
        ]
    }
    
    private var requestURl: URL? {
        return URL(string: character.url)
    }
    
    public var title: String {
        character.name.uppercased()
    }
    
    // MARK - Layouts
    public func createPhotoSectionLayout() -> NSCollectionLayoutSection  {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
        )
        item.contentInsets = NSDirectionalEdgeInsets(top: 0,
                                                     leading: 0,
                                                     bottom: 10,
                                                     trailing: 0)
        
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(0.5)
            ),
            subitems: [item]
        )
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    
    public func createFilmsSectionLayout() -> NSCollectionLayoutSection  {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.5),
                heightDimension: .fractionalHeight(1.0)
            )
        )
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 2,
            leading: 2,
            bottom: 2,
            trailing: 2
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(150)
            ),
            subitems: [item, item]
        )
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    public func createShortFilmsSectionLayout() -> NSCollectionLayoutSection  {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.5),
                heightDimension: .fractionalHeight(1.0)
            )
        )
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 2,
            leading: 2,
            bottom: 2,
            trailing: 2
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(150)
            ),
            subitems: [item, item]
        )
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    public func createTvShowsSectionLayout() -> NSCollectionLayoutSection  {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.5),
                heightDimension: .fractionalHeight(1.0)
            )
        )
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 2,
            leading: 2,
            bottom: 2,
            trailing: 2
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(150)
            ),
            subitems: [item, item]
        )
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    
    public func createVideoGamesSectionLayout() -> NSCollectionLayoutSection  {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
        )
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 10,
            leading: 5,
            bottom: 10,
            trailing: 8
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.8),
                heightDimension: .absolute(150)
            ),
            subitems: [item]
        )
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        return section
    }
}
