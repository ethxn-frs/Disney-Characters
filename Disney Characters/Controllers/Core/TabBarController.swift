//
//  ViewController.swift
//  Disney Characters
//
//  Created by Etang on 15/01/2024.
//

import UIKit

/// Controller to house tabs and root tab controllers
final class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        setUpTabs()
    }
    
    private func setUpTabs() {

        let characterVc = CharacterViewController()
        let filmAndSerieVc = FilmAndSerieViewController()
        let videoGameVc = VideoGameViewController()
        let settingVc = SettingViewController()
        
        characterVc.navigationItem.largeTitleDisplayMode = .automatic
        filmAndSerieVc.navigationItem.largeTitleDisplayMode = .automatic
        videoGameVc.navigationItem.largeTitleDisplayMode = .automatic
        settingVc.navigationItem.largeTitleDisplayMode = .automatic
        
        let nav1 = UINavigationController(rootViewController: characterVc)
        let nav2 = UINavigationController(rootViewController: filmAndSerieVc)
        let nav3 = UINavigationController(rootViewController: videoGameVc)
        let nav4 = UINavigationController(rootViewController: settingVc)
        
        nav1.tabBarItem = UITabBarItem(title: "Characters",
                                       image: UIImage(systemName: "person.3.fill"),
                                       tag: 1)
        
        nav2.tabBarItem = UITabBarItem(title: "Films And Series",
                                       image: UIImage(systemName: "film.stack.fill"),
                                       tag: 2)
        
        nav3.tabBarItem = UITabBarItem(title: "Videos Games",
                                       image: UIImage(systemName: "gamecontroller.fill"),
                                       tag: 3)
        
        nav4.tabBarItem = UITabBarItem(title: "Settings",
                                       image: UIImage(systemName: "gear"),
                                       tag: 4)
        
        for nav in [nav1, nav2, nav3, nav4]{
            nav.navigationBar.prefersLargeTitles = true
        }
        
        setViewControllers(
            [nav1, nav2, nav3, nav4],
            animated: true)
    }


}

