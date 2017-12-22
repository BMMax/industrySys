//
//  UIView+Extension.swift
//  ScrollTableView
//
//  Created by user on 2017/11/14.
//  Copyright © 2017年 mobin. All rights reserved.
//

import UIKit

public struct UILayout<Base> {
    public let base: Base
    public init(_ base: Base) {
        self.base = base
    }
}

public protocol LayoutCompatible {
    associatedtype LayoutType
    var mb: UILayout<LayoutType> {get}
}

extension LayoutCompatible {
    
    public var mb: UILayout<Self> {
        return UILayout(self)
    }
}

/// snp布局
protocol Layoutable {
    var view: UIView? {get set}
    func layoutMaker()
}


extension UILayout where Base: UIView {
    @discardableResult
    func add(into superView: UIView) -> UILayout {
        superView.addSubview(base)
        return self
    }
    
    @discardableResult
    func then(_ config: (Base) -> Void) -> UILayout {
        config(base)
        return self
    }
    
    @discardableResult
    func layout(_ layout: (Base) -> Void) -> UILayout {
        layout(base)
        return self
    }
     
    @discardableResult
    func frame(_ layout: CGRect) -> UILayout {
        base.frame = layout
        return self
    }
}


internal extension UIView {
    
    /// making autolayout when addSubView
    ///
    /// - Parameters:
    ///   - subview: view to be added
    ///   - insets: insets between subview and view itself
    internal func addSubView(_ subview: UIView, insets: UIEdgeInsets = UIEdgeInsets.zero) {
        
        self.addSubview(subview)
        
        subview.translatesAutoresizingMaskIntoConstraints = false
        
        let views: [String : UIView] = ["subview": subview]
        let layoutStringH: String = "H:|-" + String(describing: insets.left) + "-[subview]-"
            + String(describing: insets.right) + "-|"
        let layoutStringV: String = "V:|-" + String(describing: insets.top) + "-[subview]-"
            + String(describing: insets.bottom) + "-|"
        let contraintsH: [NSLayoutConstraint] = NSLayoutConstraint.constraints(
            withVisualFormat: layoutStringH, options:NSLayoutFormatOptions(rawValue: 0), metrics:nil, views: views
        )
        let contraintsV: [NSLayoutConstraint] = NSLayoutConstraint.constraints(
            withVisualFormat: layoutStringV, options:NSLayoutFormatOptions(rawValue: 0), metrics:nil, views: views
        )
        
        self.addConstraints(contraintsH)
        self.addConstraints(contraintsV)
    }
}

extension NSObject: LayoutCompatible { }
