//
//  DateJRHExtension.swift
//  JRHSwiftExtensionsDemo
//
//  Created by huojiarong on 2018/6/4.
//  Copyright © 2018年 huojiarong. All rights reserved.
//

import Foundation

extension Date {
    
    /// 年单位
    public var year: Int {
        return Calendar.current.component(.year, from: self)
    }
    
    /// 月单位。范围为1-12
    public var month: Int {
        return Calendar.current.component(.month, from: self)
    }
    
    /// 天单位。范围为1-31
    public var day: Int {
        return Calendar.current.component(.day, from: self)
    }
    
    /// 小时单位。范围为0-24
    public var hour: Int {
        return Calendar.current.component(.hour, from: self)
    }
    
    /// 分钟单位。范围为0-60
    public var minute: Int {
        return Calendar.current.component(.minute, from: self)
    }
    
    /// 秒单位。范围为0-60
    public var second: Int {
        return Calendar.current.component(.second, from: self)
    }
    
    /// 纳秒单位
    public var nanosecond: Int {
        return Calendar.current.component(.nanosecond, from: self)
    }
    
    /// 星期单位。范围为1-7 （一个星期有七天）
    public var weekday: Int {
        return Calendar.current.component(.weekday, from: self)
    }
    
    /// 第几个7天, 以7天为单位，范围为1-5 （1-7号为第1个7天，8-14号为第2个7天...）
    public var weekdayOrdinal: Int {
        return Calendar.current.component(.weekdayOrdinal, from: self)
    }
    
    /// 月包含的周数。最多为6个周
    public var weekOfMonth: Int {
        return Calendar.current.component(.weekOfMonth, from: self)
    }
    
    /// 年包含的周数。最多为53个周
    public var weekOfYear: Int {
        return Calendar.current.component(.weekOfYear, from: self)
    }
    
    ///
    public var yearForWeekOfYear: Int {
        return Calendar.current.component(.yearForWeekOfYear, from: self)
    }
    
    /// 刻钟，范围为1-4 （1刻钟等于15分钟）
    public var quarter: Int {
        return Calendar.current.component(.quarter, from: self)
    }
    
    // TODO: 是否是闰月
    /// 是否是闰月
//    public var isLeapMonth: Bool {
//        let month = Calendar.current.component(.month, from: self)
//        return false
//    }
    
    /// 是否是闰年
    public var isLeapYear: Bool {
        let year = self.year
        return ((year % 400 == 0) || ((year % 100 != 0) && (year % 4 == 0)))
    }
    
    /// 是否是今天
    public var isToday: Bool {
        if fabs(self.timeIntervalSinceNow) >= 60 * 60 * 24 {
            return false
        } else {
            return Date().day == self.day
        }
    }
    
    /// 是否是昨天
    public var isYesterDay: Bool {
        let add = self.dateByAdd(day: 1)
        return add.isToday
    }
    
    /// 增加年
    public func dateByAdd(year: Int) -> Date {
        let calendar = Calendar.current
        var components = DateComponents.init()
        components.year = year
        return calendar.date(byAdding: components, to: self)!
    }
    
    /// 增加月
    public func dateByAdd(month: Int) -> Date {
        let calendar = Calendar.current
        var components = DateComponents.init()
        components.month = month
        return calendar.date(byAdding: components, to: self)!
    }
    
    /// 增加周
    public func dateByAdd(week: Int) -> Date {
        let calendar = Calendar.current
        var components = DateComponents.init()
        components.weekOfYear = week
        return calendar.date(byAdding: components, to: self)!
    }
    
    /// 增加日
    public func dateByAdd(day: Int) -> Date {
        let interval = self.timeIntervalSinceReferenceDate + TimeInterval(86400 * day)
        let newDate = Date.init(timeIntervalSinceReferenceDate: interval)
        return newDate
    }
    
    /// 增加分
    public func dateByAdd(minute: Int) -> Date {
        let interval = self.timeIntervalSinceReferenceDate + TimeInterval(60 * minute)
        let newDate = Date.init(timeIntervalSinceReferenceDate: interval)
        return newDate
    }
    
    /// 增加秒
    public func dateByAdd(second: Int) -> Date {
        let interval = self.timeIntervalSinceReferenceDate + TimeInterval(second)
        let newDate = Date.init(timeIntervalSinceReferenceDate: interval)
        return newDate
    }
    
    /// 生成指定时间格式的字符串
    /// - parameters:
    ///     - format: 时间格式
    ///     - timestamps: 时间戳
    ///     - timeZone: 时区
    ///     - locale: 日历校验
    public func string(format: String, timestamps: Int?, timeZone: TimeZone?, locale: Locale?) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        
        if let timeZone = timeZone {
            formatter.timeZone = timeZone
        }
        
        if let locale = locale {
             formatter.locale = locale
        } else {
            formatter.locale = Locale.current
        }
        
        if let timestamps = timestamps {
            let date = Date(timeIntervalSince1970: TimeInterval(timestamps))
            return formatter.string(from: date)
        }
        
        return formatter.string(from: self)
    }
    
    /// 生成时间戳
    /// - parameters:
    ///     - dateString: 时间字符串
    public func stringTimestamps(dateString: String) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = formatter.date(from: dateString)!
        let second = date.timeIntervalSince1970
        return String(Int(second))
    }
    
    /// 生成标准的时间字符串
    public func stringISOFormat() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale.init(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter.string(from: self)
    }
    
    /// 生成标准的时间
    /// - paramaters:
    ///     - dateString: 时间字符串
    public static func dateISOFormat(dateString: String) -> Date {
        let formatter = DateFormatter()
        formatter.locale = Locale.init(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return formatter.date(from: dateString)!
    }
    
    /// 生成指定格式的时间
    /// - parameters:
    ///     - dateString: 时间字符串
    ///     - format: 时间格式
    ///     - timeZone: 时区
    ///     - locale: 日历校验
    public static func date(dateString: String, format: String, timeZone: TimeZone?, locale: Locale?) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        if let timeZone = timeZone {
           let local = locale
            formatter.timeZone = timeZone
            formatter.locale = local
        }
        return formatter.date(from: dateString)!
    }
    
   
    // MARK: 附录
    /**
     一、 12小时制和24小时制
        HH :24小时制
        hh :12 小时制
     
     二、常用日期结构：
        yyyy-MM-dd HH:mm:ss.SSS
        yyyy-MM-dd HH:mm:ss
        yyyy-MM-dd
        MM dd yyyy
        注意：yyyy是小写的；大写的YYYY的意思有些不同——“将这一年中第一周的周日当作今年的第一天”，因此有时结果和yyyy相同，有时就会不同。
    */
}
