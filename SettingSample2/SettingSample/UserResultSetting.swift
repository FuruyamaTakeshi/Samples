//
//  UserResultSetting.swift
//  SettingSample
//
//  Created by 古山健司 on 2017/08/27.
//  Copyright © 2017年 古山健司. All rights reserved.
//

import Foundation

class UserResultSetting {
    var name: String = ""
    var resourceProvider: ResourceProvider
    var karadaType: KaradaType
    
    init(karadaType: KaradaType, resourceProvider: ResourceProvider) {
        self.karadaType = karadaType
        self.resourceProvider = resourceProvider
    }
}
