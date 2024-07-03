//
//  Category.swift
//  ShopList
//
//  Created by Şehriban Yıldırım on 1.07.2024.
//

import Foundation

//MARK: Category model

struct Category: Codable{
    let id: Int
    let name: String
    let image: String
    
    init(id: Int, name: String, image: String) {
        self.id = id
        self.name = name
        self.image = image
    }
}
