//
//  AutoLayout.swift
//  Dota Heroes
//
//  Created by Fahmi Dzulqarnain on 06/08/22.
//

import UIKit

public protocol LayoutAnchor {
    func constraint(equalTo anchor: Self, constant: CGFloat) -> NSLayoutConstraint
    func constraint(greaterThanOrEqualTo anchor: Self, constant: CGFloat) -> NSLayoutConstraint
    func constraint(lessThanOrEqualTo anchor: Self, constant: CGFloat) -> NSLayoutConstraint
}

extension NSLayoutAnchor: LayoutAnchor {}

public struct LayoutProperty<Anchor: LayoutAnchor> {
    fileprivate let anchor: Anchor
}

public class LayoutProxy {
    public lazy var widthAnchor = property(with: view.widthAnchor)
    public lazy var heightAnchor = property(with: view.heightAnchor)
    public lazy var topAnchor = property(with: view.topAnchor)
    public lazy var bottomAnchor = property(with: view.bottomAnchor)
    public lazy var leftAnchor = property(with: view.leftAnchor)
    public lazy var rightAnchor = property(with: view.rightAnchor)
    public lazy var leadingAnchor = property(with: view.leadingAnchor)
    public lazy var trailingAnchor = property(with: view.trailingAnchor)
    public lazy var centerYAnchor = property(with: view.centerYAnchor)
    public lazy var centerXAnchor = property(with: view.centerXAnchor)

    private let view: UIView

    fileprivate init(view: UIView) {
        self.view = view
    }

    private func property<A: LayoutAnchor>(with anchor: A) -> LayoutProperty<A> {
        return LayoutProperty(anchor: anchor)
    }
}

public extension LayoutProperty {
    func equal(_ otherAnchor: Anchor) {
        anchor.constraint(equalTo: otherAnchor, constant: 0).isActive = true
    }

    func equal(_ otherAnchor: Anchor, offset constant: CGFloat) {
        anchor.constraint(equalTo: otherAnchor, constant: constant).isActive = true
    }

    func equal(_ otherAnchor: Anchor, offset constant: Spacing) {
        anchor.constraint(equalTo: otherAnchor, constant: constant.rawValue).isActive = true
    }

    func equal(_ otherAnchor: Anchor, inset constant: CGFloat) {
        anchor.constraint(equalTo: otherAnchor, constant: -constant).isActive = true
    }

    func equal(_ otherAnchor: Anchor, inset constant: Spacing) {
        anchor.constraint(equalTo: otherAnchor, constant: -(constant.rawValue)).isActive = true
    }

    func greaterThanOrEqual(_ otherAnchor: Anchor) {
        anchor.constraint(greaterThanOrEqualTo: otherAnchor, constant: 0).isActive = true
    }

    func greaterThanOrEqual(_ otherAnchor: Anchor, offset constant: CGFloat) {
        anchor.constraint(greaterThanOrEqualTo: otherAnchor, constant: constant).isActive = true
    }

    func greaterThanOrEqual(_ otherAnchor: Anchor, offset constant: Spacing) {
        anchor.constraint(greaterThanOrEqualTo: otherAnchor, constant: constant.rawValue).isActive = true
    }

    func greaterThanOrEqual(_ otherAnchor: Anchor, inset constant: CGFloat) {
        anchor.constraint(greaterThanOrEqualTo: otherAnchor, constant: -constant).isActive = true
    }

    func greaterThanOrEqual(_ otherAnchor: Anchor, inset constant: Spacing) {
        anchor.constraint(greaterThanOrEqualTo: otherAnchor, constant: -(constant.rawValue)).isActive = true
    }

    func lessThanOrEqual(_ otherAnchor: Anchor) {
        anchor.constraint(lessThanOrEqualTo: otherAnchor, constant: 0).isActive = true
    }

    func lessThanOrEqual(_ otherAnchor: Anchor, offset constant: CGFloat) {
        anchor.constraint(lessThanOrEqualTo: otherAnchor, constant: constant).isActive = true
    }
    
    func lessThanOrEqual(_ otherAnchor: Anchor, offset constant: Spacing) {
        anchor.constraint(lessThanOrEqualTo: otherAnchor, constant: constant.rawValue).isActive = true
    }

    func lessThanOrEqual(_ otherAnchor: Anchor, inset constant: CGFloat) {
        anchor.constraint(lessThanOrEqualTo: otherAnchor, constant: -constant).isActive = true
    }
    
    func lessThanOrEqual(_ otherAnchor: Anchor, inset constant: Spacing) {
        anchor.constraint(lessThanOrEqualTo: otherAnchor, constant: -(constant.rawValue)).isActive = true
    }
}

public extension UIView {
    func makeConstraint(using closure: (LayoutProxy) -> Void) {
        self.translatesAutoresizingMaskIntoConstraints = false
        closure(LayoutProxy(view: self))
    }
    
    func centerXEdgeOf(_ v: UIView!, by spacing: Spacing = .x0) {
        self.makeConstraint { constraints in
            constraints.centerXAnchor.equal(v.centerXAnchor, offset: spacing)
        }
    }
    
    func centerYEdgeOf(_ v: UIView!, by spacing: Spacing = .x0) {
        self.makeConstraint { constraints in
            constraints.centerYAnchor.equal(v.centerYAnchor, offset: spacing)
        }
    }
    
    func centerXandYEdgeOf(_ v: UIView!, by spacing: Spacing = .x0) {
        self.centerXEdgeOf(v, by: spacing)
        self.centerYEdgeOf(v, by: spacing)
    }
    
    func setHeight(by height: CGFloat) {
        guard self.translatesAutoresizingMaskIntoConstraints else { return }
        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    func setWidth(by width: CGFloat) {
        guard self.translatesAutoresizingMaskIntoConstraints else { return }
        self.translatesAutoresizingMaskIntoConstraints = false
        self.widthAnchor.constraint(equalToConstant: width).isActive = true
    }
}

public enum Spacing: CGFloat {
    case x0 = 0
    case x2 = 2.0
    case x4 = 4.0
    case x8 = 8.0
    case x12 = 12.0
    case x16 = 16.0
    case x20 = 20.0
    case x24 = 24.0
    case x32 = 32.0
    case x40 = 40.0
    case x48 = 48.0
    case x64 = 64.0
    
    public var minus: CGFloat {
        self.rawValue * -1
    }
}
