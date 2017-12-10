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
                print("const: \(String(describing: self.blueViewTrailConstraint.constant))")
                
                if self.blueView.center.x < self.redView.center.x {
                    let newBlueCenterX: CGFloat
                    let newRedCenterX: CGFloat
                    newBlueCenterX = self.redView.center.x
                    newRedCenterX = self.blueView.center.x
                    self.animateWin(leftCenterX: newBlueCenterX, rightCenterX: newRedCenterX)
                }

            })
            .disposed(by: disposeBag)
        
        reverseButton.rx.tap.asDriver()
            .drive(onNext: { [unowned self] () in
                let newBlueCenterX: CGFloat
                let newRedCenterX: CGFloat
                if self.blueView.center.x > self.redView.center.x {
                    newBlueCenterX = self.redView.center.x
                    newRedCenterX = self.blueView.center.x
                    self.animate(leftCenterX: newBlueCenterX, rightCenterX: newRedCenterX)
                } else {
                    newBlueCenterX = self.redView.center.x
                    newRedCenterX = self.blueView.center.x
                }
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

    private func animateWin(leftCenterX: CGFloat, rightCenterX: CGFloat) {
        UIView.animateKeyframes(withDuration: 1, delay: 0, options: [], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1, animations: {
                self.blueView.center.x = leftCenterX / 2
                self.redView.center.x = rightCenterX * 2
                self.blueViewTrailConstraint.constant = 16 + leftCenterX / 2
                self.view.layoutIfNeeded()
            })
            
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5, animations: {
                self.blueView.center.x = leftCenterX
                self.redView.center.x = rightCenterX
                self.blueViewTrailConstraint.constant = 16
                self.view.layoutIfNeeded()
            })
            
        }, completion: nil)
    }
    
    private func animate(leftCenterX: CGFloat, rightCenterX: CGFloat) {
        UIView.animateKeyframes(withDuration: 1, delay: 0, options: [], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1, animations: {
                self.blueView.center.x = leftCenterX * 2
                self.redView.center.x = rightCenterX / 2
                self.view.layoutIfNeeded()
            })
            
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5, animations: {
                self.blueView.center.x = leftCenterX
                self.redView.center.x = rightCenterX
                self.blueViewTrailConstraint.constant = 16 + rightCenterX - leftCenterX

                self.view.layoutIfNeeded()
            })
            
        }, completion: nil)
    }
}

