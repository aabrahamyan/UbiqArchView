//
//  ViewController.swift
//  UbiqArchView
//
//  Created by Armen on 10/12/16.
//  Copyright © 2016 Piqe Studio. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // UbiqArchView added as nib in storyboard
    @IBOutlet weak var ubiqArchView: UbiqArchView!
    
    var timer: Timer?
    var startTimeInterval: TimeInterval = 0.0
    var inProgress: Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Add symbol size
        ubiqArchView.symbolSize = 20
        // Width of inner static circle and broken animatable arch circle
        ubiqArchView.archlineWidth = 3
        // Progress circle line width
        ubiqArchView.progressLineWidth = 6
        // Set vertical distance from top and bottom of circle for pause symbols
        ubiqArchView.pauseSymbolTopMultiplicationFactor = 8
        // Set horizontal distance between pause symbols
        ubiqArchView.pauseSymbolsDistance = 5
        
        // Sets Pending state
        ubiqArchView.setStatePending()
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { (timer) in
            
            if !self.inProgress {
                if self.isTimeUp(timeInterval: self.startTimeInterval, compareeInterval: 1.5) {
                    self.ubiqArchView.setStateInProgress()
                } else {
                    self.startTimeInterval += timer.timeInterval
                }
            } else {
                if self.ubiqArchView.progress < 1 {
                    self.ubiqArchView.progress += timer.timeInterval
                } else {                    
                    self.ubiqArchView.progress = 1.0
                    self.inProgress = false
                    self.startTimeInterval = 0.0
                    self.ubiqArchView.setStatePending()
                    self.ubiqArchView.progress = 0.0
                }
            }
        })
        
        // You can add action on control
        ubiqArchView.addTarget(self, action: #selector(invalidateRecursiveTimer), for: .touchUpInside)
    }
    
    func invalidateRecursiveTimer() {
        self.timer?.invalidate()
        
        // This way you can change control to the invisible state, only if 'ubiqArchView' is in 'In Progress State'
        self.ubiqArchView.setStateNormal()
    }
    
    // MARK: Helpers
    private final func isTimeUp (timeInterval: TimeInterval, compareeInterval: TimeInterval) -> Bool {
        
        // after some time
        if timeInterval > compareeInterval {
            inProgress = true
            return true
        }
        
        return false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

