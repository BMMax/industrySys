//
//  MineChooseView.swift
//  tdwIndustrySys
//
//  Created by user on 2017/12/20.
//  Copyright © 2017年 mobin. All rights reserved.
//

import UIKit
class MineChooseView: UIView, ViewProtocol{
    var viewModel: ViewModelProtocol?
    var operation: ViewOpetation?

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.random
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
