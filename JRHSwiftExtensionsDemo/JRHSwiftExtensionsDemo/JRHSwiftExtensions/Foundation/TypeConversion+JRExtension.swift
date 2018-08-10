//
//  TypeConversionJRExtension.swift
//  JRHSwiftExtensionsDemo
//
//  Created by huojiarong on 2018/5/29.
//  Copyright © 2018年 huojiarong. All rights reserved.
//

import UIKit


//MARK: OC类型转换成swift类型
extension NSString {
    /// 转换成 String
    public func toStrig() -> String {
        return String(self)
    }
}

extension CGFloat {
    /// 转换成 Float
    public func toFloat() -> Float {
        return Float(self)
    }
}

extension NSArray {
    /// 转换成 Array
    public func toArray() -> Array<Any> {
        return self as! Array
    }
}
extension NSMutableArray {
    /// 转换成 Array
    public func mutlToArray() -> Array<Any> {
        return self as! Array
    }
}

extension NSDictionary {
    /// 转换成 Dictionary
    public func toDictionary() -> Dictionary<String, Any> {
        return self as! Dictionary
    }
}
extension NSMutableDictionary {
    /// 转换成 Dictionary
    public func mutlToDictionary() -> Dictionary<String, Any> {
        return self as! Dictionary
    }
}



//MARK: swift类型转换成OC类型
extension Float {
    /// 转换成 CGFloat
    public func toCGFloat() -> CGFloat {
        return CGFloat(self)
    }
}

extension Array {
    /// 转换成 NSArray
    public func toNSArray() -> NSArray {
        return NSArray(array: self)
    }
    
    /// 转换成 NSMutableArray
    public func toNSMutableArray() -> NSMutableArray {
        return NSMutableArray.init(array: self)
    }
}


extension Dictionary {
    /// 转换成 NSDictionary
    public func toNSDictionary() -> NSDictionary {
        return NSDictionary(dictionary: self)
    }
    
    /// 转换成 NSMutableDictionary
    public func toNSMutableDictionary() -> NSMutableDictionary {
        return NSMutableDictionary(dictionary: self)
    }
}



//MARK: String类型转换
extension String {
    /// 转换成 Int
    public func toInt() -> Int? {
        if let num = NumberFormatter().number(from: self) {
            return num.intValue
        } else {
            return nil
        }
    }
    /// 转换成 Double
    public func toDouble() -> Double? {
        if let num = NumberFormatter().number(from: self) {
            return num.doubleValue
        } else {
            return nil
        }
    }
    /// 转换成 Float
    public func toFloat() -> Float? {
        if let num = NumberFormatter().number(from: self) {
            return num.floatValue
        } else {
            return nil
        }
    }
    /// 转换成 NSString
    public func toNSString() -> NSString {
        return NSString(string: self)
    }
}
