//
//  Presenter.swift
//  tdwIndustrySys
//
//  Created by user on 2017/12/20.
//  Copyright © 2017年 mobin. All rights reserved.
//

import Foundation
class Presenter: ViewOpetation {
    var view: ViewProtocol?
    var viewModel: ViewModelProtocol?

    func pushTo() {}
    func adapter<VM: ViewModelProtocol,V: ViewProtocol>(viewModel: VM,  view: V) {
        self.viewModel = viewModel
        self.view = view

        self.viewModel?.dynamicBinding(load:LoadType.default(container: view)) {[weak self] in
            guard let `self` = self else {return}
            self.view?.viewModel = viewModel
            self.view?.operation = self
        }
    }
}

