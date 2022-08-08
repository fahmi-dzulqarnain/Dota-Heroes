//
//  UIView+Ext.swift
//  Dota Heroes
//
//  Created by Fahmi Dzulqarnain on 06/08/22.
//

import UIKit

internal extension UIView {
    @discardableResult
    func with(parent: UIView) -> Self {
        parent.addSubview(self)
        return self
    }
    
    func cornerRadius(spacing: Spacing) {
        layer.cornerRadius = spacing.rawValue
    }
    
    func addTapGesture(tapNumber: Int = 1, target: Any, action: Selector) {
        let tap = UITapGestureRecognizer(target: target, action: action)
        tap.numberOfTapsRequired = tapNumber
        addGestureRecognizer(tap)
        isUserInteractionEnabled = true
    }
}
