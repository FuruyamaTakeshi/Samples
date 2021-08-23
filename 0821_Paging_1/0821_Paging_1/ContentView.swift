//
//  ContentView.swift
//  0821_Paging_1
//
//  Created by Furuken on 2021/08/21.
//

import SwiftUI

struct ContentView: View {
    
    @State private var selection = 0
    
    private let colors: [Color] = [.red, .green, .blue, .orange, .pink, .purple,]
    var body: some View {
        TabView(selection: $selection) {
            ForEach(0..<self.colors.count) { index in
                ZStack {
                    colors[index]
                    Text("コンテンツ \(index)")
                }
                .tag(index)
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        
        ScrollView(.horizontal, showsIndicators: false) {
            ScrollViewReader { proxy in
                HStack {
                    ForEach(0..<self.colors.count) { index in
                        Text("List \(index)")
                            .font(.headline)
                            .padding(.init(top: 4, leading: 8, bottom: 4, trailing: 8))
                            .decorate(isSelected: index == selection)
                            .id(index)
                            .tag(index)
                            .onTapGesture {
                                withAnimation {
                                    selection = index
                                }
                            }
                    }
                }
                .onChange(of: selection) { newValue in
                    withAnimation {
                        proxy.scrollTo(newValue, anchor: .center)
                    }
                }
            }
        }
    }
}

struct TabItem: ViewModifier {
    
    let isSelected: Bool
    
    @ViewBuilder
    func body(content: Content) -> some View {
        if isSelected {
            content
                .foregroundColor(.white)
                .background(Color.blue)
                .clipShape(Capsule())
        } else {
            content
                .foregroundColor(Color(.label))
        }
    }
    
}

extension View {
    func decorate(isSelected: Bool) -> some View {
        self.modifier(TabItem(isSelected: isSelected))
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
