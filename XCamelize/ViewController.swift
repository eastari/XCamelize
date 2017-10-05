//
//  ViewController.swift
//  XCamelize
//
//  Created by Starikov Yevgen on 25/07/2017.
//  Copyright © 2017 Starikov Yevgen. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var gifImg: NSImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let camelizeGif = NSImage(named: "camelizeVideo")
        gifImg.image = camelizeGif
        gifImg.animates = true
        gifImg.canDrawSubviewsIntoLayer = true
        
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

