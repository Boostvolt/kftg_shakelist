//
//  ItemListVIewModel.swift
//  ShakeList
//
//  Created by Jan Kott on 28.09.20.
//  Copyright © 2020 Jan Kott. All rights reserved.
//

import Foundation
import Combine

class ItemListViewModel: ObservableObject {
    @Published var itemRepository = ItemRepository()
    @Published var itemCellViewModels = [ItemCellViewModel]()
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        itemRepository.$items
            .map{ items in
                items.map{item in
                    ItemCellViewModel(item: item)
                }
            }
            .assign(to: \.itemCellViewModels, on: self)
            .store(in: &cancellables)
    }
    
    func removeItems(atOffsets indexSet: IndexSet) {
        let viewModels = indexSet.lazy.map { self.itemCellViewModels[$0] }
        viewModels.forEach { itemCellViewModel in
            itemRepository.removeItem(itemCellViewModel.item)
        }
    }
    
    func addItem(item: Item) {
        itemRepository.addItem(item)
        //        let taskVM = TaskCellViewModel(task: task)
        //        self.taskCellViewModels.append(taskVM)
    }
}
