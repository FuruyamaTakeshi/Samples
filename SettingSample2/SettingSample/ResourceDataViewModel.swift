//
//  ResourceDataViewModel.swift
//  SettingSample
//
//  Created by 古山健司 on 2017/08/27.
//  Copyright © 2017年 古山健司. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class ResourceDataViewModel {
    
    var resourcesVariable = Variable<[ResourceData]>([ResourceData]())
    var type: KaradaType
    
    var resourceCount: Int {
        return resourcesVariable.value.count
    }
    
    var validator = Validator()
    var repository = Repository()
    
    var state: ProviderSelectedState?

    init(type: KaradaType) {
        self.type = type
        let source = type.createDataSource()
        self.resourcesVariable.value = source
        state = WelbySelectedState.shared
    }
    
    func updateData(at indexPath: IndexPath) {
        let provider = resourcesVariable.value[indexPath.row].type.providers[indexPath.row]
        let isEnabled = !resourcesVariable.value[indexPath.row].isEnabled
        resourcesVariable.value[indexPath.row].isEnabled = isEnabled
        
        if case .welby = provider {
            self.state = WelbySelectedState.shared
        } else {
            self.state = KencomAutoSelectedState.shared
        }

        self.state?.updateData(at: indexPath, resources: resourcesVariable.value)
    }
    
    func isEnabled(at indexPath: IndexPath) -> Bool {
        return resourcesVariable.value[indexPath.row].isEnabled
    }
    
    func isTokenValid(at indexPath: IndexPath) -> Bool {
        return state?.isTokenValid(at: indexPath, resources: resourcesVariable.value) ?? false
    }
    
    func proviedersName(at indexPath: IndexPath) -> String {
        return resourcesVariable.value[indexPath.row].type.providers[indexPath.row].name
    }
    
}
