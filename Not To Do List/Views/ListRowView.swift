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
            Image(systemName: item.isCompleted ? "circle.slash.fill": "circle.slash")
                .imageScale(.large)
                .padding(.top, 3)
            VStack(alignment: .leading) { // Użycie VStack dla tekstu z wyrównaniem do lewej
                        Text(item.title)
                            .font(.title)
                           // .lineLimit(nil) // Usunięcie limitu linii, pozwala tekstowi łamać się na więcej linii
                           // .fixedSize(horizontal: false, vertical: true) // Pozwala VStack na rozciągnięcie w pionie
                    }

                    Spacer() // Dodanie Spacera, aby tekst i ikona były wyrównane do lewej
        }
      
       
    }
}
