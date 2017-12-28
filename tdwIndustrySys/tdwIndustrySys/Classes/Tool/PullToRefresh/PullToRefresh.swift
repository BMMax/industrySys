//
//  PullToRefresh.swift
//  tdwIndustrySys
//
//  Created by user on 2017/12/26.
//  Copyright © 2017年 mobin. All rights reserved.
//

import Foundation
import UIKit

public enum RefresherHeaderState {
    case refreshing //刷新中
    case normal(RefreshResult,TimeInterval)//正常状态
    case removed //移除
}

public enum FooterRefresherState {
    case refreshing //刷新中
    case normal //正常状态，转换到这个状态会结束刷新
    case noMoreData //没有数据，转换到这个状态会结束刷新
    case removed //移除
}



public extension UIScrollView {
    
    public func header(action: @escaping ()->()) {
        self.viewWithTag(RefreshKitConst.headerTag)?.removeFromSuperview()
        let frame = CGRect(x: 0,
                           y: -self.frame.height,
                           width: self.frame.width,
                           height: self.frame.height)
        
        let header = RefreshHeader(frame: frame)
        header.mb.add(into: self).then {
            $0.tag = RefreshKitConst.headerTag
            $0.refreshAction = action
        }
    }
    
    public func changeHeader(to state:RefresherHeaderState){
        let header = self.viewWithTag(RefreshKitConst.headerTag) as? RefreshHeader
        switch state {
        case .refreshing:
            header?.beginRefreshing()
        case .normal(let result, let delay):
            header?.endRefreshing(result,delay: delay)
        case .removed:
            header?.removeFromSuperview()
        }
    }
    

    /// Footer
    public func footer(action: @escaping ()->()) {
        self.viewWithTag(RefreshKitConst.footerTag)?.removeFromSuperview()
        let frame = CGRect(x: 0, y: 0, width: width, height: RefreshKitConst.defaultFooterHeight)
        let footer = RefreshFooter(frame: frame)
        footer.mb.add(into: self).then{
            $0.tag = RefreshKitConst.footerTag
            $0.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        }
        footer.refreshAction = action
    }
    public func changeFooter(to state:FooterRefresherState){
        
        let footer = self.viewWithTag(RefreshKitConst.footerTag) as? RefreshFooter
        switch state {
        case .refreshing:
            footer?.beginToRefreshing()
        case .normal:
            footer?.endRefreshing()
            footer?.resetToDefault()
        case .noMoreData:
            footer?.endRefreshing()
            footer?.updateToNoMoreData()
        case .removed:
            footer?.removeFromSuperview()
        }
    }
}
