//
//  CameraVC.swift
//  DevChat
//
//  Created by brenda saavedra on 13/09/16.
//  Copyright © 2016 bsc. All rights reserved.
//

import UIKit
import FirebaseAuth

let segueUsers = "segueUsers"

class CameraVC: AAPLCameraViewController, AAPLCameraVCDelegate {
    
    @IBOutlet weak var _previewView: AAPLPreviewView!
    @IBOutlet weak var recordBtn: UIButton!
    @IBOutlet weak var cameraBtn: UIButton!
    
    override func viewDidLoad() {
        delegate = self
        self.previewView = _previewView
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool){
        
        //performSegue(withIdentifier: "LoginVC", sender:nil)
        
        guard FIRAuth.auth()?.currentUser != nil else{
            performSegue(withIdentifier: "LoginVC", sender:nil)
            return
        }
    }

    //MARK: IBAction
    @IBAction func recordBtnPressed(_ sender: UIButton) {
        self.toggleMovieRecording()
    }
    
    
    @IBAction func changeCameraBtnPressed(_ sender: UIButton) {
        self.changeCamera()
    }
    
    //MARK: Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let usersVC = segue.destination as? UsersVC {
            if let videoDict = sender as? Dictionary<String,URL>{
                let url = videoDict["videoURL"]
                usersVC.videoURL = url
            }else if let imageDict = sender as? Dictionary<String,Data>{
                let snapData = imageDict["snapData"]
                usersVC.snapData = snapData
            }
        }
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
    
    func videoRecordingComplet(_ videoURL: URL!) {
        performSegue(withIdentifier: segueUsers, sender: ["videoURL":videoURL])
    }
    
    func videoRecordingFailed() {
        
    }
    
    func snapshotTaken(_ snapshotData: Data!) {
        performSegue(withIdentifier: segueUsers, sender: ["snapshotData":snapshotData])
    }
    
    func snapshotFailed() {
        
    }
}

