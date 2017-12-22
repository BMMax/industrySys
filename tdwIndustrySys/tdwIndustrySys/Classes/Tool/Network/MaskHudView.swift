//
//  MaskView.swift
//  tdwIndustrySys
//
//  Created by user on 2017/12/21.
//  Copyright © 2017年 mobin. All rights reserved.
//

import UIKit
import WHC_Layout

class MaskHudView: UIView, Maskable {
    var maskId: String = "MaskHudView"
    
    private lazy var loading: LoadingView = LoadingView(with: self.loadView)
    private lazy var loadView: UIView = UIView()
    private lazy var grayView: UIView = UIView()
    
    init() {
        super.init(frame: CGRect.zero)
        backgroundColor = UIColor.clear
        setupSubView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubView() {
        
        grayView.mb
            .add(into: self)
            .then {
                $0.alpha = 0.2
                $0.backgroundColor = UIColor.black }
            .layout {GrayViewLayout(view: $0).layoutMaker()}
        
        loadView.mb
            .add(into: self)
            .layout{LoadViewLayout(view: $0).layoutMaker()}
        
        
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        loading.show()
    }
    deinit {
        loading.dismiss()
    }
    
}
//MARK: -- 布局layout
extension MaskHudView {
    
    struct GrayViewLayout: Layoutable {
        
        var view: UIView?
        func layoutMaker() {
            view?.whc_CenterX(0)
                .whc_CenterY(0)
                .whc_Width(120)
                .whc_Height(120)
        }
    }
    
    struct LoadViewLayout: Layoutable {
        var view: UIView?
        func layoutMaker() {
            view?.whc_CenterY(0)
                .whc_CenterX(0)
                .whc_Width(68)
                .whc_Height(55)
            }
    }
}
