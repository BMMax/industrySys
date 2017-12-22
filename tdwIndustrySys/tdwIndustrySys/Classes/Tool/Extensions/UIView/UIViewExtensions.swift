//
//  UIViewExtensions.swift
//  tdwIndustrySys
//
//  Created by user on 2017/12/21.
//  Copyright © 2017年 mobin. All rights reserved.
//

import UIKit
// MARK: - Making `UIView` conforms to `Containable`
extension UIView: Containable {
    /// Return self as container for `UIView`
    ///
    /// - Returns: `UIView` itself
    @objc public func containerView() -> UIView? {
        return self
    }
}
