//
//  EmptyListView.swift
//  Not To Do List
//
//  Created by Filip Pokłosiewicz on 26/04/2024.
//

import SwiftUI

struct EmptyListView: View {
    
    @State var animate = false
    @State private var arrowOffset: CGFloat = 0
    
    var body: some View {
        VStack{
            Text("Nothing here. You can do everything.")
                .padding()

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
