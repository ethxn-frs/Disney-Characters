//
//  SettingViewController.swift
//  Disney Characters
//
//  Created by Etang on 15/01/2024.
//

import UIKit


/// Controller to show app options and settings
final class SettingViewController: UIViewController {
    
    private let viewModel = SettingsViewViewModel(
        cellViewModels: SettingsOption.allCases.compactMap({
            return SettingsCellViewModel(type: $0)
        })
    )

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Settings"
    }

}
