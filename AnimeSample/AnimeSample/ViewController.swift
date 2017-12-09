//
//  ViewController.swift
//  AnimeSample
//
//  Created by 古山健司 on 2017/12/09.
//  Copyright © 2017年 古山健司. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    private let disposeBag = DisposeBag()

    @IBOutlet weak var redView: UIView!
    @IBOutlet weak var blueView: UIView!
    @IBOutlet weak var moveButton: UIButton!
    @IBOutlet weak var reverseButton: UIButton!
    
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var blueViewTrailConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var redViewLeadingConstraint: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        let blueCenterX = blueView.center.x
        let redCenterX = redView.center.x
        print(blueViewTrailConstraint.constant)
        
        moveButton.rx.tap.asDriver()
            .drive(onNext: { [unowned self]() in
                print("did tap")
                self.animate(blueCenterX: blueCenterX, redCenterX: redCenterX)
                print("const: \(String(describing: self.blueViewTrailConstraint.constant))")

            })
            .disposed(by: disposeBag)
        
        reverseButton.rx.tap.asDriver()
            .drive(onNext: { [unowned self] () in
                self.animate(blueCenterX: redCenterX, redCenterX: blueCenterX)
            })
            .disposed(by: disposeBag)
        
        resetButton.rx.tap.asDriver()
            .drive(onNext: { [unowned self] () in
                self.blueView.center.x = blueCenterX
                self.redView.center.x = redCenterX
                self.blueViewTrailConstraint.constant = 16
                self.redViewLeadingConstraint.constant = 16
                self.view.layoutIfNeeded()
                print("bx: \(String(describing: self.blueView.center.x)), rx: \(String(describing: self.redView.center.x))")
            })
            .disposed(by: disposeBag)
    }

    private func animate(blueCenterX: CGFloat, redCenterX: CGFloat) {
        UIView.animateKeyframes(withDuration: 3, delay: 0, options: [], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5, animations: {
                self.blueView.center.x = redCenterX
                self.blueViewTrailConstraint.constant = 16
                self.redView.center.x = blueCenterX
            })
        }, completion: nil)
    }

}

