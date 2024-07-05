//
//  PopularViewModel.swift
//  ShopList
//
//  Created by Şehriban Yıldırım on 1.07.2024.
//

import Foundation
import Firebase

class CategoryViewModel {
    
    private var db = Firestore.firestore()
    var categories = [Category]()
    var products   = [Product]()
    
    // Function to fetch categories from Firestore
    
    func fetchCategories(completion: @escaping () -> Void) {
        db.collection("categories").getDocuments { [weak self] querySnapshot, error in
            guard let self = self else { return }
            
            if let error = error {
                print("Error getting documents: \(error)")
                completion()
                return
            }
            
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                completion()
                return
            }
            
            // Map Firestore documents to Category objects and add to categories array
            
            self.categories = documents.compactMap { document in
                guard let id = document.get("id") as? Int,
                      let name = document.get("name") as? String,
                      let image = document.get("image") as? String else {
                    return nil
                }
                return Category(id: id, name: name, image: image)
            }
            
            completion()
        }
    }
    
    // Function to fetch products by category ID from Firestore
    func fetchProducts(categoryID: Int, completion: @escaping () -> Void){
        db.collection("products").whereField("categoryID", isEqualTo: categoryID).getDocuments { [weak self] querySnapshot, error in
            guard let self = self else { return }
            
            if let error = error {
                print("Error getting documents: \(error)")
                completion()
                return
            }
            
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                completion()
                return
            }
            
            // Map Firestore documents to Product objects and add to products array
            self.products = documents.compactMap { document in
                guard let id = document.get("id") as? Int,
                      let name = document.get("name") as? String,
                      let image = document.get("image") as? String,
                      let categoryID = document.get("categoryID") as? Int,
                      let quantity = document.get("quantity") as? Int else {
                    return nil
                }
                return Product(id: id, name: name, image: image, categoryID: categoryID, quantity: quantity)
            }
            print("Fetched Products for categoryID \(categoryID): \(self.products)")
            completion()
        }
    }
}
