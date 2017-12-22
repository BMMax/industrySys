//
//  TransactionController.swift
//  tdwIndustrySys
//
//  Created by user on 2017/12/20.
//  Copyright © 2017年 mobin. All rights reserved.
//  交易 

import UIKit

class TransactionController: BaseController {
    private lazy var viewModel: TransactionViewModel = TransactionViewModel()
    private lazy var presenter: TransactionPresenter = TransactionPresenter()
    private lazy var baseView: TransactionView = TransactionView(frame: UIScreen.main.bounds)

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


