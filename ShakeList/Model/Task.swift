//
//  Task.swift
//  Erinnerungen
//
//  Created by Jan Kott on 28.09.20.
//  Copyright © 2020 Jan Kott. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Task: Codable, Identifiable{
    @DocumentID var id: String?
    var title: String
    var completed: Bool
    @ServerTimestamp var createdTime: Timestamp?
    var userId: String?
}

#if DEBUG
let testDataTasks = [
    Task(title: "Apfel", completed: true),
    Task(title: "Karotte", completed: false),
    Task(title: "Salat", completed: false),
    Task(title: "Brine", completed: false)
]
#endif
