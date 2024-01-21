//
//  SettingViewController.swift
//  Disney Characters
//
//  Created by Etang on 15/01/2024.
//

import SwiftUI
import UIKit


/// Controller to show app options and settings
final class SettingViewController: UIViewController {
    
    private let settingsSwiftUIController = UIHostingController(
        rootView: SettingsView(
            viewModel: SettingsViewViewModel(
                cellViewModels: SettingsOption.allCases.compactMap({
                    return SettingsCellViewModel(type: $0)
                })
            )
        )
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Settings"
        addSwiftUIController()
    }
    
    private func addSwiftUIController() {
        addChild(settingsSwiftUIController)
        settingsSwiftUIController.didMove(toParent: self)
        
        view.addSubview(settingsSwiftUIController.view)
        settingsSwiftUIController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            settingsSwiftUIController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            settingsSwiftUIController.view.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            settingsSwiftUIController.view.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            settingsSwiftUIController.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
