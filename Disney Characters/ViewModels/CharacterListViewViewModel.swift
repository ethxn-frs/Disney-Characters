//
//  CharacterListViewViewModel.swift
//  Disney Characters
//
//  Created by Etang on 15/01/2024.
//

import UIKit

protocol CharacterListViewViewModelDelegate: AnyObject {
    func didLoadInitialCharacters()
    func didLoadMoreCharacters(with newIndexPath: [IndexPath])
    
    func didSelectCharacter(_ character: Character)
}

// View model to handle character list view
final class CharacterListViewViewModel: NSObject{
    
    public weak var delegate: CharacterListViewViewModelDelegate?
    
    private var isLoadingMoreCharacter = false
    private let characterUnknownImageUrl = "https://upload.wikimedia.org/wikipedia/commons/thumb/7/7f/Replacement_character.svg/800px-Replacement_character.svg.png"
    
    private var characters: [Character] = [] {
        didSet{
            for character in characters{
                let viewModel = CharacterCollectionViewCellViewModel(
                    characterName: character.name,
                    characterImageURl: URL(string: character.imageUrl ?? characterUnknownImageUrl)
                )
                if !cellViewModels.contains(viewModel) {
                    cellViewModels.append(viewModel)
                }
            }
        }
    }
    
    private var cellViewModels: [CharacterCollectionViewCellViewModel] = []
    
    private var apiInfo: GetAllCharactersResponse.Info? = nil
    
    /// Fetch initial set of characters (50)
    public func fetchCharacters() {
        Service.shared.execute(
            .listCharactersRequests,
            expecting: GetAllCharactersResponse.self
        ) { [weak self] result in
            //print("Service execution result: \(result)")
            switch result {
            case .success(let responseModel):
                let results = responseModel.data
                let info = responseModel.info
                self?.characters = results
                self?.apiInfo = info
                DispatchQueue.main.async {
                    self?.delegate?.didLoadInitialCharacters()
                }
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    
    /// Paginate if additional characters are needed
    public func fetchAdditonalCharacters(url: URL){
        guard !isLoadingMoreCharacter else {
            return
        }
        print("Fetching more characters")
        isLoadingMoreCharacter = true
        guard let request = Request(url: url) else {
            isLoadingMoreCharacter = false
            print("Failed to create request")
            return
        }
        Service.shared.execute(request,
                               expecting: GetAllCharactersResponse.self) { [weak self] result in
            guard let strongSelf = self else {
                return
            }
            switch result {
            case .success(let responseModel):
                let moreResults = responseModel.data
                let info = responseModel.info
                strongSelf.apiInfo = info
                
                let originalCount = strongSelf.characters.count
                let newCount = moreResults.count
                let total = originalCount + newCount
                let startingIndex = total - newCount
                let indexPathToAdd: [IndexPath] = Array(startingIndex..<(startingIndex+newCount)).compactMap({
                    return IndexPath(row: $0, section: 0)
                })
                strongSelf.characters.append(contentsOf: moreResults)
                DispatchQueue.main.async {
                    strongSelf.delegate?.didLoadMoreCharacters(
                        with: indexPathToAdd
                    )
                    self?.isLoadingMoreCharacter = false
                }
            case .failure(let failure):
                self?.isLoadingMoreCharacter = false
                print(String(describing: failure))
            }
        }
    }
    
    public var shouldShowLoadMoreIndicator: Bool {
        return apiInfo?.nextPage != nil
    }
}

// MARK - CollectionView
extension CharacterListViewViewModel: UICollectionViewDataSource, UICollectionViewDelegate,
    UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CharacterCollectionViewCell.cellIdentifier,
            for: indexPath
        ) as? CharacterCollectionViewCell else {
            fatalError("Unsupported cell")
        }
        cell.configure(with: cellViewModels[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionFooter,
              let footer = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: FooterLoadingCollectionReusableView.identifer ,
            for: indexPath
        ) as? FooterLoadingCollectionReusableView else {
            fatalError("Unsupported")
        }
        footer.startAnimating()
        return footer
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        guard shouldShowLoadMoreIndicator else {
            return .zero
        }
        return CGSize(width: collectionView.frame.width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let bounds = UIScreen.main.bounds
        let width = (bounds.width-30)/2
        return CGSize(
            width: width,
            height: width * 1.5
        )
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        collectionView.deselectItem(at: indexPath, animated: true)
        let character = characters[indexPath.row]
        delegate?.didSelectCharacter(character)
    }
}

// MARK - ScrollView

extension CharacterListViewViewModel: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard shouldShowLoadMoreIndicator,
              !isLoadingMoreCharacter,
              !cellViewModels.isEmpty,
              let nextUrlString = apiInfo?.nextPage,
              let url = URL(string: nextUrlString)  else {
            return
        }
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { [weak self] t in
            let offset = scrollView.contentOffset.y
            let totalContentHeight = scrollView.contentSize.height
            let totalScrollViewFixedHeight = scrollView.frame.size.height
            
            if offset >= (totalContentHeight - totalScrollViewFixedHeight - 100) {
                self?.fetchAdditonalCharacters(url: url)
            }
            t.invalidate()
        }
    }
}
