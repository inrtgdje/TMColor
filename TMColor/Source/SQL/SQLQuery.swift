//
//  SQLQuery.swift
//  TMColor
//
//  Created by 汤天明 on 2019/6/11.
//  Copyright © 2019 汤天明. All rights reserved.
//

import Foundation

typealias SQLValue = String

struct QUery<A> {
    let sql: String
    let values: [SQLValue]
    let parse: ([SQLValue]) -> A
    
    typealias Placeholder = String
    
    init(values: [SQLValue],build: ([Placeholder]) ->String,parse: @escaping ([SQLValue]) ->A) {
        let placeholders = values.enumerated().map { "$\($0.0 + 1)"}
        self.values = values
        self.sql = build(placeholders)
        self.parse = parse
    }
}
