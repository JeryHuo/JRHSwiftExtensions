//
//  String+JRExtension.swift
//  JRHSwiftExtensionsDemo
//
//  Created by huojiarong on 2018/5/28.
//  Copyright © 2018年 huojiarong. All rights reserved.
//

import Foundation
import UIKit


extension String {
    
//MARK: 字符串拆分
    /// 截取指定长度范围的字符串
    /// - parameters:
    ///     - start: 起始位置，包含起始位置，不传的时候是默认0
    ///     - length: 截取长度，长度包含起始位置，不传的时候默认是取到末尾
    public func substring(start: Int = 0, length: Int = 1000000) -> String {
        if self.count > start {
            var offsetBy = start + length
            // 越界
            if offsetBy >= self.count {
                offsetBy = self.count
            }
            let startIndex = self.index(self.startIndex, offsetBy: start)
            let endIndex = self.index(self.startIndex, offsetBy: offsetBy)
            let sub = self[startIndex ..< endIndex]
            return String(sub)
        } else {
            return ""
        }
    }
    
    /// 截取起始位置的字符串
    /// - parameters:
    ///     - from: 起始位置，包含起始位置，不传的时候是默认0
    ///     - to: 结束位置，不包含结束位置，不传的时候默认是自己本身的长度
    public func substring(from: Int = 0, to: Int = 1000000) -> String {
        var fromR = from, toR = to
        if fromR >= self.count {
            fromR = self.count - 1
        }
        if toR > self.count {
            toR = self.count
        }
        let fromIndex = self.index(self.startIndex, offsetBy: fromR)
        let toIndex = self.index(self.startIndex, offsetBy: toR)
        if fromR >= toR {
            return ""
        }
        let sub = self[fromIndex ..< toIndex]
        return String(sub)
    }
    
    /// 替换指定范围的字符串
    /// - parameters:
    /// - start: 起始位置，包含起始位置，不传的时候是默认0
    /// - length: 截取长度，长度包含起始位置，不传的时候默认是取到末尾
    /// - replaceText: 需要替换的文字
    public mutating func stringByReplacingCharactersInRange(start: Int = 0, length: Int = 1000000, replaceText: String) -> String {
        if self.count > start {
            var offsetBy = start + length
            // 越界
            if offsetBy >= self.count {
                offsetBy = self.count
            }
            let startIndex = self.index(self.startIndex, offsetBy: start)
            let endIndex = self.index(self.startIndex, offsetBy: offsetBy)
            self.replaceSubrange(startIndex ..< endIndex, with: replaceText)
            return self
        } else {
            return ""
        }
    }
    
    /// 替换指定的字符串
    /// - parameters:
    /// - text: 原文字
    /// - replacText: 需要替换的文字
    public mutating func stringByReplacingstringByReplacingString(text:String,replacText:String) -> String {
        return self.replacingOccurrences(of: text, with: replacText)
    }
    
    /// 删除指定索引的字符
    /// - parameters:
    ///     - index: 需要删除的索引，默认删除最后一个字符
    public mutating func removeIndexCharacters(index: Int = 1000000) -> String {
        var deletedIndex = index
        if deletedIndex >= self.count - 1 {
            deletedIndex = self.count - 1
        }
        let strIndex = self.index(self.startIndex, offsetBy: deletedIndex)
        self.remove(at: strIndex)
        return self
    }
    
    /// 删除指定的字符串
    /// - parameters:
    ///     - string: 需要删除的字符串
    func removeString(string: String) -> String {
        return self.replacingOccurrences(of: string, with: "")
    }
    
    /// 分隔字符串成数组
    /// - parameters:
    ///     - stringBy: 分隔符
    /// - returns: 字符串数组
    func separateString(stringBy: String) -> [String] {
        let nsstring: NSString = NSString(string: self)
        return nsstring.components(separatedBy: stringBy)
    }
    
    
    
//MARK: 编码加密
    /// url编码
    public var urlEncode: String {
        let characterSet = CharacterSet(charactersIn: ":/?#[]@!$ &'()*+,;=\"<>%{}|\\^~`")
        return self.addingPercentEncoding(withAllowedCharacters: characterSet)!
    }
    
    /// url解码
    public var urlDecode: String? {
        return self.removingPercentEncoding
    }
    
    /// base64编码
    public var base64Encode: String {
        let nsstring = NSString(string: self)
        let data = nsstring.data(using: String.Encoding.utf8.rawValue)
        let base64 = data!.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
        return base64
    }
    
    /// base64解码
    public var base64Decode: String? {
        if let data = Data(base64Encoded: self) {
            return String(data: data, encoding: .utf8)
        }
        return nil
    }
    
    
    
//MARK: 是否是
    /// 是否是邮箱
    public var isEmail: Bool {
        if self.isEmpty {
            return false
        }
        let res = range(of: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}", options: .regularExpression, range: nil, locale: nil)
        return res != nil
    }
    
    /// 是否是url
    public var isUrl: Bool {
        if self.isEmpty {
            return false
        }
        return URL(string: self) != nil
    }
    
    /// 是否是手机号
    public var isMobileNumber: Bool {
        if self.isEmpty {
            return false
        }
        let reg = "^1[3|4|5|7|8][0-9]{9}$"
        let pred = NSPredicate(format: "SELF MATCHES %@", reg)
        return pred.evaluate(with: self)
    }
    
    /// 是否只是数字和字母的组合
    public var isAlphanumeric: Bool {
        if self.isEmpty {
            return false
        }
        let res = self.range(of: "[^a-zA-Z0-9]", options: .regularExpression, range: nil, locale: nil)
        return res == nil
    }
    
    /// 是否是有效的金额
    public var isMoney: Bool {
        if self.isEmpty {
            return false
        }
        let reg = "^(([1-9]{1}\\d*)|([0]{1}))(\\.(\\d){0,2})?$"
        let pred = NSPredicate(format: "SELF MATCHES %@", reg)
        return pred.evaluate(with: self)
    }
    
    /// 是否是车牌号
    public var isPlateNumber: Bool {
        if self.isEmpty {
            return false
        }
        let reg = "^[京,津,渝,沪,冀,晋,辽,吉,黑,苏,浙,皖,闽,赣,鲁,豫,鄂,湘,粤,琼,川,贵,云,陕,秦,甘,陇,青,台,内蒙古,桂,宁,新,藏,澳,军,海,航,警][A-Z][0-9,A-Z]{5}$"
        let pred = NSPredicate(format: "SELF MATCHES %@", reg)
        return pred.evaluate(with: self)
    }
    
    /// 是否是中文姓名
    public var isChineseName: Bool {
        if self.isEmpty {
            return false
        }
        let reg = "^[\u{4e00}-\u{9fa5}]{2,20}$"
        let pred = NSPredicate(format: "SELF MATCHES %@", reg)
        return pred.evaluate(with: self)
    }
    /// 是否是身份证号码
    public var isIdCardNumber: Bool {
        if self.isEmpty {
            return false
        }
        
        let reg = "(^[0-9]{15}$)|(^[0-9]{18}$)|(^[0-9]{17}([0-9xX]){1}$)"
        let pred = NSPredicate(format: "SELF MATCHES %@", reg)
        let flag = pred.evaluate(with: self)
        
        if !flag {
            return false
        }
        
        // 验证地区
        let areaStr = "11:12:13:14:15:21:22:23:31:32:33:34:35:36:37:41:42:43:44:45:46:50:51:52:53:54:61:62:63:64:65:71:81:82:91:"
        let areaNumber = self.substring(to: 2)
        let range = areaStr.range(of: areaNumber)
        if range == nil {
            return false
        }
        
        // 验证出生时间
        let birthNumber = self.substring(start: 6, length: 8)
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        formatter.dateFormat = "yyyyMMdd"
        let date = formatter.date(from: birthNumber)
        let start = "19000101", end = "20160101"
        if date == nil || Int(start)! > Int(birthNumber)! || Int(end)! < Int(birthNumber)!{
            return false
        }
        
        return true
    }
    
    
    
//MARK: 获取文本宽高
    /// 获取文本最大高度
    /// - parameters:
    /// - font: 字体，默认系统17号
    /// - width: 宽度
    public func getTextHeight(font: UIFont = UIFont.systemFont(ofSize: 17), width: Float) -> Float {
        if self.count < 0 {
            return 0.0
        }
        let size = CGSize.init(width: width.toCGFloat(), height: CGFloat.greatestFiniteMagnitude)
        let rect = self.toNSString().boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font : font], context: nil)
        return rect.size.height.toFloat()
    }
    
    /// 获取文本最大宽度
    /// - parameters:
    /// - font: 字体，默认系统17号
    /// - height: 高度
    public func getTextWidth(font: UIFont = UIFont.systemFont(ofSize: 17), height: Float) -> Float {
        if self.count < 0 {
            return 0.0
        }
        let size = CGSize.init(width: CGFloat.greatestFiniteMagnitude, height: height.toCGFloat())
        let rect = self.toNSString().boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font : font], context: nil)
        return rect.size.width.toFloat()
    }
    
}
