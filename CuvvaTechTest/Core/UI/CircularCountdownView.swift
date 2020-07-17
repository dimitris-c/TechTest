//
//  Created by Dimitrios Chatzieleftheriou on 16/07/2020.
//  Copyright © 2020 Dimitrios Chatzieleftheriou. All rights reserved.
//

import Foundation
import UIKit

final class CircularCountdownView: UIView {

    private var progressView = UIView()
    private var backgroundLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.lineCap = CAShapeLayerLineCap.square
        layer.fillColor = UIColor.clear.cgColor
        return layer
    }()
    
    private var progressLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.lineCap = CAShapeLayerLineCap.square
        layer.fillColor = UIColor.clear.cgColor
        return layer
    }()

    var backgroundStrokeColor: UIColor = .lightGray {
        didSet {
            backgroundLayer.strokeColor = backgroundStrokeColor.cgColor
            self.setNeedsDisplay()
        }
    }
    
    var progressStrokeColor: UIColor = .white {
        didSet {
            progressLayer.strokeColor = progressStrokeColor.cgColor
            self.setNeedsDisplay()
        }
    }

    var progressLineWidth: CGFloat = 3 {
        didSet {
            progressLayer.lineWidth = progressLineWidth
            self.setNeedsDisplay()
        }
    }

    var finished: (() -> Void)?
    var onUpdate: ((CGFloat) -> Void)?

    var duration: TimeInterval = 0.0
    var totalTime: TimeInterval = 0.0
    
    var realDuration: TimeInterval {
        duration - Date().timeIntervalSinceNow // can be replaced by an NTP
    }
    
    private var displayLink: CADisplayLink?
    private var timer: Timer?
    private var secondsElapsed: TimeInterval = 0.0
    
    /// The progress of the countdown represented from `0.0` to `1.0`
    private var progress: CGFloat {
        return CGFloat(secondsElapsed / totalTime)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let lineWidthExpaded = progressLineWidth * 2
        let expandedWidth = self.bounds.width + lineWidthExpaded
        let expandedHeight = self.bounds.height + lineWidthExpaded
        let size = CGSize(width: expandedWidth, height: expandedHeight)
        self.progressView.frame.size = size
        self.progressView.center = CGPoint(x: self.bounds.midX, y: self.bounds.midY)
        
        let startAngle = -(CGFloat.pi / 2)
        let endAngle = (1.0 * CGFloat.pi * 2) - CGFloat.pi / 2
        
        let sizeCenter = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
        let radius = (self.progressView.frame.width - progressLineWidth) * 0.5
        
        let progressPath = UIBezierPath(arcCenter: sizeCenter,
                                        radius: radius,
                                        startAngle: startAngle,
                                        endAngle: endAngle,
                                        clockwise: true).reversing()
        self.progressLayer.frame.size = size
        self.progressLayer.path = progressPath.cgPath
        
        self.backgroundLayer.frame.size = size
        self.backgroundLayer.path = progressPath.cgPath
    }
    
    func start() {
        let offset = totalTime - realDuration
        secondsElapsed = offset
        
        if secondsElapsed > 0 {
            self.startInitialAnimation(completion: { [weak self] in
                self?.doStart()
            })
        } else {
            self.doStart()
        }
    }
    
    deinit {
        timer?.invalidate()
        timer = nil
    }

    func stop() {
        timer?.invalidate()
        timer = nil
    }
    
    func updateProgress() {
        let offset = totalTime - realDuration
        secondsElapsed = offset
        updateProgressLayer(progress: progress)
    }

    // MARK: Private methods

    private func setupUI() {

        self.addSubview(progressView)
        self.progressView.layoutIfNeeded()
        self.progressView.layer.addSublayer(backgroundLayer)
        self.progressView.layer.addSublayer(progressLayer)
        self.progressLayer.lineWidth = progressLineWidth
        self.progressLayer.strokeColor = progressStrokeColor.cgColor
        self.progressLayer.strokeStart = 0.0
        self.progressLayer.strokeEnd = 1.0
        self.backgroundLayer.lineWidth = progressLineWidth
        self.backgroundLayer.strokeColor = backgroundStrokeColor.cgColor

    }

    private func updateProgressLayer(progress: CGFloat) {
        progressLayer.strokeStart = progress
    }

    private func doStart() {
        timer?.invalidate()
        timer = Timer(timeInterval: 1, target: self, selector: #selector(tick), userInfo: nil, repeats: true)
        if let timer = timer {
            RunLoop.main.add(timer, forMode: .common)
        }
        updateProgress()
    }

    @objc private func tick() {
        secondsElapsed += 1
        self.updateProgressLayer(progress: progress)
        self.onUpdate?(progress)
        if progress >= 1.0 {
            self.stop()
            finished?()
        }
    }
    
    private func startInitialAnimation(completion: @escaping () -> Void) {
        self.progressLayer.strokeEnd = 1.0
        self.progressLayer.strokeStart = progress
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        CATransaction.setAnimationDuration(0.3)
        CATransaction.setAnimationTimingFunction(CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear))
        let pathAnimation = CABasicAnimation(keyPath: "strokeStart")
        pathAnimation.fromValue = 0.0
        self.progressLayer.add(pathAnimation, forKey: "strokeEndAnimation")
        CATransaction.commit()
        
    }
    
}
