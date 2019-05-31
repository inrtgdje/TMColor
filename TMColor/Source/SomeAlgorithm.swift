//
//  SomeAlgorithm.swift
//  TMColor
//
//  Created by 汤天明 on 2019/5/31.
//  Copyright © 2019 汤天明. All rights reserved.
//

import Foundation

/// 假设你正在爬楼梯。需要 n 阶你才能到达楼顶。 每次你可以爬 1 或 2 个台阶。你有多少种不同的方法可以爬到楼顶呢？
/// 第i阶可以由以下两种方法得到：
///在第(i-1)阶向后爬一阶。
///在第(i-2)阶向后爬二阶。 所以，到达第i阶的方法总数就是(i-1)阶和(i-2)阶方法数之和。
///
/// - Parameter n: n阶楼梯
/// - Returns: 多少种方法
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

/// 最大上升子序列
///
/// - Parameter nums: 数组
/// - Returns: 最大上升序列元素的个数
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

func countAndSay(_ n: Int) -> String {
    
    var str = "1"
    
    if n == 1 {
        return str
    }
    
    
    func  charAt(_ index:Int, of string:String) ->Character {
        return string[string.index(string.startIndex, offsetBy: index)]
    }
    
    var i = 1
    while i < n {
        let charArray = str
        var num = 1
        var a = ""
        for index in 0..<charArray.count{
            var char = ""
            if index + 1 < charArray.count,charAt(index, of: charArray) == charAt(index + 1, of: charArray) {
                num += 1
            }else{
                char.append(String(num))
                char.append(charAt(index, of: charArray))
                num = 1
            }
            
            a.append(char)
            str = a
            
        }
        i += 1
        
    }
    
    return str
}

func fibonacci(_ n:Int) ->Int{
    var nums = Array.init(repeating: 0, count: n + 1)
    nums[0] = 1
    nums[1] = 2
    for index in 2...n {
        nums[index] = nums[index - 2] + nums[index - 1]
    }
    return nums[n]
}
