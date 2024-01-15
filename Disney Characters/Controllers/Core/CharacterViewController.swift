//
//
//  CharacterViewController.swift
//  Disney Characters
//
//  Created by Etang on 15/01/2024.
//

import UIKit


/// Controller to show and search for characters
final class CharacterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Characters"
        
        let request = Request(
            endpoint: .character,
            queryParameters: [
                URLQueryItem(name: "name", value: "Queen Arianna")
            ]
        )
        print(request.url)
        
        Service.shared.execute(request,
                               expecting: Character.self) { result in
        }
    }

}
