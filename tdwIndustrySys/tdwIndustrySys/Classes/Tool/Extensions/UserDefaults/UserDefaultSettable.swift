//
//  UserDefaultSettable.swift
//  TianDW
//
//  Created by B2B-IOS on 17/3/6.
//  Copyright © 2017年 tiandiwang. All rights reserved.
//

import Foundation

extension UserDefaults {

    enum defaults: String, UserDefaultSettable {
        
        case isNewVersion
    }


}

public protocol UserDefaultSettable {
    var uniqueKey: String { get }
}

public extension UserDefaultSettable where Self: RawRepresentable, Self.RawValue == String {
    
    public func set(value: Any?){
        UserDefaults.standard.set(value, forKey: uniqueKey)
    }
    
    public var Value: Any? {
        return UserDefaults.standard.value(forKey: uniqueKey)
    }
    
    // 为所有的key加上枚举名作为命名空间，避免重复
    public var uniqueKey: String {
        
        return "\(Self.self).\(rawValue)"
    }
    
    public func set(value: Bool) {

        UserDefaults.standard.set(value, forKey: uniqueKey)
        UserDefaults.standard.synchronize()
    }
 
    public var bool: Bool {
    
        return UserDefaults.standard.bool(forKey: uniqueKey)
    
    }
    
}
