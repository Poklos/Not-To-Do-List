//
//  EmptyListView.swift
//  Not To Do List
//
//  Created by Filip Pokłosiewicz on 26/04/2024.
//

import SwiftUI

struct EmptyListView: View {
    
    @State var animate = false
    
    var body: some View {
        VStack{
            Text("Nothing here. You can do everything.")
                .padding()
//            Button {
//                //akcja
//            } label: {
//                Image(systemName: "plus.circle")
//                    .font(.title)
//                    .foregroundStyle(Color.yellow)
//                    .scaledToFit()
//                    .scaledToFill()
//            }
        }
        .onAppear {
            addAnimation()
        }
    }
    
    func addAnimation() {
        guard !animate else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            withAnimation(.easeInOut) {
                animate.toggle()
            }
        }
    }
}

#Preview {
    EmptyListView()
}
