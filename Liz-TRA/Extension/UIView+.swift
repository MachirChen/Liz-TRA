//
//  UIView+.swift
//  Liz-TRA
//
//  Created by Machir on 2023/7/7.
//

import UIKit

extension UIView {
    
    func cornerRadii(radii: CGFloat) {
        clipsToBounds = true
        layer.cornerRadius = radii
    }
    
    func applyRoundedBorder(radius: CGFloat) {
        layer.borderWidth = 2.0
        layer.borderColor = UIColor.lizOrenge.cgColor
        layer.cornerRadius = radius
        layer.masksToBounds = true
    }
    
    func removeRoundedBorder() {
        layer.borderWidth = 0.0
        layer.borderColor = UIColor.clear.cgColor
        layer.cornerRadius = 0.0
        layer.masksToBounds = false
    }
    
}
