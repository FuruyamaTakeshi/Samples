//
//  Repository.swift
//  SettingSample
//
//  Created by 古山健司 on 2017/08/27.
//  Copyright © 2017年 古山健司. All rights reserved.
//

import Foundation

class Repository {
    
    func post(data: ResourceData, handler: () -> Void) {
        let param: [KaradaType: String]
        if data.isEnabled {
            // param set
            param = [data.type: data.resourceProvider.key]
        } else {
            param = [data.type: ""]
        }
        print(param)
        handler()
    }
    
    // serverから取得、失敗時はlocalDBから取得する
    func getData(type: KaradaType, isEnabled:Bool, handler: ([ResourceData]) -> Void) {
        if case .walk = type {
            let result0 = UserResultSetting(karadaType: type, resourceProvider: .kencomAuto)
            let result1 = UserResultSetting(karadaType: type, resourceProvider: .welby)
            handler([ResourceData(setting: result0), ResourceData(setting: result1, isEnabled: isEnabled)])
        } else {
            let result = UserResultSetting(karadaType: type, resourceProvider: .welby)
            handler([ResourceData(setting: result, isEnabled: isEnabled)])
        }
        
    }
    
}

enum RepositoryError: Error {
    case netowrkError
}

class Validator {
    
    func validate(handler: (Bool) -> Void) {
        handler(true)
    }
}
