//
//  ItemCellViewModel.swift
//  ShakeList
//
//  Created by Jan Kott on 28.09.20.
//  Copyright © 2020 Jan Kott. All rights reserved.
//

import Foundation
import Combine

class ItemCellViewModel: ObservableObject, Identifiable {
    @Published var itemRepository = ItemRepository()
    
    @Published var item: Item
    
    var id = ""
    @Published var completionStateIconName = ""
    
    private var cancellables = Set<AnyCancellable>()
    
    init(item: Item) {
        self.item = item
        
        $item
        .map { $0.completed ? "checkmark.circle.fill" : "circle" }
        .assign(to: \.completionStateIconName, on: self)
        .store(in: &cancellables)
        
        $item
        .compactMap { $0.id }
        .assign(to: \.id, on: self)
        .store(in: &cancellables)
        
        $item
            .dropFirst()
            .debounce(for: 1.0, scheduler: RunLoop.main)
            .sink{ item in
                self.itemRepository.updateItem(item)
            }
        .store(in: &cancellables)
    }
}
