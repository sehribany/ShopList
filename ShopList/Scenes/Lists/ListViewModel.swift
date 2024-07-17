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
    var updateHandler: (() -> Void)?
    var errorHandler: ((String) -> Void)?
    
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
    
    // Updates an existing list in Firestore
    func editList(id: String, newName: String) {
        db.collection("lists").document(id).updateData(["name": newName]) { [weak self] error in
            if let error = error {
                self?.errorHandler?("Error editing list: \(error.localizedDescription)")
            } else {
                if let index = self?.lists.firstIndex(where: { $0.id == id }) {
                    self?.lists[index].name = newName
                    self?.updateHandler?()
                }
            }
        }
    }
    
    // Deletes a list from Firestore
    func deleteList(id: String) {
        db.collection("lists").document(id).delete { [weak self] error in
            if let error = error {
                self?.errorHandler?("Error deleting list: \(error.localizedDescription)")
            } else {
                self?.lists.removeAll { $0.id == id }
                self?.updateHandler?()
            }
        }
    }
}
