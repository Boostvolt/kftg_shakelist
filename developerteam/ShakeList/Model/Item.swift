//
//  Item.swift
//  ShakeList
//
//  Created by Jan Kott on 28.09.20.
//  Copyright © 2020 Jan Kott. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Item: Codable, Identifiable{
    @DocumentID var id: String?
    var title: String
    var completed: Bool
    @ServerTimestamp var createdTime: Timestamp?
    var userId: String?
}
