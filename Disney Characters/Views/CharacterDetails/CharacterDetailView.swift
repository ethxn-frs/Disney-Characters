//
//  CharacterDetailView.swift
//  Disney Characters
//
//  Created by Etang on 17/01/2024.
//

import UIKit


// View for single character info
final class CharacterDetailView: UIView {
    
    public var collectionView: UICollectionView?
    
    private let viewModel: CharacterDetailViewViewModel
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    // MARK - Init
    
    init(frame: CGRect, viewModel: CharacterDetailViewViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemBackground
        let collectionView = createCollectionView()
        self.collectionView = collectionView
        addSubviews(collectionView, spinner)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    private func addConstraints() {
        guard let collectionView = collectionView else {
            return
        }
        
        NSLayoutConstraint.activate([
            spinner.widthAnchor.constraint(equalToConstant: 100),
            spinner.heightAnchor.constraint(equalToConstant: 100),
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
        ])
    }
    
    private func createCollectionView() -> UICollectionView{
        let layout = UICollectionViewCompositionalLayout {sectionIndex, _ in
            return self.createSection(for: sectionIndex)
        }
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CharacterPhotoCollectionViewCell.self,
                                forCellWithReuseIdentifier: CharacterPhotoCollectionViewCell.cellIdentifier)
        collectionView.register(CharacterFilmCollectionViewCell.self,
                                forCellWithReuseIdentifier: CharacterFilmCollectionViewCell.cellIdentifier)
        collectionView.register(CharacterShortFilmCollectionViewCell.self,
                                forCellWithReuseIdentifier: CharacterShortFilmCollectionViewCell.cellIdentifier)
        collectionView.register(CharacterTvShowCollectionViewCell.self,
                                forCellWithReuseIdentifier: CharacterTvShowCollectionViewCell.cellIdentifier)
        collectionView.register(CharacterVideoGameCollectionViewCell.self,
                                forCellWithReuseIdentifier: CharacterVideoGameCollectionViewCell.cellIdentifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }
    
    private func createSection(for sectionIndex: Int) -> NSCollectionLayoutSection {
        let sectionTypes = viewModel.sections
        switch sectionTypes[sectionIndex] {
        case .photo:
            return viewModel.createPhotoSectionLayout()
        case .films:
            return viewModel.createFilmsSectionLayout()
        case .shortFilms:
            return viewModel.createShortFilmsSectionLayout()
        case .tvShow:
            return viewModel.createTvShowsSectionLayout()
        case .videosGames:
            return viewModel.createVideoGamesSectionLayout()
        }
    }
}

