//
//  DateFormatter+Extension.swift
//  MyRxSample
//
//  Created by Furuyama Takeshi on 2017/08/06.
//  Copyright © 2017年 Furuyama Takeshi. All rights reserved.
//

import Foundation

extension DateFormatter {
    
    var formatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }
    
}
