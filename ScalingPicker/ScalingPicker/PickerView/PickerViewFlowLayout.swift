//
//  PickerViewFlowLayout.swift
//  ScalingPicker
//
//  Created by Furuyama Takeshi on 2017/07/23.
//  Copyright © 2017年 Furuyama Takeshi. All rights reserved.
//

import UIKit

class PickerViewFlowLayout: UICollectionViewFlowLayout {
    
    var width: CGFloat!
    var midX: CGFloat!
    var maxAngle: CGFloat!
    
    func initialize() {
        self.sectionInset = UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0)
        self.scrollDirection = .horizontal
        self.minimumLineSpacing = 0.0
    }
    
    override init() {
        super.init()
        self.initialize()
    }
    
    required init!(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialize()
    }
    
    override func prepare() {
        let visibleRect = CGRect(origin: collectionView!.contentOffset, size: collectionView!.bounds.size)
        self.midX = visibleRect.midX
        self.width = visibleRect.width / 2
        self.maxAngle = .pi / 2
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        guard let attributes = super.layoutAttributesForItem(at: indexPath)?.copy() as? UICollectionViewLayoutAttributes else {
            return nil
        }
        return attributes
    }
}
