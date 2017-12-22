//
//  AppDelegate+Extensions.swift
//  tdwIndustrySys
//
//  Created by user on 2017/12/20.
//  Copyright © 2017年 mobin. All rights reserved.
//

import UIKit

extension AppDelegate {
    
    public func setupRootViewController() {

        window = UIWindow(frame: UIScreen.main.bounds)
        if isNewVersion() { //
            //window?.rootViewController = NewFeatureController()
        } else {

            window?.rootViewController = MainViewController()
        }
        window?.makeKeyAndVisible()
    }
    /** 
     判断是否是新版本
     */
    fileprivate func isNewVersion() -> Bool {

        // 获取当前的版本号
        let versionString = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String

        // 获取到之前的版本号
        let sandboxVersion = UserDefaults.standard.string(forKey: kVersion) ?? "1.0.0"
        // 保存当前版本号
        UserDefaults.standard.set(versionString, forKey: kVersion)
        UserDefaults.standard.synchronize()
        return isHavingNewVersion(newVersion: versionString ?? "1.0.0", currentVersion: sandboxVersion)

    }
}
