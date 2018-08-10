//
//  HardwareJRManager.swift
//  JRHSwiftExtensionsDemo
//
//  Created by huojiarong on 2018/6/4.
//  Copyright © 2018年 huojiarong. All rights reserved.
//

import Foundation
import Photos
import AVFoundation
import CoreLocation
import CoreTelephony
import EventKit
import CoreBluetooth
import Contacts


// MARK: public
/// 判断是否开启权限类型
public enum AuthorityType: String {
    /// 相册
    case PhotoAlbum = "PhotoAlbum"
    /// 相机
    case Camera = "Camera"
    /// 麦克风
    case Microphone = "Microphone"
    /// 定位
    case Location = "Location"
    /// 推送
    case Notification = "Notification"
    /// 联网
    case Network = "Network"
    /// 日历
    case Calendars = "Calendars"
    /// 蓝牙
    case Bluetooth = "Bluetooth"
    /// 通讯录
    case Contacts = "Contacts"
}



class HardwareJRManager: NSObject, CBCentralManagerDelegate {
    
    /// 蓝牙权限获取回调
    private var completeBluetoothClosure: ((_ result: Bool) -> Void)?
    
    // CBCentralManagerDelegate
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        var ret = false
        if central.state.rawValue == 5 {
            ret = true
        }
        if self.completeBluetoothClosure != nil {
            self.completeBluetoothClosure!(ret)
        }
    }
}



//MARK: 权限跳转
extension HardwareJRManager {
    
    /// 跳转到自己App的权限设置页面
    /// - parameters:
    ///     - buildID: App的build id
    public func jumpToSetAuthority(buildID: String) {
        let url = "App-Prefs:root=" + buildID
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(URL.init(string: url)!, options: [String:Any](), completionHandler: nil)
        } else {
            UIApplication.shared.openURL(URL.init(string: url)!)
        }
    }
    
    
    /// 判断权限是否开启
    /// - Parameter type: 权限类型
    /// - Returns: Bool
    public func isAllowAuthority(type: AuthorityType) -> Bool {
        ///返回结果
        var result = false
        switch type {
        case .PhotoAlbum: // 相册权限
            result = self.isAllowPhotoAlbumService()
            break
        case .Camera: //相机权限
            result = self.isAllowCameraService()
            break
        case .Microphone: // 麦克风权限
            result = self.isAllowMicrophoneService()
            break
        case .Location: // 定位权限
            result = self.isAllowLocationService()
            break
        case .Network: // 联网权限
            result = self.isAllowNetworkService()
            break
        case .Calendars: // 日历权限
            result = self.isAllowCalendarsService()
            break
        case .Bluetooth: // 蓝牙权限
            self.isAllowBluetoothService { ret in
                result = ret
            }
            break
        case .Contacts: // 通讯录权限
            result = self.isAllowContactsService()
            break
        case .Notification: // 推送权限
            result = self.isAllowNotificationService()
            break
        }
        return result
    }
    
}



// MARK: private
extension HardwareJRManager {
    
    /// 是否允许获取相册权限
    private func isAllowPhotoAlbumService() -> Bool {
        let photoAuth = PHPhotoLibrary.authorizationStatus()
        if photoAuth == PHAuthorizationStatus.authorized {
            return true
        } else {
            return false
        }
    }
    
    /// 是否允许获取相机权限
    private func isAllowCameraService() -> Bool {
        let videoAuthStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
        if videoAuthStatus == AVAuthorizationStatus.authorized{
            return true
        }else{
            return false
        }
    }
    
    /// 是否允许麦克风权限
    private func isAllowMicrophoneService() -> Bool {
        let videoAuthStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.audio)
        if videoAuthStatus == AVAuthorizationStatus.authorized{
            return true
        }else{
            return false
        }
        
    }
    
    /// 是否允许定位权限
    private func isAllowLocationService() -> Bool  {
        let result = CLLocationManager.authorizationStatus()
        if  (result == CLAuthorizationStatus.denied) ||
            (result == CLAuthorizationStatus.notDetermined) ||
            (result == CLAuthorizationStatus.restricted){
            return false
        }
        
        return true
    }
    
    /// 是否开启推送权限
    private func isAllowNotificationService() -> Bool  {
        let setting = UIApplication.shared.currentUserNotificationSettings
        if setting?.types == UIUserNotificationType.sound {
            return false
        }
        return true
    }
    
    /// 是否开启联网权限
    private func isAllowNetworkService() -> Bool  {
        let state = CTCellularData().restrictedState
        if state == CTCellularDataRestrictedState.notRestricted {
            return true
        }
        
        return false
    }
    
    /// 是否获取日历权限
    private func isAllowCalendarsService() -> Bool  {
        let state = EKEventStore.authorizationStatus(for: EKEntityType.event)
        if state ==  EKAuthorizationStatus.authorized{
            return true
        }
        
        return false
    }
    
    /// 是否获取通讯录权限
    private func isAllowContactsService() -> Bool  {
        let status = CNContactStore.authorizationStatus(for: CNEntityType.contacts)
        
        if status == CNAuthorizationStatus.authorized {
            return true
        }
        return false
    }
    
    /// 是否打开蓝牙权限
    private func isAllowBluetoothService(reslut:@escaping (Bool) -> Void) {
        _ = CBCentralManager.init(delegate: self, queue: nil)
        completeBluetoothClosure = reslut
    }

}




