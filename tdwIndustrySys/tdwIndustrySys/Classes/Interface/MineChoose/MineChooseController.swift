//
//  MineChooseController.swift
//  tdwIndustrySys
//
//  Created by user on 2017/12/20.
//  Copyright © 2017年 mobin. All rights reserved.
//  自选 

import UIKit

class MineChooseController: BaseController {
    private lazy var viewModel: MineChooseViewModel = MineChooseViewModel()
    private lazy var presenter: MineChoosePresenter = MineChoosePresenter()
    private lazy var baseView: MineChooseView = MineChooseView(frame: UIScreen.main.bounds)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.adapterView()
    }
    private func setupView() {
        view.addSubview(baseView)
    }

    private func adapterView() {
        presenter.adapter(viewModel: viewModel, view: baseView)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
