//
//  ViewController.swift
//  SampleSelectableDate
//
//  Created by 古山健司 on 2017/08/12.
//  Copyright © 2017年 古山健司. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SwiftDate

class ViewController: UIViewController {

    enum MeasuredValueType {
        case weight, bloodPressure
        
        var title: String {
            switch self {
            case .weight:
                return "Weight"
            case .bloodPressure:
                return "BloodPressure"
            }
        }
        
        func factory() -> InputManualViewController {
            switch self {
            case .weight:
                return StoryboardScene.InputWeightViewController.initialViewController()
            case .bloodPressure:
                return StoryboardScene.InputBloodPressureViewController.initialViewController()
            }
        }
    }
    
    @IBOutlet weak var inputManuallyButton: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var valueTypeSwitch: UISwitch!
    @IBOutlet weak var selectPickerView: UIPickerView!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dataSource = [MeasuredValueType.weight, MeasuredValueType.bloodPressure]
        
        inputManuallyButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.dateLabel.text = "\(Date())"
                if let atRow = self?.selectPickerView.selectedRow(inComponent: 0) {
                    self?.pushViewController(viewController: dataSource[atRow].factory())
                }
            })
            .disposed(by: disposeBag)
    
        Observable.just(dataSource)
            .bind(to: selectPickerView.rx.itemTitles) { _, item in
                return item.title
            }
            .disposed(by: disposeBag)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func pushViewController<T: UIViewController>(viewController: T) where T: ManuallyInputable {
        viewController.selectedDate = Date().startOfDay
        self.present(viewController, animated: true, completion: nil)
    }
    
    private func pushWeightViewController() {
        let viewController = StoryboardScene.InputWeightViewController.initialViewController()
        pushViewController(viewController: viewController)
    }

    private func pushBloodPressureViewController() {
        let viewController = StoryboardScene.InputBloodPressureViewController.initialViewController()
        pushViewController(viewController: viewController)
    }


}

