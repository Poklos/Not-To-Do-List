//
//  ListDataService.swift
//  Not To Do List
//
//  Created by Filip Pokłosiewicz on 24/06/2024.
//

import Foundation
import CoreData

class ListDataService: ObservableObject {
    
    private let container: NSPersistentContainer
    private let containerName: String = "ItemsContainer"
    private let entityName: String = "ItemEntity"
    
    @Published var savedEntities: [ItemEntity] = []
    
    init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { _, error in
            if let error = error {
                print("Error loading core data: \(error)")
            }
        }
        getList()
    }
    
    // MARK: PUBLIC
    
    func updateList(item: ItemModel) {
        if let entity = savedEntities.first(where: { $0.itemId == item.id }) {
            update(entity: entity, with: item)
        } else {
            add(item: item)
        }
    }
    
    func deleteItem(id: UUID) {
        if let entity = savedEntities.first(where: { $0.itemId == id }) {
            delete(entity: entity)
        }
    }
    
    // MARK: PRIVATE
    
    private func getList() {
        let request = NSFetchRequest<ItemEntity>(entityName: entityName)
        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching data: \(error.localizedDescription)")
        }
    }
    
    private func add(item: ItemModel) {
        let entity = ItemEntity(context: container.viewContext)
        entity.itemId = item.id
        entity.itemTitle = item.title
        entity.isCompleted = item.isCompleted
        applyChanges()
    }
    
    private func update(entity: ItemEntity, with item: ItemModel) {
        entity.itemTitle = item.title
        entity.isCompleted = item.isCompleted
        applyChanges()
    }
    
    private func delete(entity: ItemEntity) {
        container.viewContext.delete(entity)
        applyChanges()
    }
    
    private func save() {
        do {
            try container.viewContext.save()
        } catch let error {
            print("Error saving data: \(error.localizedDescription)")
        }
    }
    
    private func applyChanges() {
        save()
        getList()
    }
}
