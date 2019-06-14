//: A UIKit based Playground for presenting user interface
import UIKit
internal func +<A, B, C>(lhs: @escaping (A) throws -> B,
                         rhs: @escaping (B) throws -> C) -> (A) throws -> C {
    return { try rhs(lhs($0)) }
}


public struct Safe<Base:Decodable>:Decodable{
    
    public let value:Base?
    
    public init(from decoder:Decoder) throws{
        do {
          let container =  try decoder.singleValueContainer()
            
            self.value = try container.decode(Base.self)
        } catch  {
            assertionFailure("ERROR:\(error)")
            self.value = nil
        }
        
    }
    
}

extension URL:ExpressibleByStringLiteral{

    public init(stringLiteral value: StaticString) {
        guard let url = URL(string: "\(value)") else {
            preconditionFailure("This url:\(value) is not invalid")
        }
        self = url
    }
}

let url:URL = "www.baidu.com"

print(url)


let base = """
123
234
456
"""
let theirs = """
789
234
456
"""
let mine = """
890
911
912
"""

let baseLines = base.components(separatedBy: "\n")
let theirLines = theirs.components(separatedBy: "\n")
let myLines = mine.components(separatedBy: "\n")

func noReturn() ->Never{
    fatalError()
}

func pickPositiveNumber(below limit:Int) -> Int{
    
    guard limit >= 1 else {
        noReturn()
    }
    return Int.random(in: 0...limit)
}


let greeting = "Hi there! It's nice to meet you! 👋"
let endOfSentence = greeting.firstIndex(of: "!")!
let firstSentence = greeting[endOfSentence...]
print(firstSentence)


let rawInput = "126 a.b 22210 zzzzzz"
let numericPrefix = rawInput.prefix { (char) -> Bool in
    "A"..."z" ~= char
}


print("👨‍👩‍👧‍👧".unicodeScalars.map { $0.properties.name })

let ff = "Ffe53e"

if let num = Int(ff, radix: 16){
    print(num)
}else{
    print("转换失败")
}

func isAvaliableStr(str:String) -> Bool{
    let length = str.count
    guard length == 3||length == 4||length == 6||length == 8 else {
        return false
    }
    
    return true
}
print(isAvaliableStr(str: "123"))


extension Double {
    func transeformToString() -> String {
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
        var digits = [CN_ZERO, CN_ONE, CN_TWO, CN_THREE, CN_FOUR, CN_FIVE, CN_SIX, CN_SEVEN, CN_EIGHT, CN_NINE]
        var radices = ["", CN_TEN, CN_HUNDRED, CN_THOUSAND]
        var bigRadices = ["", CN_TEN_THOUSAND, CN_HUNDRED_MILLION]
        var decimals = [CN_TEN_CENT, CN_CENT]
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

120007.1.transeformToString()
