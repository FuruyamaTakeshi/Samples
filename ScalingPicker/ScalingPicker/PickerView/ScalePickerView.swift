//
//  ScalePickerView.swift
//  ScalingPicker
//
//  Created by Furuyama Takeshi on 2017/07/23.
//  Copyright © 2017年 Furuyama Takeshi. All rights reserved.
//

import UIKit

protocol ScalePickerViewDataSource {
    var data: [String] { get set }
    func numberOfItemsInPickerView(_ pickerView: ScalePickerView) -> Int
    func pickerView(_ pickerView: ScalePickerView, titleForItem item: Int) -> String
}

protocol ScalePickerViewDelegate: UIScrollViewDelegate {
    func pickerView(_ pickerView: ScalePickerView, didSelectItem item: Int)
    func pickerView(_ pickerView: ScalePickerView, marginForItem item: Int) -> CGSize
    func pickerView(_ pickerView: ScalePickerView, configureLabel label: UILabel, forItem item: Int)
}

class ScalePickerView: UIView {
    
    var dataSource: ScalePickerViewDataSource?
    weak var delegate: ScalePickerViewDelegate?
    
    lazy var font = UIFont.systemFont(ofSize: 20)
    lazy var highlightedFont = UIFont.boldSystemFont(ofSize: 20)
    
    @IBInspectable lazy var textColor: UIColor = .darkGray
    @IBInspectable lazy var highlightedTextColor: UIColor = .black
    @IBInspectable var interitemSpacing: CGFloat = 0.0
    
    private(set) var selectedItem: Int = 0
    var contentOffset: CGPoint {
        get {
            return collectionView.contentOffset
        }
    }
    
    // MARK: Private Properties
    fileprivate var collectionView: UICollectionView!
    fileprivate var collectionViewLayout: PickerViewFlowLayout {
        let layout = PickerViewFlowLayout()
        return layout
    }
    
    func initialize() {
        self.collectionView?.removeFromSuperview()
        self.collectionView = UICollectionView(frame: bounds, collectionViewLayout: collectionViewLayout)
        self.collectionView.showsHorizontalScrollIndicator = false
        
        self.collectionView.backgroundColor = .clear
        self.collectionView.decelerationRate = UIScrollViewDecelerationRateFast
        self.collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.collectionView.dataSource = self
        self.collectionView.register(
            PickerCollectionViewCell.self,
            forCellWithReuseIdentifier: NSStringFromClass(PickerCollectionViewCell.self))
        self.addSubview(self.collectionView)
        self.collectionView.delegate = self
    }
    
    required init!(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialize()
    }
    
    deinit {
        self.collectionView.delegate = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if let dataSource = self.dataSource, dataSource.numberOfItemsInPickerView(self) > 0 {
            collectionView.collectionViewLayout = collectionViewLayout
            scrollToItem(selectedItem, animated: false)
        }
        collectionView.layer.mask?.frame = collectionView.bounds
    }
    
    override var intrinsicContentSize : CGSize {
        return CGSize(width: UIViewNoIntrinsicMetric, height: max(font.lineHeight, highlightedFont.lineHeight))
    }
    
    func reloadData() {
        invalidateIntrinsicContentSize()
        collectionView.collectionViewLayout.invalidateLayout()
        collectionView.reloadData()
        guard let dataSource = dataSource,  dataSource.numberOfItemsInPickerView(self) > 0 else { return }
        selectItem(selectedItem, animated: false, notifySelection: false)
    }
    
    func scrollToItem(_ item: Int, animated: Bool = false) {
        collectionView.scrollToItem(at: IndexPath(item: item, section: 0), at: .centeredHorizontally, animated: animated)
    }
    
    func selectItem(_ item: Int, animated: Bool = false) {
        selectItem(item, animated: animated, notifySelection: true)
        
    }
    
    private func selectItem(_ item: Int, animated: Bool, notifySelection: Bool) {
        collectionView.selectItem(at: IndexPath(item: item, section: 0), animated: animated, scrollPosition: UICollectionViewScrollPosition())
        scrollToItem(item, animated: animated)
        selectedItem = item
        guard notifySelection else { return }
        delegate?.pickerView(self, didSelectItem: item)
    }
    
    fileprivate func didEndScrolling() {
        let center = convert(collectionView.center, to: collectionView)
        guard let indexPath = collectionView.indexPathForItem(at: center) else { return }
        selectItem(indexPath.item, animated: true, notifySelection: true)
    }
    
}

extension ScalePickerView: UICollectionViewDataSource {
    
    // MARK: UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        guard let dataSource = self.dataSource else { return 0 }
        return dataSource.numberOfItemsInPickerView(self) > 0 ? 1 : 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataSource != nil ? self.dataSource!.numberOfItemsInPickerView(self) : 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(PickerCollectionViewCell.self), for: indexPath) as! PickerCollectionViewCell
        cell.selectedWithAnimation = (indexPath.item == self.selectedItem)
        cell.configure(pickerView: self, at: indexPath)
        
        guard let delegate = self.delegate else { return cell }
        let margin = delegate.pickerView(self, marginForItem: indexPath.item)
        cell.label.frame = cell.label.frame.insetBy(dx: -margin.width, dy: -margin.height)
        cell.label.backgroundColor = .white
        return cell
    }
}

extension ScalePickerView: UICollectionViewDelegate {
    // MARK: UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectItem(indexPath.item, animated: true)
    }
    
    // MARK: UIScrollViewDelegate
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        delegate?.scrollViewDidEndDecelerating?(scrollView)
        didEndScrolling()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        delegate?.scrollViewDidEndDragging?(scrollView, willDecelerate: decelerate)
        guard !decelerate else { return }
        didEndScrolling()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        delegate?.scrollViewDidScroll?(scrollView)
        CATransaction.begin()
        CATransaction.setValue(kCFBooleanTrue, forKey: kCATransactionDisableActions)
        collectionView.layer.mask?.frame = collectionView.bounds
        CATransaction.commit()
    }
    
}

// MARK: UICollectionViewDelegateFlowLayout
extension ScalePickerView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var size = CGSize(width: self.interitemSpacing, height: collectionView.bounds.size.height)
        guard let title = self.dataSource?.pickerView(self, titleForItem: indexPath.item) else { return size }
        let titleSize = title.sizeWith(font: font, highlightedFont: highlightedFont)
        size.width += titleSize.width
        guard let margin = self.delegate?.pickerView(self, marginForItem: indexPath.item) else { return size }
        size.width += margin.width * 2
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let number = self.collectionView(collectionView, numberOfItemsInSection: section)
        let firstIndexPath = IndexPath(item: 0, section: section)
        let firstSize = self.collectionView(collectionView, layout: collectionView.collectionViewLayout, sizeForItemAt: firstIndexPath)
        let lastIndexPath = IndexPath(item: number - 1, section: section)
        let lastSize = self.collectionView(collectionView, layout: collectionView.collectionViewLayout, sizeForItemAt: lastIndexPath)
        return UIEdgeInsetsMake(
            0, (collectionView.bounds.size.width - firstSize.width) / 2,
            0, (collectionView.bounds.size.width - lastSize.width) / 2
        )
    }
}
