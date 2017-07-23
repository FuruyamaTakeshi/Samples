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
    var imageView: UIImageView!
    var font = UIFont.systemFont(ofSize: UIFont.systemFontSize)
    var highlightedFont = UIFont.systemFont(ofSize: UIFont.systemFontSize)
    var _selected: Bool = false {
        didSet(selected) {
            let animation = CATransition()
            animation.type = kCATransitionFade
            animation.duration = 0.15
            self.label.layer.add(animation, forKey: "")
            self.label.font = self.isSelected ? self.highlightedFont : self.font
        }
    }
    
    func initialize() {
        self.layer.isDoubleSided = false
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
        
        self.label = UILabel(frame: self.contentView.bounds)
        self.label.backgroundColor = UIColor.clear
        self.label.textAlignment = .center
        self.label.textColor = UIColor.gray
        self.label.numberOfLines = 1
        self.label.lineBreakMode = .byTruncatingTail
        self.label.highlightedTextColor = UIColor.black
        self.label.font = self.font
        self.label.autoresizingMask = [.flexibleTopMargin, .flexibleLeftMargin, .flexibleBottomMargin, .flexibleRightMargin]
        self.contentView.addSubview(self.label)
        
        self.imageView = UIImageView(frame: self.contentView.bounds)
        self.imageView.backgroundColor = UIColor.clear
        self.imageView.contentMode = .center
        self.imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.contentView.addSubview(self.imageView)
    }
    
    init() {
        super.init(frame: CGRect.zero)
        self.initialize()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initialize()
    }
    
    required init!(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialize()
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
