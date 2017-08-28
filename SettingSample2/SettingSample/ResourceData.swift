//
//  ResourceData.swift
//  SettingSample
//
//  Created by 古山健司 on 2017/08/27.
//  Copyright © 2017年 古山健司. All rights reserved.
//

import Foundation

// DB内での保存形態
struct ResourceData {
    let type: KaradaType
    var isEnabled = false
    var isTokenValid = false
    var resourceProvider: ResourceProvider
    
    init(setting: UserResultSetting, isEnabled: Bool = false) {
        self.type = setting.karadaType
        self.isEnabled = isEnabled
        self.resourceProvider = setting.resourceProvider
    }
}

enum KaradaType: Int {
    case walk = 0
    case weight
    case bloodPressure
    case bloodSugar
    
    var providers: [ResourceProvider] {
        switch self {
        case .walk:
            return [.kencomAuto, .welby]
        case .weight, .bloodPressure, .bloodSugar:
            return [.welby]
        }
    }
    
    func createDataSource() -> [ResourceData] {
        return self.providers.map({ provider in
            let setting = UserResultSetting(karadaType: self, resourceProvider: provider)
            return ResourceData(setting: setting) })
    }
}

enum ResourceProvider: Int {
    case kencomAuto = 0
    case welby
    
    var name: String {
        switch self {
        case .kencomAuto:
            return "## health care ##"
        case .welby:
            return "## Welby ##"
        }
    }
    var key: String {
        switch self {
        case .kencomAuto:
            return "kencom_auto"
        case .welby:
            return "welby"
        }
    }
}
