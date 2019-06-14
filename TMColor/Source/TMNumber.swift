//
//  TMNumber.swift
//  TMColor
//
//  Created by 汤天明 on 2019/5/10.
//  Copyright © 2019 汤天明. All rights reserved.
//

import Foundation

extension Double {
  public  func transeformToString() -> String {
        let MAXIMUM_NUMBER = 99999999999.99
        let CN_ZERO = "零"
        let CN_ONE = "壹"
        let CN_TWO = "贰";
        let CN_THREE = "叁";
        let CN_FOUR = "肆";
        let CN_FIVE = "伍";
        let CN_SIX = "陆";
        let CN_SEVEN = "柒";
        let CN_EIGHT = "捌";
        let CN_NINE = "玖";
        let CN_TEN = "拾";
        let CN_HUNDRED = "佰";
        let CN_THOUSAND = "仟";
        let CN_TEN_THOUSAND = "万";
        let CN_HUNDRED_MILLION = "亿";
        let CN_SYMBOL = "人民币";
        let CN_DOLLAR = "元";
        let CN_TEN_CENT = "角";
        let CN_CENT = "分";
        let CN_INTEGER = "整";
        
        var outputCharacters = ""
        var integral = ""
        var decimal = ""
    let digits = [CN_ZERO, CN_ONE, CN_TWO, CN_THREE, CN_FOUR, CN_FIVE, CN_SIX, CN_SEVEN, CN_EIGHT, CN_NINE]
    let radices = ["", CN_TEN, CN_HUNDRED, CN_THOUSAND]
    let bigRadices = ["", CN_TEN_THOUSAND, CN_HUNDRED_MILLION]
    let decimals = [CN_TEN_CENT, CN_CENT]
        var p = 0
        var d = ""
        var quotient = 0
        var modulus = 0
        
        var currencyDigitsText = "\(self)"
        
        if currencyDigitsText.count == 0 {
            fatalError("金额不能为空!")
            
        }
        
        currencyDigitsText = currencyDigitsText.replacingOccurrences(of: ",", with: "")
        if Double(currencyDigitsText)! > MAXIMUM_NUMBER {
            fatalError("金额过大!")
            
        }
        let parts = currencyDigitsText.components(separatedBy: ".")
        if parts.count > 1 {
            integral = parts.first!
            decimal = parts.last!
            decimal = String.init(decimal.prefix(2))
        } else {
            integral = parts.first!
            decimal = ""
        }
        if Double(integral)! > 0 {
            var zeroCount = 0
            let cs = integral
            
            for (i, item) in cs.enumerated() {
                p = integral.count - i - 1
                d = String.init(item)
                print((p, d))
                quotient = Int(p / 4)
                modulus = p % 4
                if d == "0" {
                    zeroCount += 1
                } else {
                    if zeroCount > 0 {
                        outputCharacters += digits.first!
                    }
                    zeroCount = 0
                    outputCharacters += digits[Int(d)!] + radices[modulus]
                }
                if modulus == 0 && zeroCount < 4 {
                    outputCharacters += bigRadices[quotient]
                    zeroCount = 0
                }
            }
            outputCharacters += CN_DOLLAR
        }
        if decimal.count != 0 {
            for (i, item) in decimal.enumerated() {
                d = String.init(item)
                if d != "0" {
                    outputCharacters += digits[Int(d)!] + decimals[i]
                }
            }
        }
        if outputCharacters == "" {
            outputCharacters = CN_ZERO + CN_DOLLAR
        }
        if decimal == "" {
            outputCharacters += CN_INTEGER
        }
        outputCharacters = CN_SYMBOL + outputCharacters
        return outputCharacters
    }
}
