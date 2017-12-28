//
//  Footer.swift
//  tdwIndustrySys
//
//  Created by user on 2017/12/28.
//  Copyright © 2017年 mobin. All rights reserved.
//

import Foundation
import UIKit

protocol FooterViewContainer {
    var footerView: UIView {get}
    var textLabel: UILabel {get}
    var indicator: UIActivityIndicatorView {get}
    
    /// 更新footerLabel
    ///
    /// - Parameter model: RefreshMode
    func updateTxetLabelWith(_ model: RefreshFooterMode)
}
protocol FooterRefreshable: FooterViewContainer {
    
    /// footer高度
    var footerHeight: CGFloat {get}
    
    /// 不需要上拉加载更多数据
    func didUpdateToNoMore()
    
    /// 重置成默认
    func didResetToDefault()
    
    /// 结束刷新
    func didEndRefreshing()
    
    /// 开始执行刷新，一次刷新中，只调用一次
    func didBeginRefreshing()
    
    /// 当Scroll触发刷新，这个方法返回是否需要刷新（比如你只想要点击刷新）
    func shouldBeginRefreshingWhenScroll()->Bool
    
    /// 刷新状态
    var refreshMode: RefreshFooterMode {get}
}

public enum RefreshKitFooterText{
    case pullToRefresh
    case tapToRefresh
    case scrollAndTapToRefresh
    case refreshing
    case noMoreData
}

public enum RefreshFooterMode{
    /// 只有Scroll才会触发
    case scroll
    /// 只有Tap才会触发
    case tap
    /// Scroll和Tap都会触发
    case scrollAndTap
}

// MARK: - DefaultFooter
extension FooterRefreshable {
    
    /// 数据
    var textDict: [RefreshKitFooterText: String] {
        var dict = [RefreshKitFooterText: String]()
        dict[.pullToRefresh] = PullToRefreshFooterString.pullUpToRefresh
        dict[.refreshing] = PullToRefreshFooterString.refreshing
        dict[.noMoreData] = PullToRefreshFooterString.noMoreData
        dict[.tapToRefresh] = PullToRefreshFooterString.tapToRefresh
        dict[.scrollAndTapToRefresh] = PullToRefreshFooterString.scrollAndTapToRefresh
        return dict
    }
    /// 刷新状态
    var refreshMode: RefreshFooterMode {
        return .scrollAndTap
    }
    
    /// 更新footerLabel
    func updateTxetLabelWith(_ model: RefreshFooterMode) {
        switch model {
        case .scroll:
            textLabel.text = textDict[.pullToRefresh]
        case .tap:
            textLabel.text = textDict[.tapToRefresh]
        case .scrollAndTap:
            textLabel.text = textDict[.scrollAndTapToRefresh]
        }
    }

    /// footer高度
    var footerHeight: CGFloat {
        return RefreshKitConst.defaultFooterHeight
    }
    /// 开始执行刷新，一次刷新中，只调用一次
    func didBeginRefreshing() {
        footerView.isUserInteractionEnabled = true
        indicator.startAnimating()
        textLabel.text = textDict[.refreshing]
    }

    /// 结束刷新
    func didEndRefreshing() {
        indicator.stopAnimating()
        updateTxetLabelWith(refreshMode)
    }
    
    /// 不需要上拉加载更多数据
    func didUpdateToNoMore() {
        footerView.isUserInteractionEnabled = false
        textLabel.text = textDict[.noMoreData]
    }
    /// 重置成默认
    func didResetToDefault() {
        footerView.isUserInteractionEnabled = true
        updateTxetLabelWith(refreshMode)
    }
    /// 当Scroll触发刷新，这个方法返回是否需要刷新（比如你只想要点击刷新）
    func shouldBeginRefreshingWhenScroll()->Bool {
        return refreshMode != .tap
    }
}


// MARK: -FooterView
class RefreshFooter: UIView, FooterRefreshable{
    
    enum RefreshFooterState {
        case idle
        case refreshing
        case willRefresh
        case noMoreData
    }
    var refreshAction:(()->())?
    var footerView: UIView = UIView()
    var textLabel: UILabel = UILabel()
    var indicator: UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    
    private var scrollView:UIScrollView?

    private var state: RefreshFooterState = .idle{
        willSet{
            if newValue == .refreshing {
                DispatchQueue.main.async {
                    self.didBeginRefreshing()
                    self.refreshAction?()
                }
            } else if newValue == .noMoreData {
                didUpdateToNoMore()
            } else if newValue == .idle {
                didResetToDefault()
            }
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
        autoresizingMask = .flexibleWidth
        setupSubview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        if state == .willRefresh {
            state = .refreshing
        }
    }
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        guard newSuperview != nil && newSuperview is UIScrollView  else {
            if !self.isHidden {
                var inset = scrollView?.contentInset ?? UIEdgeInsets.zero
                inset.bottom = inset.bottom - self.frame.height
                scrollView?.contentInset = inset
            }
            return
        }
        
        scrollView = newSuperview as? UIScrollView
        scrollView?.alwaysBounceVertical = true
        if !self.isHidden {
            var contentInset = scrollView?.contentInset ?? UIEdgeInsets.zero
            contentInset.bottom = contentInset.bottom + self.frame.height
            scrollView?.contentInset = contentInset
        }
        self.frame = CGRect(x: 0,
                            y: scrollView?.contentSize.height ?? 0,
                            width: self.frame.width,
                            height: self.frame.height)
        
        addObserver()
    }
    
    deinit {
        removeObserver()
    }
}

/// 监听
extension RefreshFooter {
    private func addObserver() {
        scrollView?.addObserver(self, forKeyPath: RefreshKitConst.kPathOffSet, options: [.old,.new], context: nil)
        scrollView?.addObserver(self, forKeyPath: RefreshKitConst.kPathContentSize, options: [.old,.new], context: nil)
        scrollView?.panGestureRecognizer.addObserver(self, forKeyPath: RefreshKitConst.kPathState, options: [.old,.new], context: nil)
    }
    private func removeObserver() {
        scrollView?.removeObserver(self, forKeyPath: RefreshKitConst.kPathOffSet, context: nil)
        scrollView?.removeObserver(self, forKeyPath: RefreshKitConst.kPathContentSize, context: nil)
        scrollView?.removeObserver(self, forKeyPath: RefreshKitConst.kPathState, context: nil)
    }
    
    /// KVO
    override func observeValue(forKeyPath keyPath: String?,
                               of object: Any?,
                               change: [NSKeyValueChangeKey : Any]?,
                               context: UnsafeMutableRawPointer?) {
        
        if keyPath == RefreshKitConst.kPathOffSet {
            handleScrollViewOffSet(change)
        }
        guard !self.isHidden else { return }
        if keyPath == RefreshKitConst.kPathContentSize {
            handleScrollViewContentSize(change)
        }
        
        if keyPath == RefreshKitConst.kPathState {
            handleScrollPanState(change)
        }
        
    }
    
    private func handleScrollViewOffSet(_ change: [NSKeyValueChangeKey : Any]?) {
        if state != .idle && self.frame.origin.y != 0 {return}
        guard let scr = scrollView else {return}
        let insetTap = scr.contentInset.top
        let contentHeight = scr.contentSize.height
        let scrollViewHeight = scr.frame.size.height
        
        if insetTap + contentHeight > scrollViewHeight {
            let offSetY = scr.contentOffset.y
            if offSetY > self.y - scrollViewHeight + scr.contentInset.bottom {
                let old = (change?[NSKeyValueChangeKey.oldKey] as AnyObject).cgPointValue
                let new = (change?[NSKeyValueChangeKey.newKey] as AnyObject).cgPointValue
                guard new?.y > old?.y else {return}
                
                guard shouldBeginRefreshingWhenScroll() else {return}
                beginToRefreshing()
            }
        }
    }
    private func handleScrollViewContentSize(_ change: [NSKeyValueChangeKey : Any]?) {
        self.frame = CGRect(x: 0,
                            y: self.scrollView?.contentSize.height ?? 0,
                            width: self.frame.size.width,
                            height: self.frame.size.height)
        

    }
    private func handleScrollPanState(_ change: [NSKeyValueChangeKey : Any]?){
        guard state == .idle,
            let scr = scrollView,
            scrollView?.panGestureRecognizer.state == .ended  else { return }
        let scrInset = scr.contentInset
        let scrOffSet = scr.contentOffset
        let contentSize = scr.contentSize
        
        if scrInset.top + contentSize.height <= scr.height {
            if scr.y >= -1 * scrInset.top {
                guard shouldBeginRefreshingWhenScroll() else{return}
                beginToRefreshing()
            } else {
                if scrOffSet.y > contentSize.height + scrInset.bottom - scr.height {
                    guard shouldBeginRefreshingWhenScroll() else{return}
                    beginToRefreshing()
                }
            }
        }
    }
    
    func beginToRefreshing() {
        if self.window != nil {
            self.state = .refreshing
        } else {
            if state != .refreshing {
                self.state = .willRefresh
            }
        }
    }
    
    func endRefreshing(){
        self.state = .idle
        didEndRefreshing()
    }
    func resetToDefault(){
        self.state = .idle
    }
    func updateToNoMoreData(){
        self.state = .noMoreData
    }
}

// MARK: - 布局
extension RefreshFooter {
    private func setupSubview() {
        footerView.mb.add(into: self).then{
            $0.autoresizingMask = [.flexibleWidth,.flexibleHeight]
            let tap = UITapGestureRecognizer(target: self, action: #selector(tapAction))
            tap.isEnabled = refreshMode != .scroll
            $0.addGestureRecognizer(tap)
            }.frame(CGRect(x: 0,y: 0,width: self.width,height: footerHeight))
        
        updateTxetLabelWith(refreshMode)
        textLabel.mb.add(into: footerView).then{
            $0.font = UIFont.systemFont(ofSize: 14)
            $0.textAlignment = .center
            }.layout{
                $0.sizeToFit()
                $0.center = CGPoint(x: width * 0.5, y: height * 0.5)
            }
        indicator.mb.add(into: footerView).layout{
            $0.sizeToFit()
            $0.center = CGPoint(x: width * 0.5 - 20 - 50, y: frame.size.height/2)
        }
    }
    
    @objc private func tapAction() {
    
        let scro = self.superview as? UIScrollView
        scro?.changeFooter(to: .refreshing)
    }
}

