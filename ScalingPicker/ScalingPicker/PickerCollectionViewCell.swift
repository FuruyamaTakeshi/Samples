//
//  PickerCollectionViewCell.swift
//  ScalingPicker
//
//  Created by Furuyama Takeshi on 2017/07/23.
//  Copyright © 2017年 Furuyama Takeshi. All rights reserved.
//

import UIKit

final class PickerCollectionViewCell: UICollectionViewCell {
    var label: UILabel!

    var font = UIFont.systemFont(ofSize: UIFont.systemFontSize)
    var highlightedFont = UIFont.systemFont(ofSize: UIFont.systemFontSize)
    
    var selectedWithAnimation: Bool = false {
        didSet {
            let animation = CATransition()
            animation.type = kCATransitionFade
            animation.duration = 0.15
            self.label.font = self.isSelected ? self.highlightedFont : self.font
        }
    }
    
    private func initialize() {
        self.layer.isDoubleSided = false
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
        
        self.label = UILabel(frame: self.contentView.bounds)
        self.label.backgroundColor = .clear
        self.label.textAlignment = .center
        self.label.textColor = .gray
        self.label.numberOfLines = 1
        self.label.lineBreakMode = .byTruncatingTail
        self.label.highlightedTextColor = .black
        self.label.font = self.font
        self.label.autoresizingMask = [.flexibleTopMargin, .flexibleLeftMargin, .flexibleBottomMargin, .flexibleRightMargin]
        self.contentView.addSubview(self.label)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initialize()
    }
    
    required init!(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func configure(pickerView: ScalePickerView, at indexPath: IndexPath) {
        let title = pickerView.dataSource?.data[indexPath.item]
        self.label.text = title
        self.label.textColor = pickerView.textColor
        self.label.highlightedTextColor = pickerView.highlightedTextColor
        self.label.font = pickerView.font
        self.font = pickerView.font
        self.highlightedFont = pickerView.highlightedFont
        
        self.label.bounds = CGRect(origin: CGPoint.zero, size: (title?.sizeWith(font: pickerView.font, highlightedFont: pickerView.highlightedFont))!)
        self.backgroundColor = .yellow
    }
}

extension String {
    
    func sizeWith(font: UIFont, highlightedFont: UIFont) -> CGSize {
        let string = self as NSString
        let size = string.size(attributes: [NSFontAttributeName: font])
        let highlightedSize = string.size(attributes: [NSFontAttributeName: highlightedFont])
        return CGSize(
            width: ceil(max(size.width, highlightedSize.width)),
            height: ceil(max(size.height, highlightedSize.height)))
    }
}
