//
//  ViewController.swift
//  ScalingPicker
//
//  Created by Furuyama Takeshi on 2017/07/23.
//  Copyright © 2017年 Furuyama Takeshi. All rights reserved.
//

import UIKit

class ViewController: UIViewController, ScalePickerViewDataSource, ScalePickerViewDelegate {
    
    var titles = ["Tokyo", "Kanagawa", "Osaka", "Aichi", "Saitama", "Chiba", "Hyogo", "Hokkaido", "Fukuoka", "Shizuoka"]

    override func viewDidLoad() {
        super.viewDidLoad()

        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        self.pickerView.dataSource?.titles = titles
        
        self.pickerView.font = UIFont(name: "HelveticaNeue-Light", size: 20)!
        self.pickerView.highlightedFont = UIFont(name: "HelveticaNeue", size: 20)!
        self.pickerView.reloadData()
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfItemsInPickerView(_ pickerView: ScalePickerView) -> Int {
        return self.titles.count
    }

    func pickerView(_ pickerView: ScalePickerView, titleForItem item: Int) -> String {
        return self.titles[item]
    }
    
    func pickerView(_ pickerView: ScalePickerView, didSelectItem item: Int) {
        print("Your favorite city is \(self.titles[item])")
    }
    
    func pickerView(_ pickerView: ScalePickerView, marginForItem item: Int) -> CGSize {
        return CGSize(width: 12, height: 12)
    }
    
    func pickerView(_ pickerView: ScalePickerView, configureLabel label: UILabel, forItem item: Int) {
        //
    }
    
}
