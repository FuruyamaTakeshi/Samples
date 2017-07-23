//
//  InputViewController.swift
//  ScalingPicker
//
//  Created by Furuyama Takeshi on 2017/07/23.
//  Copyright © 2017年 Furuyama Takeshi. All rights reserved.
//

import UIKit

class InputViewController: UIViewController, ScalePickerViewDataSource, ScalePickerViewDelegate {
    @IBOutlet weak var pickerView: ScalePickerView!

    var data = (0..<100).map { String($0) }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        self.pickerView.dataSource?.data = data
        
        self.pickerView.font = UIFont.systemFont(ofSize: 20)
        self.pickerView.highlightedFont = UIFont.boldSystemFont(ofSize: 20)
        self.pickerView.reloadData()
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfItemsInPickerView(_ pickerView: ScalePickerView) -> Int {
        return self.data.count
    }

    func pickerView(_ pickerView: ScalePickerView, titleForItem item: Int) -> String {
        return self.data[item]
    }
    
    func pickerView(_ pickerView: ScalePickerView, didSelectItem item: Int) {
        print("\(self.data[item])")
    }
    
    func pickerView(_ pickerView: ScalePickerView, marginForItem item: Int) -> CGSize {
        return CGSize(width: 12, height: 12)
    }
    
    func pickerView(_ pickerView: ScalePickerView, configureLabel label: UILabel, forItem item: Int) {
        //
    }
}
