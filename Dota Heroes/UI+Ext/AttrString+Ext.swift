//
//  AttrString+Ext.swift
//  Dota Heroes
//
//  Created by Fahmi Dzulqarnain on 07/08/22.
//

import UIKit

public extension NSAttributedString {
    func setAlign(_ alignment: NSTextAlignment = .left) -> NSAttributedString {
        guard !string.isEmpty else {
            return self
        }
        let allRange = NSRange(location: 0, length: length)
        let mutableCopy = NSMutableAttributedString(attributedString: self)
        let style: NSMutableParagraphStyle = mutableCopy.attribute(.paragraphStyle, at: 0, effectiveRange: nil) as! NSMutableParagraphStyle
        style.alignment = alignment
        mutableCopy.addAttribute(NSAttributedString.Key.paragraphStyle, value: style, range: allRange)
        return mutableCopy
    }
    
    func setColor(foregroundColor: UIColor = .black) -> NSAttributedString {
        guard !string.isEmpty else {
            return self
        }
        let allRange = NSRange(location: 0, length: length)
        let mutableCopy = NSMutableAttributedString(attributedString: self)
        
        mutableCopy.addAttribute(NSAttributedString.Key.foregroundColor, value: foregroundColor, range: allRange)
        
        return mutableCopy
    }
}

public extension String {
    func title() -> NSAttributedString {
        return self.setAttribute(lineHeight: 24)
    }
    
    func body() -> NSAttributedString {
        return self.setAttribute(lineHeight: 20)
    }
    
    func setAttribute(strikethrough: Bool = false,
                      underlineStyle: NSUnderlineStyle = NSUnderlineStyle(rawValue: 0),
                      underlinePattern: NSUnderlineStyle = NSUnderlineStyle(rawValue: 0),
                      paragraphStyle: NSMutableParagraphStyle = NSMutableParagraphStyle(),
                      linkAttribute: URL? = nil,
                      lineHeight: CGFloat? = nil) -> NSAttributedString {
        var attributes: [NSAttributedString.Key : Any] = [:]
        attributes[NSAttributedString.Key.strikethroughStyle] = strikethrough ? 1 : 0
        attributes[NSAttributedString.Key.underlineStyle] = underlinePattern.rawValue|underlineStyle.rawValue
        
        if let lineHeight = lineHeight {
            paragraphStyle.minimumLineHeight = lineHeight
            paragraphStyle.maximumLineHeight = lineHeight
            
            attributes[NSAttributedString.Key.paragraphStyle] = paragraphStyle
        } else {
            attributes[NSAttributedString.Key.paragraphStyle] = paragraphStyle
        }
        
        if let link: Any = linkAttribute {
            attributes.updateValue(link, forKey: .link)
        }
        
        return NSMutableAttributedString(string: self, attributes: attributes)
    }
}

public enum Typography: CGFloat {
    case x10 = 10
    case x12 = 12
    case x14 = 14
    case x16 = 16
    case x18 = 18
    case x20 = 20
    case x24 = 24
    case x28 = 28
    case x32 = 32
    case x48 = 48
    case x64 = 64
}
