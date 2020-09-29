//
//  TaskRepository.swift
//  ShakeList
//
//  Created by Jan Kott on 29.09.20.
//  Copyright © 2020 Jan Kott. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class TaskRepository: ObservableObject {
    
    let db = Firestore.firestore()
    
    @Published var tasks = [Task]()
    
    init() {
        loadData()
    }
    
    func loadData() {
        db.collection("tasks").addSnapshotListener { (querySnapshot, error) in
            if let querySnapshot = querySnapshot {
                self.tasks = querySnapshot.documents.compactMap{ document in
                    do {
                        let x = try? document.data(as: Task.self)
                        return x
                    }
                    catch {
                        print(error)
                    }
                    return nil
                }
            }
        }
    }
    
    func addTask(_ task: Task){
        do {
            let _ = try db.collection("tasks").addDocument(from: task)
        }
        catch {
            fatalError("Task Enkodierung fehlgeschlagen: \(error.localizedDescription)")
        }
        
    }
}
