//
//  ItemRepository.swift
//  ShakeList
//
//  Created by Jan Kott on 29.09.20.
//  Copyright © 2020 Jan Kott. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

class ItemRepository: ObservableObject {
    
    let db = Firestore.firestore()
    
    @Published var items = [Item]()
    
    init() {
        loadData()
    }
    
    func loadData() {
        let userId = Auth.auth().currentUser?.uid
        
        db.collection("items")
            .order(by: "createdTime")
            .whereField("userId", isEqualTo: userId)
            .addSnapshotListener { (querySnapshot, error) in
                if let querySnapshot = querySnapshot {
                    self.items = querySnapshot.documents.compactMap{ document in
                        do {
                            let x = try? document.data(as: Item.self)
                            return x
                    }
                }
            }
        }
    }
    
    func addItem(_ item: Item){
        do {
            var addedItem = item
            addedItem.userId = Auth.auth().currentUser?.uid
            let _ = try db.collection("items").addDocument(from: addedItem)
        }
        catch {
            fatalError("Artikel Enkodierung fehlgeschlagen: \(error.localizedDescription)")
        }
    }
    
    func removeItem(_ item: Item) {
        if let itemID = item.id {
            db.collection("items").document(itemID).delete { (error) in
                if let error = error {
                    print("Artikel Enkodierung fehlgeschlagen: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func updateItem(item: Item){
        if let itemID = item.id {
            do {
                try db.collection("items").document(itemID).setData(from: item)
            }
            catch {
                fatalError("Artikel Enkodierung fehlgeschlagen: \(error.localizedDescription)")
            }
        }
    }
    
    func removeAllItems(){
        items.forEach { Item in
            removeItem(Item)
        }
    }
}
