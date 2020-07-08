//
//  GradientProgressView.swift
//  GradientProgressViewExample
//
//  Created by carefree on 2020/6/13.
//  Copyright © 2020 carefree. All rights reserved.
//

import UIKit

open class GradientProgressView: UIView {
    
    //进度条完成部分的渐变颜色，设置单个为纯色，设置多个为渐变色
    public var progressColors: [UIColor] = [.systemBlue] {
        didSet {
            if progressColors.count == 0 {
                gradientLayer.colors = nil
            } else if progressColors.count == 1 {
                let color = progressColors[0]
                gradientLayer.colors = [color, color].map { $0.cgColor }
            } else {
                gradientLayer.colors = progressColors.map { $0.cgColor }
            }
        }
    }
    
    //进度条完成部分的圆角半径
    public var progressCornerRadius: CGFloat = 0 {
        didSet {
            maskLayer.cornerRadius = progressCornerRadius
        }
    }
    
    //进度完成部分的内间距
    public var progressEdgeInsets: UIEdgeInsets = .zero {
        didSet {
            setNeedsLayout()
        }
    }
    
    //当前进度
    public var progress: Float {
        get {
            return privateProgress
        }
        set {
            setProgress(newValue, animated: false)
        }
    }
    
    //渐变Layer
    public let gradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.anchorPoint = .zero
        layer.startPoint = .zero
        layer.endPoint = CGPoint(x: 1.0, y: 0.0)

        return layer
    }()
    
    //动画持续时间
    public var animationDuration: TimeInterval = 0.3
    
    //动画时间函数
    public var timingFunction: CAMediaTimingFunction = CAMediaTimingFunction(name: .default)
    
    //进度更新动画过程中的回调，在这里可以拿到当前进度及进度条的frame
    public var progressUpdating: ((Float, CGRect) -> ())?
    
    
    private var privateProgress: Float = 0
    private let maskLayer: CALayer = {
        let layer = CALayer()
        layer.backgroundColor = UIColor.white.cgColor

        return layer
    }()
    
    // MARK: - Lifecycle
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        
        commonInit()
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        gradientLayer.frame = bounds.inset(by: progressEdgeInsets)
        var bounds = gradientLayer.bounds
        bounds.size.width *= CGFloat(progress)
        maskLayer.frame = bounds
    }
    
    // MARK: - Private
    private func commonInit() {
        let color = progressColors[0]
        gradientLayer.colors = [color, color].map { $0.cgColor }
        gradientLayer.mask = maskLayer
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    @objc private func displayLinkAction() {
        guard let frame = maskLayer.presentation()?.frame else { return }
        let progress = frame.size.width / gradientLayer.frame.size.width
        progressUpdating?(Float(progress), frame)
    }
    
    // MARK: - Public
    public func setProgress(_ progress: Float, animated: Bool) {
        let validProgress = min(1.0, max(0.0, progress))
        if privateProgress == validProgress {
            return
        }
        privateProgress = validProgress
        
        //动画时长
        var duration = animated ? animationDuration : 0
        if duration < 0 {
            duration = 0
        }
        
        var displayLink: CADisplayLink?
        if duration > 0 {
            //开启CADisplayLink
            displayLink = CADisplayLink(target: self, selector: #selector(displayLinkAction))
            //使用common模式，使其在UIScrollView滑动时依然能得到回调
            displayLink?.add(to: .main, forMode: .common)
        }
        
        CATransaction.begin()
        CATransaction.setAnimationDuration(duration)
        CATransaction.setAnimationTimingFunction(timingFunction)
        CATransaction.setCompletionBlock {
            //停止CADisplayLink
            displayLink?.invalidate()
            if duration == 0 {
                //更新回调
                self.progressUpdating?(validProgress, self.maskLayer.frame)
            } else {
                if let _ = self.maskLayer.presentation() {
                    self.displayLinkAction()
                } else {
                    self.progressUpdating?(validProgress, self.maskLayer.frame)
                }
            }
        }
        
        //更新maskLayer的frame
        var bounds = self.gradientLayer.bounds
        bounds.size.width *= CGFloat(validProgress)
        self.maskLayer.frame = bounds
        
        CATransaction.commit()
    }
}
