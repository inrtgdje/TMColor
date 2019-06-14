import UIKit

let finalSquare = 25
var board = [Int].init(repeating: 0, count: finalSquare + 1)
board[03] = +08;
board[06] = +11;
board[09] = +09;
board[10] = +02;
board[14] = -10;
board[19] = -11;
board[22] = -02;
board[24] = -08;

var square = 0
var diceRoll = 0

repeat{
    
    square += board[square]
    
    diceRoll += 1
    
    if diceRoll == 7{
        diceRoll = 1
    }
    square += diceRoll
    
    
}while square < finalSquare



//while square < finalSquare {
//    diceRoll += 1
//
//    if diceRoll == 7 {
//        diceRoll = 1
//    }
//
//    square += diceRoll
//    // 1 11 4 8 13 8 18 20 23
//    if square < board.count{
//
//        square += board[square]
//    }
//}
public class ThermometerClass {
    private(set) var temperature: Double = 0.0
    public func registerTemperature(temperature: Double) {
        self.temperature = temperature
    }
}

let thermometerClass = ThermometerClass()
thermometerClass.registerTemperature(temperature: 56.0)

public struct ThermometerStruct {
    private(set) var temperature: Double = 0.0
    public mutating func registerTemperature(temperature: Double) {
        self.temperature = temperature
    }
}

var thermometerStruct = ThermometerStruct()
thermometerStruct.registerTemperature(temperature: 56.0)


var thing = "cars"

let closure = { [thing] in
    print("I love \(thing)")
}

thing = "airplanes"

closure() // Prints "I love airplanes"


func countUniques<T: Comparable>( array: Array<T>) -> Int {
    
    let sorted = array.sorted(by: <)
    let initial: (T?, Int) = (.none, 0)
    let reduced = sorted.reduce(initial) { ($1, $0.0 == $1 ? $0.1 : $0.1 + 1) }
    return reduced.1
}

let repeatNum =  countUniques(array: [1,2,2,4,5,5])
print(repeatNum)

class Person:ExpressibleByStringLiteral{
    
    let name:String
    init(name value:String) {
        self.name = value
    }
    
    
    required init(stringLiteral value: String) {
        self.name = value
    }
    
    required init(extendedGraphemeClusterLiteral value:String) {
        self.name = value
    }
    
    required init(unicodeScalarLiteral value: String) {
        self.name = value
    }
    
  
    
}

let tom:Person  = "Tom"

print(tom.name)


extension Array{
    
    subscript(input:[Int]) -> ArraySlice<Element>{
        
        get {
            var result = ArraySlice<Element>()
            
            for i in input{
                
                assert(i < self.count,"Index out of range")
                result.append(self[i])
            }
            return result
            
        }
        
        set {
            
            for (index,i) in input.enumerated(){
            
                assert(i < self.count,"Index out of range")
                self[i] = newValue[index]
            
            }
        
        }
    }

}


var arr = [1,2,3,4,5,6]

print(arr[[0,2,3]])

arr[[0,2,3]] = [-1,-3,-4]

print(arr)

func doSomething(x: Int, y: Int) -> Bool {
    return x == y
}

func somethingElse(a: Int, b: Int) -> Bool {
    return a > b
}

var fn2 = doSomething

// Okay
fn2(1, 2)

// Okay
fn2 = somethingElse

let fn3:(Int,Int) ->Bool = doSomething

doSomething(x:y:)(10,10)

let rawString = "hello world"

fn3(1,3)

print("Game over!")

let sarr = NSArray(object: "meow")

let str = unsafeBitCast(CFArrayGetValueAtIndex(sarr, 0), to: CFString.self)
print(str)

protocol Copyable {
    func copy() -> Self
}


class MyClass: Copyable {
    var num = 1
    
    func copy() -> Self {
        let result = type(of: self).init()
        result.num = num
        return result
    }
    
    
    required init() {
        
    }
}

let object = MyClass()
object.num = 100

let newObject = object.copy()
object.num = 1
print(object.num)
print(newObject.num)

extension Int{
    
     func times(f: (Int, Int) -> ()) {
        print("Tuple")
        for i in 1...self {
            f(i, i)
        }
    }
    
  
}


let block:(Int,Int) -> () = {
    i, j in
    print(i,j)
}

3.times(f: block)

typealias SQLValue = String

struct QueryPart {
    var sql: String
    var values: [SQLValue]
}

struct Query<A> {
    let query: QueryPart
    let parse: ([SQLValue]) -> A
    
    init(_ part: QueryPart, parse: @escaping ([SQLValue]) ->A) {
        self.query = part
        self.parse = parse
    }
}

extension QueryPart: ExpressibleByStringLiteral{
    init(stringLiteral value: String) {
        self.sql = value
        self.values = []
    }
}

extension QueryPart: ExpressibleByStringInterpolation{
    typealias StringInterpolation = QueryPart
    
    init(stringInterpolation: QueryPart) {
        self.sql = stringInterpolation.sql
        self.values = stringInterpolation.values
    }
    
}

extension QueryPart: StringInterpolationProtocol {
    
    init(literalCapacity: Int, interpolationCount: Int) {
        self.sql = ""
        self.values = []
    }
    
    mutating func appendLiteral(_ literal: String) {
        self.sql += literal
    }
    
    mutating func appendInterpolation(param value: SQLValue) {
        sql += "$\(values.count + 1)"
        values.append(value)
    }
    mutating func appendInterpolation(raw value: String)  {
        sql += value
        
    }
    
    
}





let id = "1234"
let email = "mail@objc.io"
let sample = Query<String>("SELECT * FROM users WHERE id=\(raw: id) AND email=\(raw: email)", parse: { $0[0] })
