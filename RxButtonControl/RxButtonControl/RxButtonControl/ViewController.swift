//
//  ViewController.swift
//  RxButtonControl
//
//  Created by 古山健司 on 2017/08/20.
//  Copyright © 2017年 古山健司. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet weak var tabButton0: UIButton!
    @IBOutlet weak var tabButton1: UIButton!
    @IBOutlet weak var tabButton2: UIButton!
    @IBOutlet weak var tabButton3: UIButton!
    
    @IBOutlet weak var textField0: UITextField!
    @IBOutlet weak var textField1: UITextField!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var registerButton: UIButton!
    
    private var viewModel = ViewModel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind(to: viewModel)

    }
    
    private func bind(to viewMdoel: ViewModel) {
        
        viewMdoel.textField0Variable.asDriver()
            .drive(onNext: { [weak self] (text) in
                self?.textField0.text = text
            })
            .disposed(by: disposeBag)
        
        viewMdoel.textField1Variable.asDriver()
            .drive(onNext: { [weak self] (text) in
                self?.textField1.text = text
            })
            .disposed(by: disposeBag)
        
        viewMdoel.register
            .subscribe(onNext: { [weak self] (isEnabled) in
                self?.registerButton.isEnabled = isEnabled
            })
            .disposed(by: disposeBag)

        tabButton0.rx.tap
            .subscribe(onNext: { (_) in
                viewMdoel.onTabButtonTap(at: .morningFirst)
            })
            .disposed(by: disposeBag)
        
        tabButton1.rx.tap
            .subscribe(onNext: { (_) in
                viewMdoel.onTabButtonTap(at: .morningSecond)
            })
            .disposed(by: disposeBag)
        
        tabButton2.rx.tap
            .subscribe(onNext: { (_) in
                viewMdoel.onTabButtonTap(at: .nightFirst)
            })
            .disposed(by: disposeBag)
        
        tabButton3.rx.tap
            .subscribe(onNext: { (_) in
                viewMdoel.onTabButtonTap(at: .nightSecond)
            })
            .disposed(by: disposeBag)
        
        textField0.rx.text
            .subscribe(onNext: { text in
                self.viewModel.textField0ValueChanged(text: text ?? "")
            })
            .disposed(by: disposeBag)
        
        textField1.rx.text
            .subscribe(onNext: { text in
                self.viewModel.textField1ValueChanged(text: text ?? "")
            })
            .disposed(by: disposeBag)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

