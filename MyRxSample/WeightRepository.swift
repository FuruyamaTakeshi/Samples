//
//  WeightRepository.swift
//  MyRxSample
//
//  Created by Furuyama Takeshi on 2017/08/05.
//  Copyright © 2017年 Furuyama Takeshi. All rights reserved.
//

import Foundation
import SwiftDate

struct WeightRepository {
    
    let formatter = DateFormatter()
    
    func fetchData(date: Date) -> [WeightDataModel] {
        
        let randam: (Date) -> [WeightDataModel] = { date in
            let value = arc4random() % 30


            return Array(0..<value).filter { $0 % 2 == 0 }.map { value in
                let add = arc4random() % 10
                let weight = Double(arc4random() % 100) + Double(add) / 10
                return WeightDataModel(date: date - Int(value).days , value: weight)
            }
        }
        randam(date).forEach { print($0.date) }
        return randam(date)
    }
}
