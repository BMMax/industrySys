//
//  Load.swift
//  MBNetwork
//
//  Created by user on 2017/12/13.
//  Copyright © 2017年 mobin. All rights reserved.
//

import UIKit


/// Mask protocol for `Loadable`, View that conforms to this protocol will be treated as mask
public protocol Maskable {
    var maskId: String { get }
}


/// Container protocol for `Loadable`, Objects conforms to this protocol can be used as container for the mask
public protocol Containable {
    func containerView() -> UIView?
}

public extension Containable {
    /// Get latest mask on container
    ///
    /// - Returns: If exists, return latest mask, otherwise return nil
    internal func latestMask() -> UIView? {
        var latestMask: UIView? = nil
        if let container = containerView() {
            for subview in container.subviews {
                if let _ = subview as? Maskable {
                    latestMask = subview
                }
            }
        }
        return latestMask
    }
}




/// Protocol used for showing mask on specified container when requesting (such as add `UIActivityIndicatorView` on `UIViewcontroller`'s view when request begins, and remove it when request ends). Object conforms to this protocol can be used by load method of DataRequest
public protocol Loadable {
    /// Mask
    ///
    /// - Returns: Object that conforms to `Maskable` protocol
    func mask() -> Maskable?

    /// Inset
    ///
    /// - Returns: The inset between mask and maskContainer
    func inset() -> UIEdgeInsets

    /// Mask Container
    ///
    /// - Returns: Object that conforms to `Containable` protocol
    func maskContainer() -> Containable?

    /// Request begin
    func begin()

    /// Request end
    func end()
}

// MARK: - Loadable
public extension Loadable {
    func mask() -> Maskable? {
        return MaskHudView()
    }

    func inset() -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }

    func maskContainer() -> Containable? {
        return nil
    }

    func begin() {
        show()
    }

    func end() {
        hide()
    }

    /// Default show method for `Loadable`, calling this method will add mask on maskContainer
    func show() {
        if let mask = self.mask() as? UIView {
            var isHidden = false
            if let _ = self.maskContainer()?.latestMask() {
                isHidden = true
            }
            self.maskContainer()?.containerView()?.addSubView(mask, insets: self.inset())
            mask.isHidden = isHidden

            if let container = self.maskContainer(), let scrollView = container as? UIScrollView {
                scrollView.setContentOffset(scrollView.contentOffset, animated: false)
                scrollView.isScrollEnabled = false
            }
        }
    }

    /// Default hide method for `Loadable`, calling this method will remove mask from maskContainer
    func hide() {
        if let latestMask = self.maskContainer()?.latestMask() {
            latestMask.removeFromSuperview()

            if let container = self.maskContainer(), let scrollView = container as? UIScrollView {
                if false == latestMask.isHidden {
                    scrollView.isScrollEnabled = true
                }
            }
        }
    }
}


/// Load type enum
///
/// - none: No mask will be shown on maskContainer
/// - `default`: Show mask on container
public enum LoadType {
    case none
    case `default`(container: Containable)
}

// MARK: - LoadType
extension LoadType: Loadable {
    public func maskContainer() -> Containable? {
        switch self {
        case .default(let container):
            return container
        case .none:
            return nil
        }
    }

    public func begin() {
        show()
    }

    public func end() {
        hide()
    }
}

//MARK: - Error
public enum ClientError: Error {

    case errorCode(String)
    case connectionFaild
}


/// Warn protocol. Conforming to this protocol to customize the way of warning messages displayed when error occured
public protocol Warnable: Messageable {
    func show(error: ClientError, message: String?)
}

public extension Messageable {
    func messageContainer() -> Containable? {
        return nil
    }
}

/// Message protocol
public protocol Messageable {
    func messageContainer() -> Containable?
}




