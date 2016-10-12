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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Add symbol size
        ubiqArchView.symbolSize = 20
        // Width of inner static circle and broken animatable arch circle
        ubiqArchView.archlineWidth = 5
        // Progress circle line width
        ubiqArchView.progressLineWidth = 10
        // Sets Pending state
        ubiqArchView.setStateInProgress()
        
        ubiqArchView.progress = 0.6
                
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

