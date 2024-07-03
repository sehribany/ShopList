//
//  List.swift
//  ShopList
//
//  Created by Şehriban Yıldırım on 3.07.2024.
//

import Foundation

//MARK: List Model

struct List {
    let id: String
    var name: String
    var products: [Product]
    
    init(id: String, name: String, products: [Product]) {
        self.id = id
        self.name = name
        self.products = products
    }
}
