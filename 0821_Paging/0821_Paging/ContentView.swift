//
//  ContentView.swift
//  0821_Paging
//
//  Created by Furuken on 2021/08/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            ZStack {
                Color.red
                Text("content1")
                HStack (alignment: .bottom) {
                    ForEach(0..<6) { index in
                    Rectangle()
                        .frame(width: 20, height: 30 * CGFloat(index))
                        .foregroundColor(Color.gray)
                    }
                }
            }
            
            ZStack {
                Color.blue
                Text("content2")
                HStack (alignment: .bottom) {
                    ForEach(0..<6) { index in
                    Rectangle()
                        .frame(width: 20, height: 23.3 * CGFloat(index))
                        .foregroundColor(Color.gray)
                    }
                }

            }
            
            ZStack {
                Color.gray
                ScrollView {
                    ScrollViewReader { proxy in
                        ForEach(0..<50) { index in
                            VStack {
                                Text("List \(index)")
                                Divider()
                            }
                            .id(index)
                        }
                        
                        Button("Top") {
                            withAnimation {
                                proxy.scrollTo(0, anchor: .top)
                            }
                        }
                    }
                }

            }
        }
        .tabViewStyle(PageTabViewStyle())
        .frame(width: 320, height: 320)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
