//
//  ViewController.swift
//  JRHSwiftExtensionsDemo
//
//  Created by huojiarong on 2018/5/28.
//  Copyright © 2018年 huojiarong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       
        var str = "15201552310"
        
        let substr = str.substring(start: 7, length: 4)
        let substr1 = str.substring(start: 7)
        let substr2 = str.substring(start: 7, length: 100)
        print("\(substr), \(substr1), \(substr2) \n");
        
        let substr3 = str.substring(from: 3, to: 7)
        let substr4 = str.substring(from: 7)
        let substr5 = str.substring(to: 3)
        print("\(substr3), \(substr4), \(substr5) \n");
        
        _ = str.stringByReplacingCharactersInRange(start: 3, length: 4, replaceText: "****")
        print("\(str) \n");
        
        let replace = str.stringByReplacingstringByReplacingString(text: "2310", replacText: "****")
        print("\(replace) \n");
        
        _ = str.removeIndexCharacters(index: 9)
        print("\(str) \n");
        
        let replace1 = str.removeString(string: "230")
        print("\(replace1) \n");
        
        let sepstr = "1,2,3,4,5"
        let separr = sepstr.separateString(stringBy: ",")
        print("\(separr) \n")
        
        let url = "http://www.yoquant.com"
        let phone = "01234567891"
        let email = "jeryhuo@.com"
        let alp = "12233.df/S*"
        let money = "1.00"
        let plate = "京A88888"
        let name = "中文姓名"
        let card = "62050319800103741X"
        print("网址 \(url.isUrl)")
        print("手机号 \(phone.isMobileNumber)")
        print("邮箱 \(email.isEmail)")
        print("数字字母 \(alp.isAlphanumeric)")
        print("金额 \(money.isMoney)")
        print("车牌号 \(plate.isPlateNumber)")
        print("中文 \(name.isChineseName)")
        print("身份证号 \(card.isIdCardNumber)")
        
        print(HardwareJRManager().isAllowAuthority(type: .Microphone))
        // HardwareJRManager().jumpToSetAuthority(buildID: "com.yoquant.ylt")
        print("\(Date().year)-\(Date().month)-\(Date().day) \(Date().hour):\(Date().minute):\(Date().second)")
        print("\(Date().dateByAdd(year: 1))")
        print("\(Date().stringTimestamps(dateString: "2018-6-6 00:00:00"))")
        print("\(Date().string(format: "yyyy年MM月dd日", timestamps: 1528243200, timeZone: nil, locale: nil))")
    }
}

