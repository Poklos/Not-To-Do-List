//
//  ListView.swift
//  Not To Do List
//
//  Created by Filip Pokłosiewicz on 18/04/2024.
//

import SwiftUI

let customYellowUIColor = UIColor(red: 1.0, green: 0.8, blue: 0.0, alpha: 1.0)
let customYellowSwiftUIColor = Color(customYellowUIColor)
let appIcon = Image("SharePreviewIcon")

struct ListView: View {
    
    @EnvironmentObject var listViewModel: ListViewModel
    @FocusState private var fieldIsFocused: Bool
    
    
    init() {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor.clear
            appearance.titleTextAttributes = [
                .foregroundColor: customYellowUIColor,
                .font: UIFont.systemFont(ofSize: 25, weight: .bold),
                .baselineOffset: -5
                
            ]
            appearance.largeTitleTextAttributes = [
                .foregroundColor: customYellowUIColor
            ]
            
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().compactAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
            UINavigationBar.appearance().tintColor = customYellowUIColor
        }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(hex: "#1b1b1b").ignoresSafeArea()
                
                VStack {
                    Spacer(minLength: 20)
                    
                        if listViewModel.items.isEmpty {
                            EmptyListView()
                        } else {
                            List {
                                ForEach(listViewModel.items) { item in
                                    ListRowView(item: item)
                                        .onTapGesture {
                                            withAnimation(.linear){
                                                listViewModel.updateItem(item: item)
                                            }
                                        }
                                        .listRowBackground(Color.clear)
                                    
                                }
                                .onDelete(perform: listViewModel.deleteItem)
                                .onMove(perform: listViewModel.moveItem)
                                
                                
                            }
                            .listStyle(.plain)
                        }
                    Spacer()
                    
                    VStack {
                        TextField("", text: $listViewModel.newItem)
                            //.focused($fieldIsFocused)
                            .placeholder(when: listViewModel.newItem.isEmpty) {
                                   Text("Type here...")
                                    .foregroundColor(.gray)
                           }
                            .padding(.bottom)
                        .font(.title)
                    }
                    .padding()
        
                  
                    Button(action: {
                        listViewModel.addItem()
                        fieldIsFocused = false
                    }) {
                        Text("Add")
                            .foregroundColor(.black)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(listViewModel.newItem.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? Color.gray : Color.yellow)
                            .cornerRadius(50)
                    }
                    .disabled(listViewModel.newItem.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                    .padding(.horizontal)
                    .padding(.bottom)
                }
                .navigationTitle("Don't do it list")
                .navigationBarTitleDisplayMode(.inline)
                

            }
            .onTapGesture {
                        hideKeyboard()
                    }
            .foregroundColor(.white)
            
            .toolbar {
//                ToolbarItem(placement: .navigationBarLeading) {
//                    HStack {
//                        EditButton()
//                    }
//                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack {
                        ShareLink(
                            item: listViewModel.shareableTextRepresentation(),
                            preview: SharePreview("I'm not doing those things", image: appIcon)) {
                            Image(systemName: "square.and.arrow.up")
                               
                        }
                    }
                }
            }
            .navigationViewStyle(StackNavigationViewStyle())
        }
        
    }
    
    
    
}

func hideKeyboard() {
    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
}

extension Color {
    init(hex: String) {
        var cleanHexCode = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        cleanHexCode = cleanHexCode.replacingOccurrences(of: "#", with: "")
        print(cleanHexCode)
        var rgb: UInt64 = 0
        
        Scanner(string: cleanHexCode).scanHexInt64(&rgb)
        
        let redValue = Double((rgb >> 16) & 0xFF) / 255.0
        let greenValue = Double((rgb >> 8) & 0xFF) / 255.0
        let blueValue = Double(rgb & 0xFF) / 255.0
        self.init(red: redValue, green: greenValue, blue: blueValue)
    }
}

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}

#Preview {
    ListView().environmentObject(ListViewModel())
}

