//
//  HttpParsable.swift
//  MBNetwork
//
//  Created by user on 2017/11/16.
//  Copyright © 2017年 mobin. All rights reserved.
//

import Foundation

public protocol Parsable {

    static func parse(encodedData: Data) -> Self? 
}
