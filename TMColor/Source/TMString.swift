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
    
    
    
    
}
