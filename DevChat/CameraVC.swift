//
//  CameraVC.swift
//  DevChat
//
//  Created by brenda saavedra on 13/09/16.
//  Copyright © 2016 bsc. All rights reserved.
//

import UIKit

class CameraVC: AAPLCameraViewController, AAPLCameraVCDelegate {
    
    @IBOutlet weak var _previewView: AAPLPreviewView!
    @IBOutlet weak var recordBtn: UIButton!
    @IBOutlet weak var cameraBtn: UIButton!
    
    override func viewDidLoad() {
        delegate = self
        self.previewView = _previewView
        super.viewDidLoad()
    }

    //MARK: IBAction
    @IBAction func recordBtnPressed(_ sender: UIButton) {
        self.toggleMovieRecording()
    }
    
    
    @IBAction func changeCameraBtnPressed(_ sender: UIButton) {
        self.changeCamera()
    }
    
    //MARK: AAPLCameraVCDelegate
    func shouldEnableCameraUI(_ enable: Bool) {
        cameraBtn.isEnabled = enable
    }
    
    func shouldEnableRecordUI(_ enable: Bool) {
        recordBtn.isEnabled = enable
    }
    
    func canStartRecording() {
        print("Recording has started")
    }
    
    func recordingHasStarted() {
        print("Can start recording")
    }
}

