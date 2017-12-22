//
//  UIImageExtensions.swift
//  tdwIndustrySys
//
//  Created by user on 2017/12/21.
//  Copyright © 2017年 mobin. All rights reserved.
//

import UIKit
import Kingfisher
extension UIImageView {

    public func setImage(with resource: String?,
                         placeholder: Placeholder? = nil,
                         options: KingfisherOptionsInfo? = nil,
                         progressBlock: DownloadProgressBlock? = nil,
                         completionHandler: CompletionHandler? = nil) {

        let url = URL(string: resource ?? "")
        self.kf.setImage(with: url,
                         placeholder: placeholder,
                         options: options,
                         progressBlock: progressBlock,
                         completionHandler: completionHandler)
    }
}
