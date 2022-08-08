//
//  FilterCell.swift
//  Dota Heroes
//
//  Created by Fahmi Dzulqarnain on 07/08/22.
//

import UIKit

class FilterCell: UICollectionViewCell {
    static let identifier = "FilterCell"
    private let filterLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupFilterLabel()
        setupBackground()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setupBackground() {
        contentView.backgroundColor = .black
        contentView.cornerRadius(spacing: .x8)
    }
    
    private func setupFilterLabel() {
        filterLabel.with(parent: contentView)
        filterLabel.setHeight(by: 20)
        filterLabel.centerYEdgeOf(contentView)
        filterLabel.makeConstraint { constraint in
            constraint.topAnchor.equal(contentView.topAnchor, offset: .x8)
            constraint.trailingAnchor.equal(contentView.trailingAnchor, inset: .x16)
            constraint.leadingAnchor.equal(contentView.leadingAnchor, offset: .x16)
            constraint.bottomAnchor.equal(contentView.bottomAnchor, inset: .x8)
        }
    }
    
    internal func setContent(filterName: String, backgroundColor: UIColor = .black) {
        contentView.backgroundColor = backgroundColor
        filterLabel.attributedText = filterName.body().setAlign(.center)
        filterLabel.textColor = (backgroundColor == .black) ? .white : .black
        filterLabel.numberOfLines = 1
    }
}
