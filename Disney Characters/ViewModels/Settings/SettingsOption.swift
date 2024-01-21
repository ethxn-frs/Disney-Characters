//
//  SettingsOption.swift
//  Disney Characters
//
//  Created by Etang on 21/01/2024.
//

import Foundation
import UIKit

enum SettingsOption: CaseIterable {
    case rateApp
    case contactUs
    case terms
    case privacy
    case apiReference
    case viewCode
    case supportUs
    
    var targetUrl: URL? {
        switch self {
        case .rateApp:
            return nil
        case .contactUs:
            return URL(string: "https://www.instagram.com/ethxn.frs/")
        case .terms:
            return URL(string: "https://www.instagram.com/ethxn.frs/")
        case .privacy:
            return URL(string: "https://www.instagram.com/ethxn.frs/")
        case .apiReference:
            return URL(string: "https://disneyapi.dev/")
        case .viewCode:
            return URL(string: "https://github.com/ethxn-frs/Disney-Characters")
        case .supportUs:
            // Paywall with revenue cat to create
            return URL(string: "https://www.paypal.me/therichestoftheworld")
        }
    }
    
    var displayTitle: String {
        switch self {
        case .rateApp:
            return "Rate App"
        case .contactUs:
            return "Contact Us"
        case .terms:
            return "Terms of Service"
        case .privacy:
            return "Privacy Policy"
        case .apiReference:
            return "API Reference"
        case .viewCode:
            return "View Code"
        case .supportUs:
            return "Support Us"
        }
    }
    
    var iconContainerColor: UIColor {
        switch self {
        case .rateApp:
            return .systemBlue
        case .contactUs:
            return .systemGreen
        case .terms:
            return .systemRed
        case .privacy:
            return .systemYellow
        case .apiReference:
            return .systemOrange
        case .viewCode:
            return .systemPink
        case .supportUs:
            return .systemPurple
        }
    }
    
    var iconImage: UIImage? {
        switch self {
        case .rateApp:
            return UIImage(systemName: "star.fill")
        case .contactUs:
            return UIImage(systemName: "arrow.up.message.fill")
        case .terms:
            return UIImage(systemName: "text.book.closed.fill")
        case .privacy:
            return UIImage(systemName: "hand.raised.circle.fill")
        case .apiReference:
            return UIImage(systemName: "info.circle.fill")
        case .viewCode:
            return UIImage(systemName: "applescript.fill")
        case .supportUs:
            return UIImage(systemName: "dollarsign.circle.fill")
        }
    }
}
