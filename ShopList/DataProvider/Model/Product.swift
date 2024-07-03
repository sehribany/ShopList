//
//  Product.swift
//  ShopList
//
//  Created by Şehriban Yıldırım on 1.07.2024.
//

import Foundation

//MARK: Product Model

struct Product: Codable{
    let id: Int
    let name: String
    let image: String
    let categoryID: Int
    var quantity: Int
    
    init(id: Int, name: String, image: String, categoryID: Int, quantity: Int) {
        self.id = id
        self.name = name
        self.image = image
        self.categoryID = categoryID
        self.quantity = quantity
    }
}
