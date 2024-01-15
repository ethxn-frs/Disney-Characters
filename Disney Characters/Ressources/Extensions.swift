//
//  Extensions.swift
//  Disney Characters
//
//  Created by Etang on 15/01/2024.
//

import UIKit

extension UIView{
    
    func addSubviews(_ views: UIView...) {
        views.forEach({
            addSubview($0)
        })
    }
}
