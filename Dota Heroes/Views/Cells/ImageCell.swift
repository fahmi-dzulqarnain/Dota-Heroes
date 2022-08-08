//
//  ImageCell.swift
//  Dota Heroes
//
//  Created by Fahmi Dzulqarnain on 08/08/22.
//

import UIKit

class ImageCell: UITableViewCell {
    static let identifier = "ImageCell"
    
    lazy var largeImage = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        largeImage.with(parent: contentView)
        largeImage.contentMode = .scaleAspectFill
        largeImage.setHeight(by: 200)
        largeImage.makeConstraint { constraint in
            constraint.topAnchor.equal(contentView.topAnchor)
            constraint.trailingAnchor.equal(contentView.trailingAnchor)
            constraint.leadingAnchor.equal(contentView.leadingAnchor)
            constraint.bottomAnchor.equal(contentView.bottomAnchor)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal func setImage(URLAddress: String) {
        largeImage.image = UIImage(named: "thumbnail-default")
        largeImage.loadFrom(URLAddress: URLAddress)
    }
}
