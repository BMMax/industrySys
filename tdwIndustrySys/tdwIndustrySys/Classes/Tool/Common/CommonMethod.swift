//
//  CommonMethod.swift
//  tdwIndustrySys
//
//  Created by user on 2017/12/20.
//  Copyright © 2017年 mobin. All rights reserved.
//

import Foundation

//MARK: 自定义打印
func debugPrint<T>(_ message : T, file: String = #file, funcName: String = #function, lineNum: Int = #line) {
    
    #if DEBUG
        
        let fileName = (file as NSString).lastPathComponent
        let className = (fileName as NSString).deletingPathExtension
        
        print("\(fileName):(line:\(lineNum))-[\(className) \(funcName)]-\(message)")
        
    #endif
    
}
//MARK: 判断是否有版本更新 true 需要更新 false 不需要更新
public func isHavingNewVersion(newVersion:String,currentVersion:String) -> Bool{

    if newVersion == currentVersion {
        return false
    }
    let newVersionArray:[String] = newVersion.split(separator: ".").map(String.init)
    let currentVersionArray:[String] = currentVersion.split(separator: ".").map(String.init)

    if newVersionArray.count == 0 { return false }
    if currentVersionArray.count == 0 { return false }
    let newCount: Int = newVersionArray.count
    let curCount: Int = currentVersionArray.count
    let count = newCount <= curCount ? newCount : curCount
    for  i in 0 ..< count {
        let n = Int(newVersionArray[i]) ?? 0
        let c = Int(currentVersionArray[i]) ?? 1
        if n < c { return false }
        if n > c { return true  }
        continue
    }
    return newCount <= curCount ? false : true
}

///GCD 延时
public func delay(_ delay:Double, closure:@escaping ()->()) {
    DispatchQueue.main.asyncAfter(
        deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
}

public func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l < r
    case (nil, _?):
        return true
    default:
        return false
    }
}

public func > <T: Comparable> (lhs: T?, rhs: T?) -> Bool {
    switch (lhs,rhs) {
    case let (l?,r?):
        return l < r
    default:
        return rhs < lhs
    }
}


