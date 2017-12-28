//
//  View+Frame.swift
//  MBNetwork
//
//  Created by user on 2017/12/18.
//  Copyright © 2017年 mobin. All rights reserved.
//

import UIKit

extension UIView {
    
    public var screenW: CGFloat {
        return UIScreen.main.bounds.width
    }

    public var screenH: CGFloat {

        return UIScreen.main.bounds.height
    }

    public var width: CGFloat {
        set{
            var rect = self.frame
            rect.size.width = newValue
            self.frame = rect
        }

        get {
            return self.frame.width
        }
    }

    public var height: CGFloat {
        set{
            var rect = self.frame
            rect.size.height = newValue
            self.frame = rect
        }
        get{
            return self.frame.height
        }
    }

    public var size: CGSize {
        set {
            var rect = self.frame
            rect.size = newValue
            self.frame = rect
        }

        get {
            return self.frame.size
        }
    }

    public var x: CGFloat {
        set {
            var rect = self.frame
            rect.origin.x = newValue
            self.frame = rect
        }

        get {
            return self.frame.minX
        }
    }

    public var y: CGFloat {
        set {
            var rect = self.frame
            rect.origin.y = newValue
            self.frame = rect
        }

        get {
            return self.frame.minY
        }
    }
    
    
    
    public var left: CGFloat {
        get {
            return self.x
        } set(value) {
            self.x = value
        }
    }
    
    
    public var right: CGFloat {
        get {
            return self.x + self.width
        } set(value) {
            self.x = value - self.width
        }
    }
    
    
    public var top: CGFloat {
        get {
            return self.y
        } set(value) {
            self.y = value
        }
    }
    
    
    public var bottom: CGFloat {
        get {
            return self.y + self.height
        } set(value) {
            self.y = value - self.height
        }
    }


    public var xy: CGPoint {
        set {
            var rect = self.frame
            rect.origin = newValue
            self.frame = rect
        }

        get {
            return self.frame.origin
        }
    }


    /// 锚点x
    public var anchorX: CGFloat {
        set {
            var anchor = self.layer.anchorPoint
            anchor.x = newValue
            self.layer.anchorPoint = anchor
        }

        get {
            return self.layer.anchorPoint.x
        }
    }

    /// 锚点y
    public var anchorY: CGFloat {
        set {
            var anchor = self.layer.anchorPoint
            anchor.y = newValue
            self.layer.anchorPoint = anchor
        }

        get {
            return self.layer.anchorPoint.y
        }
    }



    public var maxX: CGFloat {
        set {
            self.width = newValue - self.x
        }

        get {
            return self.frame.maxX
        }
    }

    public var maxY: CGFloat {
        set {
            self.height = newValue - self.y
        }

        get {
            return self.frame.maxY
        }
    }

    public var midX: CGFloat {
        set {
            self.width = newValue * 2
        }

        get {
            return self.frame.minX + self.frame.width / 2
        }
    }

    public var midY: CGFloat {
        set {
            self.height = newValue * 2
        }

        get {
            return self.frame.minY + self.frame.height / 2
        }
    }


    public var centerX: CGFloat {
        set {
            var center = self.center
            center.x = newValue
            self.center = center
        }

        get {
            return self.center.x
        }
    }

    public var centerY: CGFloat {
        set {
            var center = self.center
            center.y = newValue
            self.center = center
        }

        get {
            return self.center.y
        }
    }
}
