//
//  CustomPresentationController.swift
//  PresentationControl
//
//  Created by 古山健司 on 2017/07/15.
//  Copyright © 2017年 古山健司. All rights reserved.
//

import UIKit

public enum AlertStyle {
    case `default`, modern
}

class CustomPresentationController: UIPresentationController {
    var overlay: UIView!
    var alertStyle: AlertStyle = .default
    var maxAlertViewWidth: CGFloat? = 450
    
    private var spacing: Int = 16
    private var titleSubtitleSpacing: Int = 16
    private var bottomSpacing: Int = 32
    fileprivate var backgroundImage: UIImageView = UIImageView()
    fileprivate var alertView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1.00)
        return view
    }()
    override func presentationTransitionWillBegin() {
        let containerView = self.containerView!
        overlay = UIView(frame: containerView.bounds)
        overlay.gestureRecognizers = [UITapGestureRecognizer(target: self, action: #selector(overlayDidTouch(sender:)))]
        overlay.backgroundColor = .black
        overlay.alpha = 0.0
        containerView.insertSubview(overlay, at: 0)
        presentingViewController.view.addSubview(backgroundImage)
        
        setup(backgroundImage: backgroundImage)
        print("presentedView: \(String(describing: presentedView))")
        presentedViewController.transitionCoordinator?.animate(alongsideTransition: {[unowned self] _ in
            self.overlay.alpha = 0.25
            }, completion: { _ in })
    }
    
    override func dismissalTransitionWillBegin() {
        presentedViewController.transitionCoordinator?
            .animate(alongsideTransition: {[unowned self] _ in
                self.overlay.alpha = 0.0
                }, completion: nil)
    }
    
    override func dismissalTransitionDidEnd(_ completed: Bool) {
        guard completed else { return }
        overlay.removeFromSuperview()
        backgroundImage.subviews.forEach { $0.removeFromSuperview() }
        presentingViewController.view.subviews.filter { $0.tag == 3 }.forEach { $0.removeFromSuperview() }
    }
    
    override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        return CGSize(width: floor(parentSize.width / 1.5), height: parentSize.height / 2)
    }
    
    override var frameOfPresentedViewInContainerView: CGRect {
        var presentedViewFrame = CGRect.zero
        let containerBounds = containerView!.bounds
        presentedViewFrame.size = size(forChildContentContainer: presentedViewController, withParentContainerSize: containerBounds.size)
        print("containerBounds: \(containerBounds)")
        print("presentedViewFrame: \(presentedViewFrame)")
        presentedViewFrame.origin.x = floor((containerBounds.size.width - presentedViewFrame.size.width) / 2.0)
        presentedViewFrame.origin.y = floor((containerBounds.size.height - presentedViewFrame.size.height) / 2.0)
        return presentedViewFrame
    }
    
    override func containerViewWillLayoutSubviews() {
        overlay.frame = containerView!.bounds
        presentedView!.frame = frameOfPresentedViewInContainerView
    }
    
    override func containerViewDidLayoutSubviews() {
        //
    }
    
    @objc func overlayDidTouch(sender: AnyObject) {
        self.presentedViewController.dismiss(animated: true, completion: nil)
    }
    
    private func clearViews(view: UIView, backgroundImage: UIImageView) {
        view.subviews.filter { !($0 is UIButton) }.forEach { $0.removeFromSuperview() }
        backgroundImage.subviews.forEach { $0.removeFromSuperview() }
    }
    
    private func setup(backgroundImage: UIImageView) {
        overlay.subviews.forEach { $0.removeFromSuperview() }
        // Set up background image
        backgroundImage.frame = overlay.bounds
        backgroundImage.tag = 3
        backgroundImage.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        setupBlur(with: backgroundImage)
    }
    
    private func setupBlur(with backgroundImage: UIImageView) {
        backgroundImage.image = capture(of: presentingViewController.view)
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = backgroundImage.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        let vibrancyEffect = UIVibrancyEffect(blurEffect: blurEffect)
        let vibrancyEffectView = UIVisualEffectView(effect: vibrancyEffect)
        vibrancyEffectView.frame = backgroundImage.bounds
        vibrancyEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.contentView.addSubview(vibrancyEffectView)
        backgroundImage.addSubview(blurEffectView)
    }
    
    private func capture(of view: UIView) -> UIImage? {
        guard let window = view.window else { return nil }
        UIGraphicsBeginImageContextWithOptions(window.bounds.size, false, window.screen.scale)
        window.drawHierarchy(in: window.bounds, afterScreenUpdates: false)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
}
