//
//  TMString.swift
//  TMColor
//
//  Created by 汤天明 on 2019/5/10.
//  Copyright © 2019 汤天明. All rights reserved.
//

import Foundation
extension String {
    
    subscript (i: Int) -> String {
        return self[i ..< i + 1]
    }
    
    func substring(fromIndex: Int) -> String {
        return self[min(fromIndex, count) ..< count]
    }
    
    func substring(toIndex: Int) -> String {
        return self[0 ..< max(0, toIndex)]
    }
    
    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(count, r.lowerBound)), upper: min(count, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
    
    mutating func dropLast(_ n: Int = 1) -> String {
        self.removeLast(n)
        return self
    }
    var dropLast: String {
        return String(dropLast())
    }
    
    
    
   /// 暂时不够完善
   ///
   /// - Returns: <#return value description#>
   private func  checkPassWord() -> Bool{
        
        let regex  = #"(?=.*[a-zA-Z0-9].*)(?=.*[a-zA-Z].*)(?=.*[0-9].*).{6,16}"#
        return self.evaluateWithRegex(regex)
        
    }
    
    
    func isMobileNumber() ->Bool{
        let mobileRegex = #"1[34578][0-9]{9}"#
        
        return self.evaluateWithRegex(mobileRegex)
    }
    
    func isTelePhoneNumber() ->Bool{
        let mobileRegex = #"(0[0-9]2)-?[0-9]{8}|0[0-9]{3}-?[0-9]{7,8}"#
        
        return self.evaluateWithRegex(mobileRegex)
    }
    
    func isEmail() ->Bool{
        
        let emailRegex = #"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,4}"#
        return self.evaluateWithRegex(emailRegex)
    }
    
  private  func evaluateWithRegex(_ regex:String) -> Bool{
        var result = ""
        let regex = try! NSRegularExpression(pattern: regex, options: .caseInsensitive)
        let res = regex.matches(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count))
    for checkingRes in res {
        result = result + (self as NSString).substring(with: checkingRes.range)
    }
        return result == self
    }
}
