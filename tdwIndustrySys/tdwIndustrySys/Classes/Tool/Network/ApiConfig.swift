//
//  ApiConfig.swift
//  MBNetwork
//
//  Created by user on 2017/11/17.
//  Copyright © 2017年 mobin. All rights reserved.
//

import Foundation

public enum HostType: String {

    #if DEBUG
        case BaseApi = "http://liaoyann.com/"
    #else
        case BaseApi = "http://liaoyann.com/"
    #endif

    
}
