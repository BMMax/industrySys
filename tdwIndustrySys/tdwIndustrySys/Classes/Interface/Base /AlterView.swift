//
//  AlterView.swift
//  tdwIndustrySys
//
//  Created by user on 2017/12/25.
//  Copyright © 2017年 mobin. All rights reserved.
//

import UIKit
struct AlterView {
    
    public static func show(title: String? = nil, message: String? = nil, handler: (()->Void)? = nil) -> UIAlertController {
        
        
        let alter = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let sure = UIAlertAction(title: "确定", style: .default) { (_) in handler?()}
        alter.addAction(sure)
        
        guard let _ = handler else { return alter}
        let cancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        alter.addAction(cancel)
        //alter.view.tintColor = MainGreenColor
        //present(alter, animated: true, completion: nil)
        return alter
        
    }
}

extension UIAlertController: Warnable{
    public func show(error: ClientError, message: String?) {
    
        self.title = "网络错误"
        self.message = message
        UIApplication.shared.windows
            .last?
            .rootViewController?
            .present(self,
                     animated: true,
                     completion: nil)
    }
}
