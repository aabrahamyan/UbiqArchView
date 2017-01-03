//
//  UbiqArchView.swift
//  Depositphotos
//
//  Created by Armen on 10/6/16.
//  Copyright © 2016 Depositphotos Inc. All rights reserved.
//

import Foundation
import UIKit

@objc enum UbiqState : Int {
    case normal
    case inProgress
    case inProgressPaused
    case pending
}

@objc class UbiqArchView: UIControl {
    
    @objc var ubiqState: UbiqState = .normal
    
    @objc var brokenCircle: CAShapeLayer?
    @objc var progressCircle: CAShapeLayer?
    @objc var staticCircle: CAShapeLayer?
    @objc var symbolLayer: CAShapeLayer?
    
    @objc var pauseLeftSymbol: CAShapeLayer?
    @objc var pauseRightSymbol: CAShapeLayer?
    
    
    // In Class Constants defined as struct
    struct InternalConstants {
        struct BrokenArchViewConstants {
            static let rotationAnimationKey = "brokenArchRotationKey"
        }
    }
    
   // Nonautolayout constructor
   override init(frame: CGRect) {
        self.progress = 0
        super.init(frame: frame)
        backgroundColor = UIColor.clear
    
        setupArch()
    }
    
    // From nib loaded constructor
    required init?(coder aDecoder: NSCoder) {
        self.progress = 0
        super.init(coder: aDecoder)
        
        setupArch()
    }
    
    /**
     * Draws all layers and sets up initial arch view state
     */
    private final func setupArch() {
        
        // Broken Arch
        createBrokenLayer()
        drawPartialArch()
        
        // Symbol
        createStopSymbol()
        drawSymbol()
        
        // Payse Symbols
        createPauseSymbol()
        drawPauseSymbol()
        
        // Progress
        createProgressLayer()
        drawStaticCircle()
        
        // Set Default Color
        tintColor = UIColor(red: 24 / 256, green: 181 / 256, blue: 239 / 256, alpha: 1)
        
        setStateNormal()

    }
        
    
    @objc var archlineWidth: CGFloat = 2 {
        didSet {
            brokenCircle?.lineWidth = archlineWidth
            staticCircle?.lineWidth = archlineWidth
        }
    }
    @objc var progressLineWidth: CGFloat = 4 {
        didSet {
            progressCircle?.lineWidth = progressLineWidth
        }
    }
    @objc var symbolSize: CGFloat = 10 {
        didSet {
            symbolLayer?.path = nil
            drawSymbol()
        }
    }
    
    @objc var pauseSymbolThickness: CGFloat = 4 {
        didSet {
            pauseRightSymbol?.path = nil
            pauseLeftSymbol?.path = nil
            drawPauseSymbol()
        }
    }
    
    @objc var pauseSymbolTopMultiplicationFactor: CGFloat = 4 {
        didSet {
            pauseRightSymbol?.path = nil
            pauseLeftSymbol?.path = nil
            drawPauseSymbol()
        }
    }
    
    @objc var pauseSymbolsDistance: CGFloat = 0 {
        didSet {
            pauseRightSymbol?.path = nil
            pauseLeftSymbol?.path = nil
            drawPauseSymbol()
        }
    }
    
    @objc var progress: Double {
        didSet {
            self.setNeedsDisplay()
        }
    }
    @objc var rotationDuration: CFTimeInterval = 1.0
    /**
    * Overwritten tintColor, affects also circle layers stroke and fill colors
    */
    override var tintColor: UIColor! {
        
        didSet {
            brokenCircle?.strokeColor = tintColor.cgColor
            brokenCircle?.fillColor = UIColor.clear.cgColor
            
            symbolLayer?.strokeColor = tintColor.cgColor
            symbolLayer?.fillColor = tintColor.cgColor
            
            staticCircle?.strokeColor = tintColor.cgColor
            staticCircle?.fillColor = UIColor.clear.cgColor
            
            progressCircle?.strokeColor = tintColor.cgColor
            progressCircle?.fillColor = UIColor.clear.cgColor
            
            progressCircle?.strokeColor = tintColor.cgColor
            progressCircle?.fillColor = UIColor.clear.cgColor
            
            pauseLeftSymbol?.strokeColor = UIColor.clear.cgColor
            pauseLeftSymbol?.fillColor = tintColor.cgColor
            pauseRightSymbol?.strokeColor = UIColor.clear.cgColor
            pauseRightSymbol?.fillColor = tintColor.cgColor
            
        }
    }
    
    
    // MARK: Set State
    /**
     * Sets UbiqArchView state normal
     */
    @objc final func setStateNormal() {
        // Normal state
        isUserInteractionEnabled = false
        removePartialArchAnimation()
        brokenCircle?.isHidden = true
        progressCircle?.isHidden = true
        staticCircle?.isHidden = true
        symbolLayer?.isHidden = true
        pauseRightSymbol?.isHidden = true
        pauseLeftSymbol?.isHidden = true
        
        ubiqState = .normal
    }
   
    /**
     * Sets UbiqArchView state pending (broken circle animation is rotating)
     */
    @objc final func setStatePending() {
        // Begin Spinning
        isUserInteractionEnabled = true
        animatePartialArch()
        brokenCircle?.isHidden = false
        progressCircle?.isHidden = true
        staticCircle?.isHidden = true
        symbolLayer?.isHidden = true
        pauseRightSymbol?.isHidden = true
        pauseLeftSymbol?.isHidden = true
        
        ubiqState = .pending
    }
    
    /**
     * Sets UbiqArchView state In Progress (redraws layer every time multiplied by a new 'Progress' value)
     */
    @objc final func setStateInProgress() {
        // State In Progress
        removePartialArchAnimation()
        isUserInteractionEnabled = true
        brokenCircle?.isHidden = true
        progressCircle?.isHidden = false
        staticCircle?.isHidden = false
        symbolLayer?.isHidden = false
        pauseRightSymbol?.isHidden = true
        pauseLeftSymbol?.isHidden = true
        
        ubiqState = .inProgress
    }
    
    @objc
    final func setStateInProgressWithPaused() {
        // State In Progress
        removePartialArchAnimation()
        isUserInteractionEnabled = true
        brokenCircle?.isHidden = true
        progressCircle?.isHidden = false
        staticCircle?.isHidden = false
        symbolLayer?.isHidden = true
        pauseRightSymbol?.isHidden = false
        pauseLeftSymbol?.isHidden = false
        
        ubiqState = .inProgressPaused
    }
    
    // MARK: Layers creation
    /**
     * Creates broken layer for 'Pending' view representation
     */
    private final func createBrokenLayer() {
        
        brokenCircle = CAShapeLayer()
        brokenCircle?.contentsScale = UIScreen.main.scale
        brokenCircle?.lineCap = kCALineCapRound;
        brokenCircle?.lineWidth = archlineWidth
        brokenCircle?.frame = bounds
        layer.addSublayer(brokenCircle!)
    }
    
    /**
     * Creates layer for 'Progress' view representation
     */
    private final func createProgressLayer() {
        
        staticCircle = CAShapeLayer()
        staticCircle?.contentsScale = UIScreen.main.scale
        staticCircle?.lineCap = kCALineCapRound;
        staticCircle?.lineWidth = archlineWidth
        staticCircle?.frame = bounds
        layer.addSublayer(staticCircle!)
        
        progressCircle = CAShapeLayer()
        progressCircle?.contentsScale = UIScreen.main.scale
        progressCircle?.lineCap = kCALineCapSquare
        progressCircle?.lineWidth = progressLineWidth
        progressCircle?.frame = bounds
        layer.addSublayer(progressCircle!)
    }
    
    /**
    * Creates 'Stop' symbol in arch view
    */
    private final func createStopSymbol() {
        symbolLayer = CAShapeLayer()
        symbolLayer?.contentsScale = UIScreen.main.scale
        layer.addSublayer(symbolLayer!)
    }
    
    /**
     * Creates 'Pause' symbols in arch view
     */
    private final func createPauseSymbol() {
        pauseLeftSymbol = CAShapeLayer()
        pauseLeftSymbol?.contentsScale = UIScreen.main.scale
        layer.addSublayer(pauseLeftSymbol!)
        
        pauseRightSymbol = CAShapeLayer()
        pauseRightSymbol?.contentsScale = UIScreen.main.scale
        layer.addSublayer(pauseRightSymbol!)
    }
    
    // MARK: Core graphics Related
    /**
    * Draws broken arch for 'Pending' view representation
    */
    private final func drawPartialArch() {
        let startAngle = CGFloat(M_PI_2) + 0.5
        let endAngle = CGFloat(1.5 * M_PI) + startAngle + 0.5
        let center = CGPoint(x: bounds.size.width / 2, y: bounds.size.height / 2)
        let radius = (bounds.size.width - archlineWidth) / 2
        
        let bezier = UIBezierPath()
        bezier.lineWidth = archlineWidth
        bezier.lineCapStyle = .round
        
        bezier.addArc(withCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        brokenCircle!.path = bezier.cgPath
    }
    
    /**
     * Draws static circle
     */
    private final func drawStaticCircle() {
        // Circle View
        let startStaticAngle = CGFloat(M_PI_2)
        let endStaticAngle = CGFloat(2 * M_PI) + startStaticAngle
        let centerStatic = CGPoint(x: bounds.size.width / 2, y: bounds.size.height / 2)
        let radiusStatic = (bounds.size.width - archlineWidth) / 2
        
        let bezierStatic = UIBezierPath()
        bezierStatic.lineWidth = archlineWidth
        bezierStatic.lineCapStyle = .round
        
        bezierStatic.addArc(withCenter: centerStatic, radius: radiusStatic, startAngle: startStaticAngle, endAngle: endStaticAngle, clockwise: true)
        
        staticCircle!.path = bezierStatic.cgPath
    }
    
    /**
     * Draws 'Stop' symbol view
     */
    private final func drawSymbol() {
        let rect = bounds.insetBy(dx: (bounds.width - symbolSize)/2, dy: (bounds.height - symbolSize) / 2)
        let bezier = UIBezierPath(rect: rect)
        symbolLayer?.path = bezier.cgPath
        symbolLayer?.lineWidth = 0
    }
    
    /**
     * Draws 'Pause' symbols view
     */
    private final func drawPauseSymbol() {
        
        let topPosition = pauseSymbolTopMultiplicationFactor / 2
        
        let leftRect = CGRect(x: bounds.midX - 2*pauseSymbolThickness - pauseSymbolsDistance, y: topPosition*pauseSymbolThickness, width: pauseSymbolThickness, height: bounds.height - pauseSymbolTopMultiplicationFactor*pauseSymbolThickness)
        let leftBezier = UIBezierPath(rect: leftRect)
        pauseLeftSymbol?.path = leftBezier.cgPath
        pauseLeftSymbol?.lineWidth = 0
        
        let rightRect = CGRect(x: bounds.midX + pauseSymbolThickness + pauseSymbolsDistance, y: topPosition*pauseSymbolThickness, width: pauseSymbolThickness, height: bounds.height - pauseSymbolTopMultiplicationFactor*pauseSymbolThickness)
        let rightBezier = UIBezierPath(rect: rightRect)
        pauseRightSymbol?.path = rightBezier.cgPath
        pauseRightSymbol?.lineWidth = 0
    }
    
    /**
     * Animates broken arch for 'Pending' state
     */
    private final func animatePartialArch() {
        
        guard brokenCircle?.animation(forKey: InternalConstants.BrokenArchViewConstants.rotationAnimationKey) == nil else { return }
        
        let rotation = CABasicAnimation(keyPath: "transform.rotation")
        let fromRotation = brokenCircle!.value(forKeyPath: "transform.rotation")
        rotation.fromValue = fromRotation as! Float
        rotation.toValue = ((fromRotation as! Float) + Float(2 * M_PI))
        rotation.duration = rotationDuration        
        rotation.repeatCount = HUGE
        rotation.isRemovedOnCompletion = false
        brokenCircle?.add(rotation, forKey: InternalConstants.BrokenArchViewConstants.rotationAnimationKey)
        
    }
    
    /**
     * Removes arch animation
     */
    private final func removePartialArchAnimation() {
        brokenCircle?.removeAnimation(forKey: InternalConstants.BrokenArchViewConstants.rotationAnimationKey)
    }
    
    // MARK: Redraws on bounds changes
    override func layoutSubviews() {
        super.layoutSubviews()
        
        brokenCircle?.frame = bounds
        staticCircle?.frame = bounds
        progressCircle?.frame = bounds        
        
        reDrawStaticCircle()
        reDrawSymbol()
        reDrawPauseSymbol()
        reDrawPartialArch()
        
        progressCircle?.path = nil
        self.setNeedsDisplay()
    }
    
    /**
     * Redraws broken arch
     */
    private final func reDrawPartialArch() {
        brokenCircle?.path = nil
        drawPartialArch()
    }
    
    /**
     * Redraws inner static circle
     */
    private final func reDrawStaticCircle() {
        staticCircle?.path = nil
        drawStaticCircle()
    }
    
    /**
     * Redraws 'Stop' symbol
     */
    private final func reDrawSymbol() {
        symbolLayer?.path = nil
        drawSymbol()
    }
    
    /**
     * Redraws 'Pause' symbols
     */
    private final func reDrawPauseSymbol() {
        pauseLeftSymbol?.path = nil
        pauseRightSymbol?.path = nil
        drawPauseSymbol()
    }
    
    
    // Drawin circle progress here
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        // Progress Arch
        let startAngle = -CGFloat(M_PI_2)
        let endAngle = CGFloat(progress * 2 * M_PI) + startAngle
        let center = CGPoint(x: bounds.size.width / 2, y: bounds.size.height / 2)
        let radius = (bounds.size.width - (progressLineWidth + archlineWidth)) / 2
        
        let bezier = UIBezierPath()
        bezier.lineWidth = progressLineWidth
        bezier.lineCapStyle = .round
        
        
        bezier.addArc(withCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        progressCircle!.path = bezier.cgPath
    }
}
