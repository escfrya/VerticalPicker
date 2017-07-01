//
//  VerticalPicker.swift
//  VerticalPicker
//
//  Created by Igor on 01/07/2017.
//  Copyright © 2017 xuli. All rights reserved.
//

import Foundation

open class VerticalPicker: UIView {
    open var minValue: CGFloat = 0 {
        didSet {
            assert(minValue <= maxValue, "minValue should be less then maxValue")
            updateValueForCurrentTopOffset()
        }
    }
    open var maxValue: CGFloat = 1 {
        didSet {
            assert(minValue <= maxValue, "minValue should be less then maxValue")
            updateValueForCurrentTopOffset()
        }
    }
    open var value: CGFloat {
        get {
            return currentValue
        }
        set {
            updateOffsetFor(value: newValue)
        }
    }
    open var valueChanged: ((CGFloat, Bool) -> Void)?
    open var backgroundImage: UIImage? {
        didSet {
            backgroundView.image = backgroundImage
        }
    }
    open var iconImage: UIImage? {
        didSet {
            iconView.image = iconImage
        }
    }
    open var iconBottomSpace: CGFloat = 20 {
        didSet {
            iconBottomConstraint.constant = -iconBottomSpace
        }
    }
    open var reversed: Bool = false {
        didSet {
            updateValueForCurrentTopOffset()
        }
    }
    
    open var backgroundView: UIImageView = {
        var view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var progressView: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        return view
    }()
    private lazy var iconView: UIImageView = {
        var view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var progressTopConstraint: NSLayoutConstraint!
    private var iconBottomConstraint: NSLayoutConstraint!
    private var currentValue: CGFloat = 0
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    private func commonInit() {
        configurateViews()
        configurateLayout()
    }
    
    private func configurateViews() {
        layer.cornerRadius = 20
        layer.masksToBounds = true
        
        addSubview(backgroundView)
        addSubview(progressView)
        addSubview(iconView)
        
        addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(VerticalPicker.pan(recognizer:))))
    }
    
    private func configurateLayout() {
        layoutMargins = UIEdgeInsets.zero
        
        let views = [
            "backgroundView": backgroundView,
            "progressView": progressView
        ]
        var allConstraints: [NSLayoutConstraint] = []
        
        allConstraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat:"V:|-[backgroundView]-|", options: [], metrics: nil, views: views))
        allConstraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat:"H:|-[backgroundView]-|", options: [], metrics: nil, views: views))
        progressTopConstraint = NSLayoutConstraint(item: progressView, attribute: .top, relatedBy: .equal, toItem: progressView.superview, attribute: .top, multiplier: 1, constant: 0)
        allConstraints.append(progressTopConstraint)
        allConstraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat:"H:|-[progressView]-|", options: [], metrics: nil, views: views))
        allConstraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat:"V:[progressView]-|", options: [], metrics: nil, views: views))
        allConstraints.append(NSLayoutConstraint(item: iconView, attribute: .centerX, relatedBy: .equal, toItem: iconView.superview, attribute: .centerX, multiplier: 1, constant: 0))
        iconBottomConstraint = NSLayoutConstraint(item: iconView, attribute: .bottom, relatedBy: .equal, toItem: iconView.superview, attribute: .bottom, multiplier: 1, constant: -iconBottomSpace)
        allConstraints.append(iconBottomConstraint)
        
        NSLayoutConstraint.activate(allConstraints)
    }
    
    @objc private func pan(recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .changed, .ended, .failed, .cancelled:
            let translation = recognizer.translation(in: self)
            let newTopOffset = progressTopConstraint.constant + translation.y
            let isFinal = recognizer.state != .changed
            updateValueFor(topOffset: newTopOffset, isFinal: isFinal)
            recognizer.setTranslation(CGPoint.zero, in: self)
        default:
            break
        }
    }
    
    private func updateValueForCurrentTopOffset() {
        updateValueFor(topOffset: progressTopConstraint.constant, isFinal: true)
    }
    private func updateValueFor(topOffset: CGFloat, isFinal: Bool) {
        progressTopConstraint.constant = topOffset
        let value = valueBy(topOffset: topOffset)
        update(value: value, isFinal: isFinal)
    }
    private func update(value: CGFloat, isFinal: Bool) {
        currentValue = value
        raise(value: value, isFinal: isFinal)
    }
    
    private func updateOffsetFor(value: CGFloat) {
        progressTopConstraint.constant = topOffsetBy(value: value)
        update(value: value, isFinal: true)
    }
    
    internal func raise(value: CGFloat, isFinal: Bool) {
        valueChanged?(value, isFinal)
    }
    
    private func valueBy(topOffset: CGFloat) -> CGFloat {
        let constrainedTopOffset = min(max(0, topOffset), bounds.height)
        let constrainedOffset = reversed ? constrainedTopOffset : bounds.height - constrainedTopOffset
        return minValue + (maxValue - minValue)*constrainedOffset/bounds.height
    }
    private func topOffsetBy(value: CGFloat) -> CGFloat {
        let constrainedTopValue = min(max(minValue, value), maxValue)
        let constrainedValue = (constrainedTopValue - minValue)/(maxValue - minValue)*bounds.height
        return reversed ? constrainedValue : bounds.height - constrainedValue
    }
}
