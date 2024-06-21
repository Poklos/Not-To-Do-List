//
//  ListRowView.swift
//  Not To Do List
//
//  Created by Filip Pokłosiewicz on 18/04/2024.
//

import SwiftUI

struct ListRowView: View {
    
    let item: ItemModel
    
    var body: some View {
        
        HStack(alignment: .top) {
//            Image(systemName: item.isCompleted ? "circle.slash.fill": "circle.slash")
//                .imageScale(.large)
//                .padding(.top, 3)
            VStack(alignment: .leading) {
                        Text(item.title)
                            .font(.title)
                            .strikethrough(item.isCompleted, color: .gray)
                            .foregroundStyle(item.isCompleted ? .gray : .white)
                           
                    }

                    Spacer() 
        }
      
       
    }
}
