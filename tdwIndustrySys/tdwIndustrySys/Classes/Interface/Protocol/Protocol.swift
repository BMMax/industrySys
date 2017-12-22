//
//  Protocol.swift
//  tdwIndustrySys
//
//  Created by user on 2017/12/20.
//  Copyright © 2017年 mobin. All rights reserved.
//

import Foundation

protocol ModelProtocol {
    var status: String? {get set}

}

protocol ViewModelProtocol {

    func dynamicBinding(load:Loadable?, callBack: @escaping ()->())
}

protocol ViewOpetation {
    func pushTo()
}

protocol ViewProtocol: Containable {
    var viewModel: ViewModelProtocol? {get set}
    var operation: ViewOpetation? {get set}
}
