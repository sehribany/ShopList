//
//  ListViewModel.swift
//  ShopList
//
//  Created by Şehriban Yıldırım on 2.07.2024.
//

import Foundation
import Firebase

class ListViewModel{
    
    private let db = Firestore.firestore()
    
    var lists: [List] = []
    
    // Saves a new list to Firestore
    func saveList(name: String, completion: @escaping (Error?) -> Void) {
        let newList = List(id: UUID().uuidString, name: name, products: [])
        db.collection("lists").document(newList.id).setData([
            "id": newList.id,
            "name": newList.name,
            "products": []
        ]) { error in
            if let error = error {
                completion(error)
            } else {
                self.lists.append(newList)
                completion(nil)
            }
        }
    }
}
