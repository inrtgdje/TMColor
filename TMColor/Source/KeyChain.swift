//
//  KeyChain.swift
//  TMColor
//
//  Created by 汤天明 on 2019/6/3.
//  Copyright © 2019 汤天明. All rights reserved.
//

import Foundation
import Security
import UIKit


 public func createQuaryMutableDictionary(identifier:String) -> NSMutableDictionary {
    
    let keyChainQuaryMutableDict = NSMutableDictionary.init(capacity: 0)
    
    keyChainQuaryMutableDict.setValue(kSecClassGenericPassword, forKey: kSecClass as String)
    
    keyChainQuaryMutableDict.setValue(identifier, forKey: kSecAttrServer as String)
    
    keyChainQuaryMutableDict.setValue(identifier, forKey: kSecAttrAccount as String)
    
    keyChainQuaryMutableDict.setValue(kSecAttrAccessibleAfterFirstUnlock, forKey: kSecAttrAccessible as String)
    
    return keyChainQuaryMutableDict
}


 func keyChainSaveData(data: Any ,withIdentifier identifier:String)-> Bool {
    // 获取存储数据的条件
    let keyChainSaveMutableDictionary = createQuaryMutableDictionary(identifier: identifier)
    // 删除旧的存储数据
    SecItemDelete(keyChainSaveMutableDictionary)
    // 设置数据
    keyChainSaveMutableDictionary.setValue(NSKeyedArchiver.archivedData(withRootObject: data), forKey: kSecValueData as String)
    // 进行存储数据
    let saveState = SecItemAdd(keyChainSaveMutableDictionary, nil)
    if saveState == noErr  {
        return true
    }
    return false
}


func keyChainUpdata(data:Any , withIdentifier identifier:String) -> Bool {
   
    let keyChainUpdataMutableDict = createQuaryMutableDictionary(identifier: identifier)
    
    let updataMutableDict = NSMutableDictionary.init(capacity: 0)
    
    updataMutableDict.setValue(try! NSKeyedArchiver.archivedData(withRootObject: data, requiringSecureCoding: true), forKey: kSecValueData as String)
   let updataStatus = SecItemUpdate(keyChainUpdataMutableDict, updataMutableDict)
    
    if updataStatus == noErr {
        return true
    }
    return false
}


func keyChainReadData(identifier:String) -> Any {
    var idObject:(Any)? = nil
    
    let keyChainReadMutableDict = createQuaryMutableDictionary(identifier: identifier)
    
    // 提供查询数据的两个必要参数
    keyChainReadMutableDict.setValue(kCFBooleanTrue, forKey: kSecReturnData as String)
    keyChainReadMutableDict.setValue(kSecMatchLimitOne, forKey: kSecMatchLimit as String)
    // 创建获取数据的引用
    var queryResult: AnyObject?
    // 通过查询是否存储在数据
    let readStatus = withUnsafeMutablePointer(to: &queryResult) { SecItemCopyMatching(keyChainReadMutableDict, UnsafeMutablePointer($0))}
    if readStatus == errSecSuccess {
        if let data = queryResult as! NSData? {
            
            idObject = try! NSKeyedUnarchiver.unarchivedObject(ofClasses: [NSObject.self], from: data as Data)
        }
    }
    return idObject as Any
    
   
    
}

 func keyChianDelete(identifier: String)->Void{
    // 获取删除的条件
    let keyChainDeleteMutableDictionary = createQuaryMutableDictionary(identifier: identifier)
    // 删除数据
    SecItemDelete(keyChainDeleteMutableDictionary)
}


 func getUUID() -> String {
    if let uuid = keyChainReadData(identifier: "key") as? String {
        return uuid
    }else {
        if let uuid = UIDevice.current.identifierForVendor?.uuidString {
            if keyChainSaveData(data: uuid, withIdentifier: "key") {
                return uuid
            }
        }
    }
    return "simulator"
}
