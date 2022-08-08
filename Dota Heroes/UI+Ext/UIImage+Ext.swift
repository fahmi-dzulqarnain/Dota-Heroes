//
//  UIImage+Ext.swift
//  Dota Heroes
//
//  Created by Fahmi Dzulqarnain on 07/08/22.
//

import UIKit
import Foundation

extension UIImageView {
    func loadFrom(URLAddress: String) {
        guard let url = URL(string: URLAddress) else {
            return
        }
        
        DispatchQueue.main.async { [weak self] in
            if let imageData = try? Data(contentsOf: url) {
                if let loadedImage = UIImage(data: imageData) {
                        self?.image = loadedImage
                }
            }
        }
    }
}
