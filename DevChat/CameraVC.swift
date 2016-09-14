//
//  CameraVC.swift
//  DevChat
//
//  Created by brenda saavedra on 13/09/16.
//  Copyright © 2016 bsc. All rights reserved.
//

import UIKit

class CameraVC: AAPLCameraViewController {
    
    @IBOutlet weak var _previewView: AAPLPreviewView!
    
    override func viewDidLoad() {
        self.previewView = _previewView
        super.viewDidLoad()
    }

    @IBAction func recordBtnPressed(_ sender: UIButton) {
        self.toggleMovieRecording()
    }
    
    
    @IBAction func changeCameraBtnPressed(_ sender: UIButton) {
        self.changeCamera()
    }
}

