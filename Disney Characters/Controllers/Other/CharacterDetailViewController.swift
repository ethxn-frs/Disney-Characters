//
//  CharacterDetailViewController.swift
//  Disney Characters
//
//  Created by Etang on 17/01/2024.
//

import UIKit

/// Controller to show info about single character
final class CharacterDetailViewController: UIViewController {
    
    private let viewModel: CharacterDetailViewViewModel
    
    private let detailView: CharacterDetailView
    
    init(viewModel: CharacterDetailViewViewModel ) {
        self.viewModel = viewModel
        self.detailView = CharacterDetailView(frame: .zero, viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    //MARK - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = viewModel.title
        view.addSubview(detailView)
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .action,
            target: self,
            action: #selector(didTapShare)
        )
        addConstraints()
        
        detailView.collectionView?.delegate = self
        detailView.collectionView?.dataSource = self
    }
    
    @objc
    private func didTapShare() {
        
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            
            detailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            detailView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            detailView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            detailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

extension CharacterDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionType = viewModel.sections[section]
        switch sectionType {
        case .photo:
            return 1
        case .films(let viewModels):
            return viewModels.count
        case .shortFilms(let viewModels):
            return viewModels.count
        case .tvShow(let viewModels):
            return viewModels.count
        case .videosGames(let viewModels):
            return viewModels.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sectionType = viewModel.sections[indexPath.section]
        switch sectionType {
        case .photo(let viewModel):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CharacterPhotoCollectionViewCell.cellIdentifier,
                for: indexPath
            ) as? CharacterPhotoCollectionViewCell else {
                fatalError("Unsupported")
            }
            cell.configure(with: viewModel)
            return cell
        case .films(let viewModels):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CharacterFilmCollectionViewCell.cellIdentifier,
                for: indexPath
            ) as? CharacterFilmCollectionViewCell else {
                fatalError("Unsupported")
            }
            cell.configure(with: viewModels[indexPath.row])
            return cell
        case .shortFilms(let viewModels):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CharacterShortFilmCollectionViewCell.cellIdentifier,
                for: indexPath
            ) as? CharacterShortFilmCollectionViewCell else {
                fatalError("Unsupported")
            }
            cell.configure(with: viewModels[indexPath.row])
            return cell
        case .tvShow(let viewModels):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CharacterTvShowCollectionViewCell.cellIdentifier,
                for: indexPath
            ) as? CharacterTvShowCollectionViewCell else {
                fatalError("Unsupported")
            }
            cell.configure(with: viewModels[indexPath.row])
            return cell
        case .videosGames(let viewModels):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CharacterVideoGameCollectionViewCell.cellIdentifier,
                for: indexPath
            ) as? CharacterVideoGameCollectionViewCell else {
                fatalError("Unsupported")
            }
            cell.configure(with: viewModels[indexPath.row])
            return cell
        }
    }
}
