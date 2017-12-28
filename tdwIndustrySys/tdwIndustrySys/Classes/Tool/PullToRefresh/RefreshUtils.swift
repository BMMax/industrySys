//
//  RefreshUtils.swift
//  tdwIndustrySys
//
//  Created by user on 2017/12/26.
//  Copyright © 2017年 mobin. All rights reserved.
//

import Foundation
import UIKit

struct RefreshKitConst {
    //Default const
    static let defaultHeaderHeight: CGFloat = 50.0
    static let defaultFooterHeight: CGFloat = 44.0
    static let defaultLeftWidth: CGFloat    = 50.0
    static let defaultRightWidth: CGFloat   = 50.0
    static let defaultAnimationDuration: TimeInterval = 0.4
    
    
    /// KVO 监听参数
    static let kPathOffSet = "contentOffset"
    static let kPathState = "state"
    static let kPathContentSize = "contentSize"
    
    
    //Tags
    static let headerTag = 100001
    static let footerTag = 100002
    
}


struct PullToRefreshKitHeaderString{
    static let pullDownToRefresh = "下拉可以刷新"
    static let releaseToRefresh = "松开立即刷新"
    static let refreshSuccess = "刷新成功"
    static let refreshFailure = "刷新失败"
    static let refreshing = "正在刷新数据中..."
}

struct PullToRefreshFooterString {
    
    static let pullUpToRefresh = "上拉加载更多数据"
    static let refreshing = "正在刷新中..."
    static let noMoreData = "亲，只有那么多了~"
    static let tapToRefresh = "点击加载更多"
    static let scrollAndTapToRefresh = "上拉或点击加载更多"
}
