//
//  ViewController.swift
//  MyRxSample
//
//  Created by Furuyama Takeshi on 2017/08/05.
//  Copyright © 2017年 Furuyama Takeshi. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var refreshButton: UIButton!
    
    private let disposeBag = DisposeBag()
    private var viewModel = ViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        bind(to: viewModel)
        viewModel.viewDidLoad()
    }

    private func bind(to viewModel: ViewModel) {
        
        viewModel.dateVariable.asDriver()
            .drive(onNext: { [weak self] text in
                self?.dateLabel.text = text
            })
            .disposed(by: disposeBag)
        
        viewModel.weightVariable.asDriver()
            .drive(onNext: { [weak self] value in
                self?.weightLabel.text = "\(value)"
            })
            .disposed(by: disposeBag)
        
        viewModel.dataEnableVariable.asDriver()
            .drive(onNext: { [weak self] enable in
                self?.dateLabel.textColor = enable ? .black : .red
                self?.weightLabel.textColor = enable ? .black : .lightGray
            })
            .disposed(by: disposeBag)
        
        prevButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.viewModel.onPrevButtonDidTap()
            })
            .disposed(by: disposeBag)
        
        nextButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.viewModel.onNextButtonDidTap()
            })
            .disposed(by: disposeBag)
        
        refreshButton.rx.tap
            .subscribe(onNext: {[weak self] in
                self?.viewModel.viewDidLoad()
            })
            .disposed(by: disposeBag)
        
    }

}

