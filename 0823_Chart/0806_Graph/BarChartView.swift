//
//  BarChartView.swift
//  0806_Graph
//
//  Created by Furuken on 2021/08/06.
//

import SwiftUI

struct BarChartGrid: Shape {
  let divisions: Int
  
  func path(in rect: CGRect) -> Path {
    var path = Path()
    let stepSize = rect.height / CGFloat(divisions)
    
    (1 ... divisions).forEach { step in
      path.move(to: CGPoint(x: rect.minX, y: rect.maxY - stepSize * CGFloat(step)))
      path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - stepSize * CGFloat(step)))
    }
    
    return path
  }
}

struct BarChartAxes: Shape {
  func path(in rect: CGRect) -> Path {
    var path = Path()
    
    path.move(to: CGPoint(x: rect.minX, y: rect.maxY))
    path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
    path.move(to: CGPoint(x: rect.minX, y: rect.maxY))
    path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
    
    return path
  }
}

struct BarChartView: View {
    let numbers = [
        DataModel(number: 100, month: "1"),
        DataModel(number: 200, month: "2"),
        DataModel(number: 300, month: "3"),
        DataModel(number: 451, month: "4"),
        DataModel(number: 355, month: "5"),
        DataModel(number: 400, month: "6"),
        DataModel(number: 461, month: "7"),
        DataModel(number: 800, month: "8"),
        DataModel(number: 900, month: "9"),
        DataModel(number: 1000, month: "10"),
        DataModel(number: 1100, month: "11"),
        DataModel(number: 1950, month: "12"),
    ]
    
    let numbers1 = [
        DataModel(number: 50, month: "1"),
        DataModel(number: 100, month: "2"),
        DataModel(number: 500, month: "3"),
        DataModel(number: 251, month: "4"),
        DataModel(number: 155, month: "5"),
        DataModel(number: 130, month: "6"),
        DataModel(number: 144, month: "7"),
        DataModel(number: 400, month: "8"),
        DataModel(number: 382, month: "9"),
        DataModel(number: 400, month: "10"),
        DataModel(number: 500, month: "11"),
        DataModel(number: 600, month: "12"),
    ]
    
    var body: some View {
        
        VStack {
            ZStack(alignment: .bottomTrailing) {

                ScrollView(.horizontal, showsIndicators: true) {
                    ScrollViewReader { value in
                        HStack(alignment: .bottom) {
                            ForEach(0..<numbers.count) { index in
                                VStack {
                                    Text("\(numbers[index].number + numbers1[index].number)")
                                        .font(.footnote)
                                        .foregroundColor(.secondary)
                                    VStack(spacing: 0) {
                                        Rectangle()
                                            .fill(Color.yellow)
                                            .frame(width: 20, height: CGFloat(numbers[index].number / 10))
                                        Rectangle()
                                            .fill(Color.blue)
                                            .frame(width: 20, height: CGFloat(numbers1[index].number / 10))
                                    }

//                                    Text("\(numbers[index].month)")
//                                        .font(.footnote)
//                                        .foregroundColor(.secondary)
                                }
                            }
                            .onAppear {
                                value.scrollTo(numbers.count - 1, anchor: .topTrailing)
                            }
                        }
                    }
                }
                .frame(width: 320, height: 200, alignment: .bottom)
                
                BarChartGrid(divisions: 9)
                    .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                BarChartAxes()
            }
            
        }

    }
    
}

struct BarChartView_Previews: PreviewProvider {
    static var previews: some View {
        BarChartView()
    }
}
