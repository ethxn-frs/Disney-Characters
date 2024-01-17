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

    init(viewModel: CharacterDetailViewViewModel ) {
        self.viewModel = viewModel
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
        
       
    }

}
