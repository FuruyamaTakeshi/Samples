//
//  ViewController.swift
//  SampleLib
//
//  Created by Furuyama.Takeshi0121@gmail.com on 12/28/2018.
//  Copyright (c) 2018 Furuyama.Takeshi0121@gmail.com. All rights reserved.
//

import UIKit
import SampleLib
import RxSwift
import RxCocoa
import HealthKit

class ViewController: UIViewController {

    private let disposeBag = DisposeBag()
    @IBOutlet weak var stepCountLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        Sally()?.sallyMethod()
        if let sally = Sally() {
            sally.requestAuthorization(identifier: .stepCount)
                .subscribe(onNext: { (success) in
                    print(success)
                }, onError: { (error) in
                    print(error)
                })
                .disposed(by: disposeBag)
            
            sally.fetchStepCount()
                .subscribe(onNext: { (steps) in
                    print(steps)
                }, onError: { (error) in
                    print(error)
                })
                .disposed(by: disposeBag)
        }
        
    }

}

