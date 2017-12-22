//
//  MarketQuotationController.swift
//  tdwIndustrySys
//
//  Created by user on 2017/12/20.
//  Copyright © 2017年 mobin. All rights reserved.
//  行情 

import UIKit

class MarketQuotationController: BaseController {
    private lazy var viewModel: MarketQuotationViewModel = MarketQuotationViewModel()
    private lazy var presenter: MarketQuotationPresenter = MarketQuotationPresenter()
    private lazy var baseView: MarketQuotationView = MarketQuotationView(frame: UIScreen.main.bounds)

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

