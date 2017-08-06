//
//  ViewModel.swift
//  MyRxSample
//
//  Created by Furuyama Takeshi on 2017/08/05.
//  Copyright © 2017年 Furuyama Takeshi. All rights reserved.
//

import Foundation
import RxSwift
import SwiftDate

struct ViewModel {
    
    private var formatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }
    
    var dateVariable = Variable<String>("")
    var weightVariable = Variable<Double>(0)
    var dataEnableVariable = Variable<Bool>(false)
    
    private var date = Date().startOfDay
    let repository = WeightRepository()
    
    var weightDataList: [WeightDataModel]?
    
    mutating func viewDidLoad() {
        date = Date().startOfDay
        weightDataList = repository.fetchData(date: date)
        dateVariable.value = formatter.string(from: date)
    }
    
    mutating func onPrevButtonDidTap() {
        date = date - 1.day
        let sameDate = weightDataList?.filter { $0.date == date }
        
        if let result = sameDate?.first {
            weightVariable.value = result.value
        } else {
            print("not found @ \(formatter.string(from: date))")
            // 直近のデータを設定する
            findNeighborhood(by: date)
        }
        dateVariable.value = formatter.string(from: date)
        dataEnableVariable.value = sameDate?.first != nil
        
        print("current date: \(formatter.string(from: date))")
        debugPrint(list: weightDataList, comment: "#0")

        // 最後のデータであったら、再度fetchして追加する
        if let list = weightDataList, let last = list.last, last.date == date {
            repository.fetchData(date: date).forEach {
                if let _ = (weightDataList?.contains { $0.date == last.date }) {
                    weightDataList?.append($0)
                }
                debugPrint(list: weightDataList, comment: "#1")
            }
        }
    }
    
    mutating func onNextButtonDidTap() {
        date = date + 1.day
        debugPrint(list: weightDataList, comment: "\(#function)")

        let result = weightDataList?.filter { $0.date == date }
        if let result = result?.first {
            dateVariable.value = formatter.string(from: result.date)
            dataEnableVariable.value = true
            weightVariable.value = result.value
        } else {
            print("not found")
            dataEnableVariable.value = false
            dateVariable.value = formatter.string(from: date)
        }
    }
    
    private func debugPrint(list: [WeightDataModel]?, comment: String) {
        guard let list = list else { return }
        for (idx, weight) in list.enumerated() {
            print("#\(comment) \(idx): \(formatter.string(from: weight.date)), \(weight.value)")
        }
    }
    
    private func findNeighborhood(by date: Date) -> WeightDataModel {
        // 配列の中から最も近い要素で値が存在する日を返す
        if let list = weightDataList {
            let diffs = list.map { $0.date - date }
            print(diffs)
        }
        return WeightDataModel(date: date, value: 70.0)
    }
    
}
