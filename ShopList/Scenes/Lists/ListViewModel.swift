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
    
    var lists = [List]()
    
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
    
    // Fetches all lists from Firestore
    func fetchLists(completion: @escaping (Error?) -> Void) {
        db.collection("lists").getDocuments { (snapshot, error) in
            if let error = error {
                completion(error)
            } else {
                self.lists = snapshot?.documents.compactMap { document in
                    let data = document.data()
                    guard let id = data["id"] as? String,
                          let name = data["name"] as? String,
                          let productsData = data["products"] as? [[String: Any]] else { return nil }
                    
                    let products = productsData.compactMap { productData in
                        return Product(id: productData["id"] as? Int ?? 0,
                                       name: productData["name"] as? String ?? "",
                                       image: productData["image"] as? String ?? "",
                                       categoryID: productData["categoryID"] as? Int ?? 0,
                                       quantity: productData["quantity"] as? Int ?? 0)
                    }
                    
                    return List(id: id, name: name, products: products)
                } ?? []
                completion(nil)
            }
        }
    }
}
