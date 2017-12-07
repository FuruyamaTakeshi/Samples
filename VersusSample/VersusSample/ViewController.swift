//
//  ViewController.swift
//  VersusSample
//
//  Created by 古山健司 on 2017/12/03.
//  Copyright © 2017年 古山健司. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet weak var playerNameView: UIView!
    @IBOutlet weak var secondPlayerNameView: UIView!
    
    @IBOutlet weak var vsLabel: UILabel!
    @IBOutlet weak var player1Label: UILabel!
    @IBOutlet weak var player2Label: UILabel!
    @IBOutlet weak var showButton: UIButton!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        playerNameView.layer.shadowColor = UIColor.cyan.cgColor
        playerNameView.layer.shadowOpacity = 1.0
        playerNameView.layer.shadowOffset = CGSize(width: 0, height: 5)
        playerNameView.layer.shadowRadius = 0
        playerNameView.layer.shouldRasterize = true
        
        showButton.rx.tap.asDriver()
            .drive(onNext: { [weak self] () in
                self?.doAnimation()
                self?.animatePlayersBar()
            })
            .disposed(by: disposeBag)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        doAnimation()
        animatePlayersBar()
    }

    private func doAnimation() {
        self.playerNameView.frame.origin.x -= self.view.frame.width
        UIView.animate(withDuration: 2.0,
                       animations:{
                        self.playerNameView.frame.origin.x += self.view.frame.width
        }, completion: nil)
        vsLabel.isHidden = true
        player1Label.isHidden = true
        player2Label.isHidden = true
        vsLabel.fadeIn(type: .slow, completed: nil)
        
    }
    
    private func animatePlayersBar() {
        playerNameView.frame.origin.x -= self.view.frame.width
        secondPlayerNameView.frame.origin.x += self.view.frame.width
        UIView.animate(withDuration: 1.0, delay: 0.0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.0, options: [.curveEaseInOut], animations: {
            self.playerNameView.frame.origin.x += self.view.frame.width
        }, completion: { (finished) in
            UIView.animate(withDuration: 1.0, animations: {
                self.secondPlayerNameView.frame.origin.x -= self.view.frame.width
            }, completion: nil)
        })
    }

}

enum FadeType: TimeInterval {
    case normal = 0.2
    case slow = 3.0
}

extension UIView {
    func fadeIn(type: FadeType = .normal, completed: (() -> Void)? = nil) {
        fadeIn(duration: type.rawValue, completed: completed)
    }
    
    func fadeIn(duration: TimeInterval, completed: (() -> Void)? = nil) {
        alpha = 1
        let transformScale: CGAffineTransform = CGAffineTransform(scaleX: 0.1, y: 0.1)

        isHidden = false
        transform = transformScale
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 1
            self.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }, completion: { (finshied) in
            self.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            completed?()
        })
    }
}

