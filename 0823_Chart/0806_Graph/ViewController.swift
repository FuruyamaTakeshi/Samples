//
//  ViewController.swift
//  0806_Graph
//
//  Created by Furuken on 2021/08/06.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let hosting = UIHostingController(rootView: BarChartView())
        self.addChild(hosting)
        self.view.addSubview(hosting.view)
        hosting.didMove(toParent: self)
        
        hosting.view.translatesAutoresizingMaskIntoConstraints = false
        hosting.view.heightAnchor.constraint(equalToConstant: 320).isActive = true
        hosting.view.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16).isActive = true
        hosting.view.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -16).isActive = true
        hosting.view.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
    }


}

