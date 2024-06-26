//
//  ItemModel.swift
//  Not To Do List
//
//  Created by Filip Pokłosiewicz on 18/04/2024.
//

import Foundation

struct ItemModel:Identifiable, Codable {
    let id: UUID
    let title: String
    let isCompleted: Bool
  
    
    init(id: UUID = UUID(), title: String, isCompleted: Bool) {
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
    
    }
    
    func updateCopletion() -> ItemModel {
        ItemModel(id: id, title: title, isCompleted: !isCompleted)
    }
}
