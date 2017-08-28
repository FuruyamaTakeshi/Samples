//
//  ProviderSelectedState.swift
//  SettingSample
//
//  Created by 古山健司 on 2017/08/27.
//  Copyright © 2017年 古山健司. All rights reserved.
//

import Foundation

protocol ProviderSelectedState {
    func updateData(at indexPath: IndexPath, resources: [ResourceData])
    func isTokenValid(at indexPath: IndexPath, resources: [ResourceData]) -> Bool
}

extension ProviderSelectedState {
    
    func updateResources(at indexPath: IndexPath, from resources: [ResourceData], to result: [ResourceData]) {
        let isEnabled = result[indexPath.row].isEnabled
        var new = resources
        new[indexPath.row].isEnabled = isEnabled
        
        for (index, _) in resources.enumerated() {
            guard index != indexPath.row else { continue }
            let isEnabled = resources[indexPath.row].isEnabled
            if isEnabled {
                new[index].isEnabled = !(isEnabled)
            }
        }
    }
    
}

class WelbySelectedState: ProviderSelectedState {
    
    static let shared = WelbySelectedState()
    var validator = Validator()
    var repository = Repository()
    var type = KaradaType.walk
    
    func updateData(at indexPath: IndexPath, resources: [ResourceData]) {
        
        let isEnabled = !resources[indexPath.row].isEnabled
        var newResoures = resources
        newResoures[indexPath.row].isEnabled = isEnabled
        
        let relodHandler = {
            // repositoryからの呼び出す(server or DB)
            self.repository
                .getData(type: self.type, isEnabled: isEnabled, handler: { [weak self] (results) in
                    // 成功したら表示変更
                    self?.updateResources(at: indexPath, from: resources, to: results)
                })
        }
        
        let data = resources[indexPath.row]
        // welbyだったらtokenチェック
        validator.validate() { (isValid) in
            if isValid {
                repository.post(data: data, handler: relodHandler)
            } else {
                print("### open safari ###")
            }
            newResoures[indexPath.row].isTokenValid = isValid
        }
        
    }
    
    func isTokenValid(at indexPath: IndexPath, resources: [ResourceData]) -> Bool {
        let resource = resources[indexPath.row]
        return resource.isTokenValid
    }
    
}

class KencomAutoSelectedState: ProviderSelectedState {
    
    static let shared = KencomAutoSelectedState()
    var repository = Repository()
    var type = KaradaType.walk
    
    func updateData(at indexPath: IndexPath, resources: [ResourceData]) {
        let isEnabled = !resources[indexPath.row].isEnabled
        var newResoures = resources
        newResoures[indexPath.row].isEnabled = isEnabled
        
        let relodHandler = {
            // repositoryからの呼び出す
            self.repository
                .getData(type: self.type, isEnabled: isEnabled, handler: { [weak self](results) in
                    // 成功したら表示変更
                    self?.updateResources(at: indexPath, from: resources, to: results)
                })
        }
        
        let data = resources[indexPath.row]
        newResoures[indexPath.row].isTokenValid = true
        repository.post(data: data, handler: relodHandler)
    }
    
    func isTokenValid(at indexPath: IndexPath, resources: [ResourceData]) -> Bool {
        return true
    }
    
}
