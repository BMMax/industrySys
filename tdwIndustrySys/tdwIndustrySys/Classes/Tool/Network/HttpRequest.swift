//
//  HttpRequest.swift
//  MBNetwork
//
//  Created by user on 2017/11/16.
//  Copyright © 2017年 mobin. All rights reserved.
//

import Foundation
import Alamofire

public protocol Request {

    var path: String {get}
    var method: HTTPMethod {get}
    var parameters: [String: Any]? {get}
    var headers: [String: String]? {get}
    var encoding: ParameterEncoding {get}

  //  associatedtype Response: Parsable

}

extension Request {

    var headers: [String: String]? {
        return nil
    }
    var parameters: [String: Any]? {
        return nil
    }
    var encoding: ParameterEncoding {

        return URLEncoding.default
    }
    var method: HTTPMethod {
        return .get
    }

}
