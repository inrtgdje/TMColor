//
//  TMColor.swift
//  SwiftOfShenSuanyun
//
//  Created by 汤天明 on 2018/10/18.
//  Copyright © 2018 汤天明. All rights reserved.
//
/**   return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16) / 255.0f
 green:((rgbValue & 0xFF00) >> 8) / 255.0f
 blue:(rgbValue & 0xFF) / 255.0f
 alpha:1];
 */
import UIKit

extension UIColor {

   
    convenience public init(rgb:UInt32) {
        
        let r = (CGFloat)((rgb & 0xFF0000) >> 16) / 255.0
        let g = (CGFloat)((rgb & 0xFF00) >> 8) / 255.0
        let b = (CGFloat)(rgb & 0xFF) / 255.0
        self.init(red: r, green: g, blue: b, alpha: 1.0)
    }
    
    
    convenience public init(rgba:UInt32) {
        
        let r = (CGFloat)((rgba & 0xFF000000) >> 24) / 255.0
        let g = (CGFloat)((rgba & 0xFF0000) >> 16) / 255.0
        let b = (CGFloat)((rgba & 0xFF00) >> 8) / 255.0
        let a = (CGFloat)(rgba & 0xFF) / 255.0
       self.init(red: r, green: g, blue: b, alpha: a)
    }
    
    convenience init(hexString:String) {
        var red:CGFloat = 0
        var green:CGFloat = 0
        var blue:CGFloat = 0
        var alpha:CGFloat = 0
        
        if UIColor.hexStrToRGBA(str: hexString, red: &red, green: &green, blue: &blue, alpha: &alpha) {
            self.init(red:red,green:green,blue:blue,alpha:alpha)
        }else{
            
            self.init(rgb:0xffffff)
        }
    }
    
    
    private static func hexStrToRGBA(str:String, red: UnsafeMutablePointer<CGFloat>,green: UnsafeMutablePointer<CGFloat>,blue: UnsafeMutablePointer<CGFloat>,alpha: UnsafeMutablePointer<CGFloat>) -> Bool {
        let hexStr = str.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        
        var subString:String = ""
        if hexStr.hasPrefix("#"){
            subString = hexStr[1..<hexStr.count]
        }else if hexStr.hasPrefix("0X"){
            subString = hexStr[2..<hexStr.count]
        }else{
            subString = hexStr
        }
        let length = subString.count
        guard length == 3||length == 4||length == 6||length == 8 else {
            return false
        }
        
        let subStr = String(subString)
        if length < 5 {
            red.pointee = CGFloat(Int(subStr[0..<1],radix: 16) ?? 0) / 255.0
            green.pointee = CGFloat(Int(subStr[1..<2],radix: 16) ?? 0) / 255.0
            blue.pointee = CGFloat(Int(subStr[2..<3],radix: 16) ?? 0) / 255.0
            if length == 4{
                alpha.pointee = CGFloat(Int(subStr[3..<4],radix: 16) ?? 0) / 255.0
            }else{
                alpha.pointee = 1.0
            }
        }else{
            red.pointee = CGFloat(Int(subStr[0..<2],radix: 16) ?? 0) / 255.0
            green.pointee = CGFloat(Int(subStr[2..<4],radix: 16) ?? 0) / 255.0
            blue.pointee = CGFloat(Int(subStr[4..<6],radix: 16) ?? 0) / 255.0
            if length == 8{
                alpha.pointee = CGFloat(Int(subStr[6..<8],radix: 16) ?? 0) / 255.0
            }else{
                alpha.pointee = 1.0
            }
        }
        
        return true
    }
    
    private func hexStrToInt(str:String) ->Int{
        var result: Int = 0
        result = Int(str,radix: 16) ?? 0
        return result
    }
    
   class public func randomColor() -> UIColor {
        let red   = CGFloat.random(in: 0...1.0)
        let green = CGFloat.random(in: 0...1.0)
        let blue  = CGFloat.random(in: 0...1.0)
       
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    
    
  public  func inverseColor() -> UIColor {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        
        return UIColor(red: 1.0 - r, green: 1.0 - g, blue: 1.0 - b, alpha: a)
    }
}


 extension UIImage {
    
   public class func imageWithColor(_ color: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
}
