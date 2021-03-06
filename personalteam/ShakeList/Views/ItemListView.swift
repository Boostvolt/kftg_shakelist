//
//  ContentView.swift
//  ShakeList
//
//  Created by Jan Kott on 28.09.20.
//  Copyright © 2020 Jan Kott. All rights reserved.
//

import SwiftUI

struct ItemListView: View {
    @ObservedObject var itemListVM = ItemListViewModel()
    var itemRepository = ItemRepository()
    
    func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake{
            itemRepository.removeAllItems()
        }
    }
    
    init() {
        let navBarAppearance = UINavigationBar.appearance()
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.systemBlue]
    }
    
    @State var presentAddNewItem = false
    @State var showInfoScreen = false
    @State var showSignInForm = false
    
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                List {
                    ForEach(itemListVM.itemCellViewModels) { itemCellVM in
                        ItemCell(itemCellVM: itemCellVM)
                        
                    }
                    .onDelete { indexSet in
                        self.itemListVM.removeItems(atOffsets: indexSet)
                    }
                    if presentAddNewItem {
                        ItemCell(itemCellVM: ItemCellViewModel(item: Item(title: "", completed: false))) {
                            item in
                            self.itemListVM.addItem(item: item)
                            self.presentAddNewItem.toggle()
                        }
                    }
                }
                Button(action: { self.presentAddNewItem.toggle() }) {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: 20, height: 20)
                        Text("Neuer Artikel")
                    }
                }
                .padding()
            }
            
            .navigationBarItems(trailing:
                HStack {
                    Button(action: { self.showSignInForm.toggle() }) {
                        Image(systemName: "person.circle")
                        .resizable()
                        .frame(width: 30, height: 30)
                    }
                    .sheet(isPresented: $showSignInForm){
                        SignInView()
                    }
                    Button(action: { self.showInfoScreen.toggle() }) {
                        Image(systemName: "info.circle")
                        .resizable()
                        .frame(width: 30, height: 30)
                    }
                    .sheet(isPresented: $showInfoScreen){
                        InfoView()
                    }
                }
            )
            .navigationBarTitle("ShakeList")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ItemListView()
    }
}

struct ItemCell: View {
    @ObservedObject var itemCellVM: ItemCellViewModel
    
    var onCommit: (Item) -> (Void) = { _ in }
    
    var body: some View {
        HStack{
            Image(systemName: itemCellVM.item.completed ? "checkmark.circle.fill" : "circle")
                .resizable()
                .foregroundColor(Color(.systemBlue))
                .frame(width: 20, height: 20)
                .onTapGesture {
                    self.itemCellVM.item.completed.toggle()
                }
            TextField("Neuer Artikelname eingeben", text: $itemCellVM.item.title, onCommit: {
                self.onCommit(self.itemCellVM.item)
            })
        }
    }
}
