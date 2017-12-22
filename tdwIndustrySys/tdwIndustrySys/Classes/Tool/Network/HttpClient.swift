//
//  HttpClient.swift
//  MBNetwork
//
//  Created by user on 2017/11/16.
//  Copyright © 2017年 mobin. All rights reserved.
//

import Foundation
import Alamofire


protocol Client {

    func request<T: Request>(_ request: T) -> Self
    func load(_ load: Loadable?) -> Self
    func respond(warn: Warnable?, handler: @escaping ([String: Any]) -> ())

}

extension Client {

    var host: String {
        return HostType.BaseApi.rawValue
    }
}

class AlamofireClient: Client {

    private var dataRequest: DataRequest?
    @discardableResult
    func load(_ load: Loadable?) -> Self {
        load?.begin()
        dataRequest?.response { _ in load?.end() }
        return self
    }

    @discardableResult
    func request<T: Request>(_ request: T) -> Self{
        let urlString = host.appending(request.path)
        dataRequest = Alamofire.request(urlString,
                          method: request.method,
                          parameters: request.parameters,
                          encoding: request.encoding,
                          headers: request.headers)
        return self
    }


    func respondData(warn: Warnable?,handler: @escaping (Data) -> ()) {

        dataRequest?.responseData(completionHandler: { (response) in

            switch response.result {
            case .success:
                if let data = response.data {
                    handler(data)
                }
            case .failure:
                print("网络失败")
                if let err = response.error {
                    DispatchQueue.main.async { //显示错误
                        if let warn = warn {
                            warn.show(error: .connectionFaild, message: err.localizedDescription)
                        }
                    }
                }
            }
        })
    }

    func respond(warn: Warnable?, handler: @escaping ([String: Any]) -> ()){

        dataRequest?.responseJSON { (response) in

//            if let err = response.error {
//                DispatchQueue.main.async { //显示错误
//                    if let warn = warn {
//                        warn.show(error: .connectionFaild, message: err.localizedDescription)
//                    }
//                }
//            } else {
                switch response.result {
                case .success:
                    print("\n---------response---------\n\(response.result.value ?? "成功")")
                    if let value = response.result.value as? [String: Any] {
                        if let code = value["status"] as? String {
                            if code == "1" {
                                handler(value)
                            }else {
                                if let errMessage = value["message"] as? String {
                                    warn?.show(error: .errorCode(code), message: errMessage)
                                }
                            }
                        }
                    }
                case .failure:
                    print("\n---------response---------\n\("获取失败")")
                    if let err = response.error {
                    DispatchQueue.main.async { //显示错误
                        if let warn = warn {
                            warn.show(error: .connectionFaild, message: err.localizedDescription)
                        }
                    }
                }
            }
        }
    }
}







