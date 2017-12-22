//
//  View+Frame.swift
//  MBNetwork
//
//  Created by user on 2017/12/18.
//  Copyright © 2017年 mobin. All rights reserved.
//

import UIKit

extension UILayout where Base: UIView {

    public var screenW: CGFloat {
        return UIScreen.main.bounds.width
    }

    public var screenH: CGFloat {

        return UIScreen.main.bounds.height
    }

    public var width: CGFloat {
        set{
            var rect = base.frame
            rect.size.width = newValue
            base.frame = rect
        }

        get {
            return base.frame.width
        }
    }

    public var height: CGFloat {
        set{
            var rect = base.frame
            rect.size.height = newValue
            base.frame = rect
        }
        get{
            return base.frame.height
        }
    }

    public var size: CGSize {
        set {
            var rect = base.frame
            rect.size = newValue
            base.frame = rect
        }

        get {
            return base.frame.size
        }
    }

    public var x: CGFloat {
        set {
            var rect = base.frame
            rect.origin.x = newValue
            base.frame = rect
        }

        get {
            return base.frame.minX
        }
    }

    public var y: CGFloat {
        set {
            var rect = base.frame
            rect.origin.y = newValue
            base.frame = rect
        }

        get {
            return base.frame.minY
        }
    }


    public var xy: CGPoint {
        set {
            var rect = base.frame
            rect.origin = newValue
            base.frame = rect
        }

        get {
            return base.frame.origin
        }
    }


    /// 锚点x
    public var anchorX: CGFloat {
        set {
            var anchor = base.layer.anchorPoint
            anchor.x = newValue
            base.layer.anchorPoint = anchor
        }

        get {
            return base.layer.anchorPoint.x
        }
    }

    /// 锚点y
    public var anchorY: CGFloat {
        set {
            var anchor = base.layer.anchorPoint
            anchor.y = newValue
            base.layer.anchorPoint = anchor
        }

        get {
            return base.layer.anchorPoint.y
        }
    }



    public var maxX: CGFloat {
        set {
            self.width = newValue - self.x
        }

        get {
            return base.frame.maxX
        }
    }

    public var maxY: CGFloat {
        set {
            self.height = newValue - self.y
        }

        get {
            return base.frame.maxY
        }
    }

    public var midX: CGFloat {
        set {
            self.width = newValue * 2
        }

        get {
            return base.frame.minX + base.frame.width / 2
        }
    }

    public var midY: CGFloat {
        set {
            self.height = newValue * 2
        }

        get {
            return base.frame.minY + base.frame.height / 2
        }
    }


    public var centerX: CGFloat {
        set {
            var center = base.center
            center.x = newValue
            base.center = center
        }

        get {
            return base.center.x
        }
    }

    public var centerY: CGFloat {
        set {
            var center = base.center
            center.y = newValue
            base.center = center
        }

        get {
            return base.center.y
        }
    }

    public var center: CGPoint {
        set {
            var center = base.center
            center = newValue
            base.center = center
        }

        get {
            return base.center
        }
    }
}
