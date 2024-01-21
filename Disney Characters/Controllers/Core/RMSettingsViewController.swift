//
//  RMSettingsViewController.swift
//  RickAndMorty
//
//  Created by Afraz Siddiqui on 12/22/22.
//

import StoreKit
import SafariServices
import SwiftUI
import UIKit

/// Controller to show various app options and settings
final class RMSettingsViewController: UIViewController {

    private var settingsSwiftUIController: UIHostingController<SettingsView>?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Settings"
        addSwiftUIController()
    }

    private func addSwiftUIController() {
        let settingsSwiftUIController = UIHostingController(
            rootView: SettingsView(
                viewModel: SettingsViewViewModel(
                    cellViewModels: SettingsOption.allCases.compactMap({
                        return SettingsCellViewModel(type: $0) { [weak self] option in
                            self?.handleTap(option: option)
                        }
                    })
                )
            )
        )
        addChild(settingsSwiftUIController)
        settingsSwiftUIController.didMove(toParent: self)

        view.addSubview(settingsSwiftUIController.view)
        settingsSwiftUIController.view.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            settingsSwiftUIController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            settingsSwiftUIController.view.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            settingsSwiftUIController.view.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            settingsSwiftUIController.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])

        self.settingsSwiftUIController = settingsSwiftUIController
    }

    private func handleTap(option: SettingsOption) {
        guard Thread.current.isMainThread else {
            return
        }
    }
}
