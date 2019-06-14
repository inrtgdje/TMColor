enum PersonKind{
    
    case Man(name:String,age:Int,playerNumber:Int)
    case Woman(name:String,age:Int,cosmeticsNumber:Int)
    case UnknowPerson(name:String)
}

let jake = PersonKind.Man(name: "周杰伦", age: 30, playerNumber: 100)
let andy = PersonKind.Woman(name: "Andy", age: 24, cosmeticsNumber: 100)
let zhangsan = PersonKind.UnknowPerson(name: "张三")

if case let PersonKind.Man(name,age,playerNumber) = jake {
    print(name,age,playerNumber)
}

import Foundation

class Foo:NSObject{
    
    @objc var intValue:Int = 0
}

class Observer:NSObject{}

let foo = Foo()

let observer = Observer()

print(NSStringFromClass(object_getClass(foo)!))
print(NSStringFromClass(object_getClass(observer)!))

foo.addObserver(observer, forKeyPath: "intValue", options: .new, context: nil)

print(NSStringFromClass(object_getClass(foo)!))
print(NSStringFromClass(object_getClass(observer)!))

let rain = #"The "rain" in "Spain" falls mainly on the spaniards . "#

print(rain)


struct User {
    var name:String
    var age:Int
}

//extension String.StringInterpolation{
//
//    mutating func appendInterpolation(_ value: User){
//
//        appendInterpolation("My name is \(value.name) and I'm \(value.age)")
//    }
//}

let user = User(name: "Guybrush Threepwood", age: 33)


print("User details: \(user)")


extension String.StringInterpolation {
    
    mutating func appendInterpolation(_ number: Int, style: NumberFormatter.Style){
        
        let formatter = NumberFormatter()
        formatter.numberStyle = style
        
        if let result = formatter.string(from: number as NSNumber){
            
            appendLiteral(result)
        }
    }
    
}

let number = Int.random(in: 0...100)

let lucky = "The lucky number this week is \(number,style: .spellOut)."
print(lucky)


let times = [
    "Hudson": "38",
    "Clarke": "42",
    "Robinson":"35",
    "Hartis":"DNF"
]

let finishers1 = times.compactMapValues {
    Int($0)
}

let finishers2 = times.compactMapValues(Int.init)

print(finishers1,finishers2)



let (captain, engineer, doctor) = ("Mal", "Kailee", "Simon")
print(engineer)
let result = UInt8.max.addingReportingOverflow(1)

print(type(of: result))

var i = 2

repeat {
    print(i)
    i *= 2
} while (i < 128)

var first = [1, 2, 3]
var second = ["one", "two", "three"]
var third = Array(zip(first, second))
print(third)

var names = [String]()
names.append("Amy")
let example1 = names.removeLast()

let string: String = String(describing: String.self)
print(string)

let oneMillion = 1_000_000
let oneThousand = oneMillion / 0_1000
print(oneThousand)

let ns = NSString("hello")

let swift = String(ns)

func closureTest(callBack: (Int, Int) ->Int) ->Int{
    
    var result = 0
    
    for i  in 0...10 {
        if i == 5 {
            result = callBack(i,10)
        }
    }
    return result
    
    
}



let cloResult = closureTest { (a, b) -> Int in
    return a + b
}

print(cloResult)

/// 假设你正在爬楼梯。需要 n 阶你才能到达楼顶。 每次你可以爬 1 或 2 个台阶。你有多少种不同的方法可以爬到楼顶呢？
/// 第i阶可以由以下两种方法得到：
///在第(i-1)阶向后爬一阶。
///在第(i-2)阶向后爬二阶。 所以，到达第i阶的方法总数就是(i-1)阶和(i-2)阶方法数之和。
///
/// - Parameter n: <#n description#>
/// - Returns: <#return value description#>
func climbStairs(_ n: Int) -> Int{
    
    if n == 1 {
        return 0
    }
    
    var dp = Array(repeating: 0, count: n + 1)
    
    dp[1] = 1
    dp[2] = 2
    
    for i  in 3...n {
        dp[i] = dp[i - 1] + dp[i - 2]
    }
    
    return dp[n]
}

/*
 如果我们有面值为1元、3元和5元的硬币若干枚，如何用最少的硬币凑够11元？
 */

func countMoney(_ n: Int ) -> Int{
    if n <= 0 {
        return 0
    }
    
    var dp = Array(repeating: 0, count: n + 1)
    dp[1] = 1
    dp[3] = 1
    dp[5] = 1
    
    for i  in 1...n {
        if i < 3 {
            dp[i] = dp[i - 1] + 1
        }else if i >= 5{
            dp[i] = min(dp[i - 1] + 1, dp[i - 3] + 1,dp[i - 5] + 1)
        }else{
            dp[i] = min(dp[i - 1] + 1, dp[i - 3] + 1)
        }
    }
    
    return dp[n]
    
}

func lengthOfLIS(_ nums:[Int]) ->Int{
    if nums.isEmpty {
        return 0
    }
    var dp = Array(repeating: 0, count: nums.count)
    dp[0] = 1
    var  maxAns = 1
    
    for i in 1..<dp.count {
        var maxVal = 0
        for j in 0..<i {
            if nums[i] > nums[j]{
                maxVal = max(maxVal,dp[j])
            }
        }
        dp[i] = maxVal + 1
        maxAns = max(maxAns,dp[i])
    }
    
    return maxAns
    
}

print(lengthOfLIS([10,9,2,5,3,7,101]))
