//
//  Product.swift
//  iBuy
//
//  Created by Grazi Berti on 30/10/20.
//

import Foundation

struct Product {
    var name: String
    var isDone: Bool
    
    init(name: String) {
        self.init(name: name, isDone: false)
    }
    
    init(name: String, isDone: Bool) {
        self.name = name
        self.isDone = isDone
    }
}
