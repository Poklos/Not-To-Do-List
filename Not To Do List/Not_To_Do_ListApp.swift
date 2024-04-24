//
//  Not_To_Do_ListApp.swift
//  Not To Do List
//
//  Created by Filip Pokłosiewicz on 18/04/2024.
//

import SwiftUI

@main
struct Not_To_Do_ListApp: App {
    
    @StateObject var listViewModel: ListViewModel = ListViewModel()
    
    var body: some Scene {
        WindowGroup {
            ListView()
        }
        .environmentObject(listViewModel)
    }
}
