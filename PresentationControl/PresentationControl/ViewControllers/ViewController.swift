//
//  ViewController.swift
//  PresentationControl
//
//  Created by 古山健司 on 2017/07/15.
//  Copyright © 2017年 古山健司. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak private var showModalButton: UIButton!
    // MARK: - IBOutlet
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: - IBAction
    @IBAction func didPushShowButton(_ sender: Any) {
        let identifier = "NavigationController"
        let controller: UINavigationController!
            = self.storyboard?.instantiateViewController(withIdentifier: identifier) as? UINavigationController
        controller.modalPresentationStyle = .custom
        controller.transitioningDelegate = self
        present(controller, animated: true, completion: {
            //
            print("present")
        })
    }
}

extension ViewController: UIViewControllerTransitioningDelegate {
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        //
        return CustomPresentationController(presentedViewController: presented, presenting: presenting)
    }
}
