//
//  InfomationController.swift
//  tdwIndustrySys
//
//  Created by user on 2017/12/20.
//  Copyright © 2017年 mobin. All rights reserved.
//  资讯 

import UIKit

class InfomationController: BaseController {
    private lazy var viewModel: InfomationViewModel = InfomationViewModel()
    private lazy var presenter: InfomationPresenter = InfomationPresenter()
    private lazy var baseView: InfomationView = InfomationView(frame: UIScreen.main.bounds)

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


