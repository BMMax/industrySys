//
//  MineChooseViewModel.swift
//  tdwIndustrySys
//
//  Created by user on 2017/12/20.
//  Copyright © 2017年 mobin. All rights reserved.
//

import Foundation
struct MineChooseViewModel: ViewModelProtocol {
    func dynamicBinding(load: Loadable?, callBack: @escaping () -> ()) {
        AlamofireClient()
            .request(MineChooseRequest())
//            .load(load)
            .respond(warn: AlterView.show()){ (dict) in
                debugPrint(dict)
            }
    }
}
