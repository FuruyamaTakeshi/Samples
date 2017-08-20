//
//  ViewModel.swift
//  RxButtonControl
//
//  Created by 古山健司 on 2017/08/20.
//  Copyright © 2017年 古山健司. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class ViewModel {
    
    enum ButtonIndex {
        case morningFirst, morningSecond, nightFirst, nightSecond
    }
    
    var isResisterButtonEnableVariable = Variable<Bool>(false)
    var textField0Variable = Variable<String>("")
    var textField1Variable = Variable<String>("")
    
    var register: Observable<Bool> {
        return Observable.combineLatest(textField0Variable.asObservable(), textField1Variable.asObservable()) { [weak self] (textField0Variable, textField1Variable) in
            let notEmpty = !textField1Variable.isEmpty && !textField0Variable.isEmpty
            return notEmpty && (self?.state is OnTabState)
        }
    }
    
    var index: [ButtonIndex : Bool]?
    
    var dataSource: [BloodPressureDataModel]
    
    var createData: (Date) -> [BloodPressureDataModel] = { date in
        return [0, 1, 2, 3].map {_ in
            let systolic = Int(arc4random() % 200)
            let diastolic = Int(arc4random() % 200)
            return BloodPressureDataModel(id: "", date: date, systolic: systolic, diastolic: diastolic)
        }
    }
    
    var state: TabState?
    
    init() {
        self.dataSource = createData(Date())
        index = [ButtonIndex.morningFirst : true]
        state = OnTabState.shared
    }
    
    func onTabButtonTap(at index: ButtonIndex) {
        // 切替
        state?.index = index
        state?.changeTabState(of: self)
        state?.setTextField0(of: self)
        state?.setTextField1(of: self)
        state?.setRegisterButton(of: self)
        
    }
    
    func textField0ValueChanged(text: String) {
        textField0Variable.value = text
    }
    
    func textField1ValueChanged(text: String) {
        textField1Variable.value = text
    }
    
}

struct BloodPressureDataModel {
    var id = UUID().uuidString
    var date: Date
    var systolic: Int
    var diastolic: Int
}

protocol TabState {
    var index: ViewModel.ButtonIndex { get set }
    func changeTabState(of context: ViewModel)
    func setTextField0(of context: ViewModel)
    func setTextField1(of context: ViewModel)
    func setRegisterButton(of context: ViewModel)
}

class OnTabState: TabState {
    
    static let shared = OnTabState()
    
    private init() { }
    var index: ViewModel.ButtonIndex = .morningFirst
    
    
    func changeTabState(of context: ViewModel) {
        context.state = OffTabState.shared
        print("\(index) is pushed. isEnabled: off")
    }
    
    func setTextField0(of context: ViewModel) {
        context.textField0Variable.value = "\(context.dataSource[index.hashValue].systolic)"
    }
    
    func setTextField1(of context: ViewModel) {
        context.textField1Variable.value = "\(context.dataSource[index.hashValue].diastolic)"
    }
    
    func setRegisterButton(of context: ViewModel) {
        context.isResisterButtonEnableVariable.value = !context.textField1Variable.value.isEmpty &&
        !context.textField0Variable.value.isEmpty
    }
}

class OffTabState: TabState {
    
    static let shared = OffTabState()
    var index: ViewModel.ButtonIndex = .morningFirst

    private init() { }
    
    func changeTabState(of context: ViewModel) {
        context.state = OnTabState.shared
        print("\(index) is pushed. isEnabled: on")
    }
    
    func setTextField0(of context: ViewModel) {
        context.textField0Variable.value = ""
    }
    
    func setTextField1(of context: ViewModel) {
        context.textField1Variable.value = ""

    }
    
    func setRegisterButton(of context: ViewModel) {
        context.isResisterButtonEnableVariable.value = false
    }
}
