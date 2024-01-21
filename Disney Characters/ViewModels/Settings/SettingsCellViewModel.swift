//
//  SettingsCellViewModel.swift
//  Disney Characters
//
//  Created by Etang on 21/01/2024.
//

import Foundation
import UIKit

struct SettingsCellViewModel: Identifiable, Hashable {
    let id = UUID()
    
    private let type: SettingsOption
    
    // MARK - Init
    
    init(type: SettingsOption) {
        self.type = type
    }
    
    // MARK - Public
    
    public var image: UIImage? {
        return type.iconImage
    }
    
    public var title: String {
        return type.displayTitle
    }
    
    public var iconContainerColor: UIColor {
        return type.iconContainerColor
    }
}
