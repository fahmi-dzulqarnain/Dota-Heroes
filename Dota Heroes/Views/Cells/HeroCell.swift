//
//  HeroCell.swift
//  Dota Heroes
//
//  Created by Fahmi Dzulqarnain on 07/08/22.
//

import UIKit
import SDWebImage

class HeroCell: UICollectionViewCell {
    static let identifier = "HeroCell"
    var currentIndexPath: IndexPath?
    
    private let heroImage = UIImageView()
    private let nameLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupImage()
        setupNameLabel()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        heroImage.frame = contentView.bounds
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        heroImage.image = nil
    }
    
    private func setupImage() {
        heroImage.with(parent: contentView)
        heroImage.contentMode = .scaleAspectFill
        heroImage.clipsToBounds = true
        heroImage.setHeight(by: 100)
        heroImage.makeConstraint { constraint in
            constraint.topAnchor.equal(contentView.topAnchor)
            constraint.trailingAnchor.equal(contentView.trailingAnchor)
            constraint.leadingAnchor.equal(contentView.leadingAnchor)
        }
    }
    
    private func setupNameLabel() {
        nameLabel.with(parent: contentView)
        nameLabel.makeConstraint { constraint in
            constraint.topAnchor.equal(heroImage.bottomAnchor, offset: .x16)
            constraint.trailingAnchor.equal(contentView.trailingAnchor, inset: .x8)
            constraint.leadingAnchor.equal(contentView.leadingAnchor, offset: .x8)
            constraint.bottomAnchor.equal(contentView.bottomAnchor, inset: .x16)
        }
    }
    
    internal func setContent(imageURL: String, heroName: String) {
        heroImage.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(named: "thumbnail-default"))
        
        nameLabel.attributedText = heroName.body().setAlign(.center)
        nameLabel.numberOfLines = 1
        nameLabel.lineBreakMode = .byTruncatingTail
    }
}
