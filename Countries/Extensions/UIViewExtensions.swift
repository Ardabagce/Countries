//
//  UIViewExtensions.swift
//  Countries
//
//  Created by Arda Bağçe on 27.09.2022.
//

import Foundation
import UIKit

extension UIView {
    
    func roundCorners(with radius: CGFloat, borderColor: UIColor = .clear, borderWidth: CGFloat = .leastNormalMagnitude) {
        layer.cornerRadius = radius
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = borderWidth
        layer.masksToBounds = true
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
