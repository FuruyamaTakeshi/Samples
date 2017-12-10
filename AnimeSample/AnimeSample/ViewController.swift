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
    
    var trailOrigin: CGFloat = 0
    var leadOrigin: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let blueCenterX = blueView.center.x
        let redCenterX = redView.center.x
        trailOrigin = blueViewTrailConstraint.constant
        leadOrigin = redViewLeadingConstraint.constant
        
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
                    self.move(blueCenterX: newBlueCenterX, redCenterX: newRedCenterX)
                }

            })
            .disposed(by: disposeBag)
        
        reverseButton.rx.tap.asDriver()
            .drive(onNext: { [unowned self] () in

                if self.blueView.center.x > self.redView.center.x {
                    let newBlueCenterX: CGFloat
                    let newRedCenterX: CGFloat
                    newBlueCenterX = self.redView.center.x
                    newRedCenterX = self.blueView.center.x
                    self.move(blueCenterX: newBlueCenterX, redCenterX: newRedCenterX)
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
    
    private func move(blueCenterX: CGFloat, redCenterX: CGFloat) {
        UIView.animateKeyframes(withDuration: 1, delay: 0, options: [], animations: {
            let constraint0: CGFloat
            let constraint1: CGFloat
            let finalConstraint0: CGFloat
            let finalConstraint1: CGFloat
            if self.blueView.center.x < self.redView.center.x {
                constraint0 = self.blueViewTrailConstraint.constant / 2
                constraint1 = self.redView.frame.minX / 2
                finalConstraint0 = 16
                finalConstraint1 = 16
            } else {
                finalConstraint0 = self.view.frame.width - self.redView.frame.maxX
                finalConstraint1 = self.blueView.frame.minX
                constraint0 = finalConstraint0 / 2
                constraint1 = finalConstraint1 / 2
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1, animations: {
                self.blueView.center.x = blueCenterX / 2 +  redCenterX / 2
                self.redView.center.x = redCenterX / 2
                self.blueViewTrailConstraint.constant = constraint0
                self.redViewLeadingConstraint.constant = constraint1
                self.blueView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
                self.redView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)

                self.view.layoutIfNeeded()
            })
            
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5, animations: {
                self.blueView.center.x = blueCenterX
                self.redView.center.x = redCenterX
                self.blueViewTrailConstraint.constant = finalConstraint0
                self.redViewLeadingConstraint.constant = finalConstraint1
                self.blueView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                self.redView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                self.view.layoutIfNeeded()
            })
            
        }, completion: nil)
    }
    
}

