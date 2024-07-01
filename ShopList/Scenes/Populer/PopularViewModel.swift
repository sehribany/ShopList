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
}
