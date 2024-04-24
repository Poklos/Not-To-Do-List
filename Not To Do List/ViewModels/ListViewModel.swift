//
//  ListViewModel.swift
//  Not To Do List
//
//  Created by Filip Pokłosiewicz on 18/04/2024.
//

import Foundation

class ListViewModel: ObservableObject {
    
    @Published var items: [ItemModel] = [] {
        didSet {
            saveItems()
        }
    }
    
    @Published var newItem: String = ""
    let itemsKey: String = "items_list"
    
    init() {
        getItems()
    }
    
    func getItems() {
        if let data = UserDefaults.standard.data(forKey: itemsKey),
           let savedItems = try? JSONDecoder().decode([ItemModel].self, from: data) {
            self.items = savedItems
        } else {
            // Inicjalizuje elementy demo, jeśli nie znaleziono zapisanych danych
            initializeDemoItems()
        }
    }

    
    func deleteItem(indexSet: IndexSet) {
        items.remove(atOffsets: indexSet)
    }
    
    func moveItem(from: IndexSet, to: Int) {
        items.move(fromOffsets: from, toOffset: to)
    }
    

    func addItem() {
            let trimmedNewItem = newItem.trimmingCharacters(in: .whitespacesAndNewlines)
            if !trimmedNewItem.isEmpty {
                let newItemModel = ItemModel(title: trimmedNewItem, isCompleted: false)
                items.append(newItemModel)
                newItem = ""
            }
        }
    
    func updateItem(item: ItemModel) {
        
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index] = item.updateCopletion()
        }
        
    }
    
    func saveItems() {
        if let encodedData = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(encodedData, forKey: itemsKey)
        }
    }
    
    func initializeDemoItems() {
        if items.isEmpty { // Sprawdza czy lista elementów jest pusta
            let demoItems = [
                ItemModel(title: "Just type things you don't wanna do today... or in life", isCompleted: false),
                ItemModel(title: "Then mark it when it's not done ", isCompleted: true)
            ]
            items.append(contentsOf: demoItems)
        }
    }
    
    

    
}

extension ListViewModel {
    func shareableTextRepresentation() -> String {
        let itemsText = items.map { "\($0.isCompleted ? "✓" : "○") \($0.title)" }
        return itemsText.joined(separator: "\n")
    }
}

