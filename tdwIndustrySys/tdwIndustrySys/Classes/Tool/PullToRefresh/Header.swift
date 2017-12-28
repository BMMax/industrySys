
//
//  File.swift
//  tdwIndustrySys
//
//  Created by user on 2017/12/26.
//  Copyright © 2017年 mobin. All rights reserved.
//

import Foundation
import UIKit

public enum RefreshResult:Int{
    case success = 200
    case failure = 400
    case none = 0
}

public enum RefreshHeaderState:Int{
    case idle = 0
    case pulling = 1
    case refreshing = 2
    case willRefresh = 3
}

public enum RefreshKitHeaderText{
    case pullToRefresh
    case releaseToRefresh
    case refreshSuccess
    case refreshFailure
    case refreshing
}

protocol HeaderRefreshable: HeaderContainer {
    
    /**
     视图的高度
     */
    var headerHeight: CGFloat {get}
    
    /**
     进入刷新状态的回调，在这里将视图调整为刷新中
     */
    func didBeginRefreshingState()

    /// 刷新结束，将要进行隐藏的动画，一般在这里告诉用户刷新的结果
    ///
    /// - Parameter result: 刷新结果
    func willBeginHideAnimation(_ result: RefreshResult)
    
    /// 刷新结束，隐藏的动画结束，一般在这把视图隐藏，各个参数恢复到初值
    ///
    /// - Parameter result: 刷新结果
    func didCompleteHideAnimation(_ result: RefreshResult)
    
    /// 状态改变
    ///
    /// - Parameters:
    ///   - old: 老状态
    ///   - new: 新状态
    func state(didChanged old: RefreshHeaderState, new: RefreshHeaderState)
    
    /// 触发刷新的时候，距离顶部的高度，如果没有实现，则默认触发刷新的距离就是 height
    var heightForFireRefreshing: CGFloat {get}
    
    /// 在刷新状态的时候，距离顶部的高度，默认是height
    var heightForRefreshingState: CGFloat {get}
    
    /// 刷新结束，隐藏header的时间间隔，默认0.4s
    var durationOfHidenAnimation: TimeInterval {get}
    
    
    /// 不在刷新状态的时候，百分比回调，根据百分比来动态的调整刷新视图
    ///
    /// - Parameter percent: 拖拽的百分比，比如一共距离是100，那么拖拽10的时候，percent就是0.1
    func percentUpdateDuringScrolling(_ percent: CGFloat)
    
}
protocol HeaderContainer {
    var headerView: UIView {get}
    var activity: UIActivityIndicatorView {get}
    var textLabel: UILabel {get}
    var imageView: UIImageView {get}
    /// 设置子控件布局
    func setupSubViewLayout()
}
//MARK: - Default
extension HeaderRefreshable {
    
    
    
    var textData: [RefreshKitHeaderText: String]{
        
        //Default text
        var dict = [RefreshKitHeaderText: String]()
        dict[.pullToRefresh] = PullToRefreshKitHeaderString.pullDownToRefresh
        dict[.releaseToRefresh] = PullToRefreshKitHeaderString.releaseToRefresh
        dict[.refreshSuccess] = PullToRefreshKitHeaderString.refreshSuccess
        dict[.refreshFailure] = PullToRefreshKitHeaderString.refreshFailure
        dict[.refreshing] = PullToRefreshKitHeaderString.refreshing
        return dict
    }

    
    var headerHeight: CGFloat {
        
        return RefreshKitConst.defaultHeaderHeight
    }
    
    func didBeginRefreshingState() {
        headerView.isHidden = false
        activity.startAnimating()
        imageView.isHidden = true
        textLabel.text = textData[.refreshing]
    }
    func willBeginHideAnimation(_ result: RefreshResult) {
        activity.stopAnimating()
        imageView.transform = CGAffineTransform.identity
        imageView.isHidden = false
        switch result {
        case .success:
            textLabel.text = textData[.refreshSuccess]
            imageView.image = #imageLiteral(resourceName: "success.png")
        case .failure:
            textLabel.text = textData[.refreshFailure]
            imageView.image = #imageLiteral(resourceName: "failure.png")
        case .none:
            textLabel.text = textData[.pullToRefresh]
            imageView.image = #imageLiteral(resourceName: "arrow_down.png")
        }
    }
    func didCompleteHideAnimation(_ result: RefreshResult) {
        headerView.isHidden = true
        textLabel.text = textData[.pullToRefresh]
        imageView.image = #imageLiteral(resourceName: "arrow_down.png")
    }
    
    func state(didChanged old: RefreshHeaderState, new: RefreshHeaderState) {
        /// 下拉
        if old == .idle && new == .pulling {
            textLabel.text = textData[.releaseToRefresh]
            guard self.imageView.transform == CGAffineTransform.identity else {return}
            
            UIView.animate(withDuration: RefreshKitConst.defaultAnimationDuration, animations: {
                self.imageView.transform = CGAffineTransform(rotationAngle: -CGFloat.pi+0.000001)
            })
        }
        ///恢复
        if old == .pulling && new == .idle {
            textLabel.text = textData[.pullToRefresh]
            guard imageView.transform == CGAffineTransform(rotationAngle: -CGFloat.pi+0.000001) else {return}
            UIView.animate(withDuration: RefreshKitConst.defaultAnimationDuration, animations: {
                self.imageView.transform = CGAffineTransform.identity
            })
        }
    }
    
    var heightForFireRefreshing: CGFloat {
        
        return headerHeight
    }
    
    var heightForRefreshingState: CGFloat {
        
        return headerHeight
    }
    
    var durationOfHidenAnimation: TimeInterval {
        return RefreshKitConst.defaultAnimationDuration
    }
    
    func percentUpdateDuringScrolling(_ percent: CGFloat) {
        headerView.isHidden = false
    }
}

/// MARK: - Header容器
class RefreshHeader: UIView, HeaderRefreshable {
    var imageView: UIImageView = UIImageView()
    var activity: UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    var textLabel: UILabel = UILabel()
    var headerView: UIView = UIView()
    
    var refreshAction: (()->())?
    private var scrollView:UIScrollView?
    private var originalInset:UIEdgeInsets?
    private var insetTDelta:CGFloat = 0.0
    private var currentResult:RefreshResult = .none
    private var delayTimer: Timer?



    private var state: RefreshHeaderState = .idle {
        willSet{
            change(old: state, new: newValue)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isUserInteractionEnabled = true
        self.backgroundColor = UIColor.clear
        self.autoresizingMask = .flexibleWidth
        setupSubViewLayout()
    }
    
    func setupSubViewLayout() {
        
        headerView.mb.add(into: self).layout {
            let bounds = CGRect(x: 0,y: self.height - headerHeight,width: self.frame.width,height: headerHeight)
            $0.frame = bounds
        }
        imageView.mb
            .add(into: headerView)
            .then{
                $0.image = #imageLiteral(resourceName: "arrow_down.png")
                $0.sizeToFit()
            }.layout{
                $0.mb.frame(CGRect(x: 0, y: 0, width: 20, height: 20))
                $0.centerX = headerView.frame.width*0.5 - 40
                $0.centerY = headerView.frame.height*0.5
        }
        
        activity.mb
            .add(into: headerView)
                .layout {
                    $0.centerX = imageView.centerX - 20
                    $0.centerY = imageView.centerY
                }



        textLabel.mb
            .add(into: headerView)
                .then{
                    $0.text = textData[.pullToRefresh]
                    $0.font = UIFont.systemFont(ofSize: 14)
                    $0.textAlignment = .center
                }.layout{
                    $0.height = 40
                    $0.width = 140
                    $0.centerX = headerView.width * 0.5 + 20
                    $0.centerY = headerView.height * 0.5
            }
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
        guard newSuperview is UIScrollView else { return }

        scrollView = newSuperview as? UIScrollView
        scrollView?.alwaysBounceVertical = true
        originalInset = scrollView?.contentInset
        addObservers()
    }

    deinit {
        clearTimer()
        removeObserver()
    }
}


// MARK: - 监听
extension RefreshHeader {
    
    //刷新状态的改变
    private func change(old ostate: RefreshHeaderState, new nstate: RefreshHeaderState){
        state(didChanged: ostate, new: nstate)
        switch nstate {
        case .idle:
            guard ostate == .refreshing else {return}
            UIView.animate(withDuration: RefreshKitConst.defaultAnimationDuration, animations: {
                guard var old = self.scrollView?.contentInset else {return}
                old.top = old.top + self.insetTDelta
                self.scrollView?.contentInset = old
                
            }, completion: { (_) in
                self.didCompleteHideAnimation(self.currentResult)
            })
        case .refreshing:
            DispatchQueue.main.async {
                let insetHeight = self.heightForRefreshingState
                let fireHeight = self.heightForFireRefreshing
                let offSetY = self.scrollView?.contentOffset.y ?? 0
                let topShowOffsetY = -1.0 * (self.originalInset ?? UIEdgeInsets.zero).top
                let normal2pullingOffsetY = topShowOffsetY - fireHeight
                let currentOffset = self.scrollView?.contentOffset
                
                UIView.animate(withDuration: RefreshKitConst.defaultAnimationDuration, animations: {
                    let top = (self.originalInset?.top ?? 0) + insetHeight
                    var old = self.scrollView?.contentInset
                    old?.top = top
                    self.scrollView?.contentInset = old ?? UIEdgeInsets.zero
                    
                    if offSetY > normal2pullingOffsetY { //手动触发
                        self.scrollView?.contentOffset = CGPoint(x: 0, y: -1 * top)
                    } else{ //release.防止跳动
                        self.scrollView?.contentOffset = currentOffset ?? CGPoint.zero
                    }
                    
                }, completion: { (_) in
                    self.refreshAction?()
                })
                self.percentUpdateDuringScrolling(1.0)
                self.didBeginRefreshingState()
            }
        default:
            break
            
        }
    }
    
    private func addObservers() {
        scrollView?.addObserver(self,
                                forKeyPath: RefreshKitConst.kPathOffSet,
                                options: [.new, .old],
                                context: nil)
    }
    private func removeObserver() {
        scrollView?.removeObserver(self,
                                   forKeyPath: RefreshKitConst.kPathOffSet,
                                   context: nil)
    }


    /// KVO值监听
    override func observeValue(forKeyPath keyPath: String?,
                               of object: Any?,
                               change: [NSKeyValueChangeKey : Any]?,
                               context: UnsafeMutableRawPointer?) {

        guard self.isUserInteractionEnabled else { return }

        if keyPath == RefreshKitConst.kPathOffSet {
            handleScrollOffSet(change)
        }
    }

    /// 处理scollView contentOffset的改变
    private func handleScrollOffSet(_ change: [NSKeyValueChangeKey : Any]?) {
        let insetHeight: CGFloat = heightForRefreshingState
        let fireHeight: CGFloat = heightForFireRefreshing
        guard let scro = scrollView else { return }
        if state == .refreshing {
            guard self.window != nil,
                let inset = originalInset else {return}
            let offset = scro.contentOffset
            var insetT = -1 * offset.y > inset.top ? (-1 * offset.y) : inset.top
            insetT = insetT > insetHeight + inset.top ? insetHeight + inset.top:insetT
            var oldInset = scro.contentInset
            oldInset.top = insetT
            scro.contentInset = oldInset
            insetTDelta = inset.top - insetT
            return
        }
        
        originalInset = scro.contentInset
        let offSetY = scro.contentOffset.y
        let topShowOffSetY = -1.0 * (originalInset ?? UIEdgeInsets.zero).top
        guard offSetY <= topShowOffSetY else { return }
        
        let normal2pullingOffsetY = topShowOffSetY - fireHeight
        if scro.isDragging {
            if state == .idle && offSetY < normal2pullingOffsetY {
                self.state = .pulling
            } else if state == .pulling && offSetY >= normal2pullingOffsetY {
                state = .idle
            }
        }else if state == .pulling {
            beginRefreshing()
            return
        }
        
        let percent = (topShowOffSetY - offSetY) / fireHeight
        //防止在结束刷新的时候，percent的跳跃
        if let oldOffset = (change?[NSKeyValueChangeKey.oldKey] as AnyObject).cgPointValue {
            let oldPercent = (topShowOffSetY - oldOffset.y)/fireHeight
            if oldPercent >= 1.0 && percent == 0.0{
                return
            }else {
                percentUpdateDuringScrolling(percent)
            }
        } else {
            percentUpdateDuringScrolling(percent)
        }
    }

    
    ///MARK: -Api
    public func beginRefreshing() {
        guard self.window != nil else {
            if state != .refreshing {
                state = .willRefresh
            }
            return
        }
        self.state = .refreshing
    }
    
    public func endRefreshing(_ result: RefreshResult,delay: TimeInterval = 0.0) {
        self.willBeginHideAnimation(result)
        
        self.delayTimer = Timer(timeInterval: delay,
                                target: self,
                                selector: #selector(updateState),
                                userInfo: nil,
                                repeats: false)
        guard let timer = self.delayTimer else {return}
        RunLoop.main.add(timer, forMode: .commonModes)
    }
    
    @objc private func updateState() {
        self.state = .idle
        clearTimer()
    }
    
    private func clearTimer() {
        guard let timer = self.delayTimer else { return }
        timer.invalidate()
        self.delayTimer = nil
    }
}




