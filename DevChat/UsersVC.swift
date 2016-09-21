//
//  UsersVC.swift
//  DevChat
//
//  Created by brenda saavedra on 20/09/16.
//  Copyright © 2016 bsc. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage
import FirebaseAuth

class UsersVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView:UITableView!
    
    private var _videoURL:URL?
    private var _snapData:Data?
    
    private var users = [User]()
    private var selectedUsers = Dictionary<String, User>()
    
    var snapData:Data? {
        set {
            _snapData = newValue
        } get {
            return _snapData
        }
    }
    
    var videoURL:URL? {
        set{
            _videoURL = newValue
        }get{
            return _videoURL
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.allowsMultipleSelection = true
        
        navigationItem.rightBarButtonItem?.isEnabled = false
        
        DataService.instance.usersRef.observeSingleEvent(of: .value) { (snapshot:FIRDataSnapshot) in
           print("Snap: \(snapshot.debugDescription)")

            if let dict = snapshot.value as? Dictionary <String, AnyObject> {
                self.users = DataService.instance.getUsersFromDictionary(dict: dict)
                self.tableView.reloadData()
            }
        }
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! UserCell
        let user = users[indexPath.row]
        cell.updateUI(user: user)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        markCell(tableView, atIndexPath: indexPath, withStatus: true)
        navigationItem.rightBarButtonItem?.isEnabled = true
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        markCell(tableView, atIndexPath: indexPath, withStatus: false)
        navigationItem.rightBarButtonItem?.isEnabled = selectedUsers.count > 0 ? true : false
    }
    
    func markCell(_ tableView: UITableView, atIndexPath indexPath: IndexPath, withStatus status:Bool){
        let cell = tableView.cellForRow(at: indexPath) as! UserCell
        cell.setCheckmark(selected: status)
        
        let user = users[indexPath.row]
        if(status){
            selectedUsers[user.uid] = user
        }else{
            selectedUsers[user.uid] = nil
        }
    }
    
    //MARK: IBAction
    @IBAction func sendRequestButtonPressed(sender:AnyObject){
        if let url = _videoURL {
            let videoName = "\(NSUUID().uuidString)\(url)"
            let ref = DataService.instance.videosStorageRef.child(videoName)
            
            _ = ref.putFile(url, metadata: nil, completion: { (meta:FIRStorageMetadata?, err:Error?) in
                if err != nil {
                    print("Error uploading video: \(err?.localizedDescription)")
                }else{
                    let downloadURL = meta!.downloadURL()
                    DataService.instance.sendMediaPullRequest(senderUID: FIRAuth.auth()!.currentUser!.uid, sendingTo: self.selectedUsers, mediaURL:downloadURL!, textSnippet:"Coding its the best!!!")
                }
            })
            self.dismiss(animated: true, completion: nil)
        }else if let snap = _snapData {
            let snapName = "\(NSUUID().uuidString).jpg"
            let ref = DataService.instance.imagesStorageRef.child(snapName)
            
            _ = ref.put(snap, metadata: nil, completion: { (meta:FIRStorageMetadata?, err:Error?) in
                if err != nil {
                    print("Error uploading snap: \(err?.localizedDescription)")
                }else{
                    let downloadURL = meta!.downloadURL()
                     DataService.instance.sendMediaPullRequest(senderUID: FIRAuth.auth()!.currentUser!.uid, sendingTo: self.selectedUsers, mediaURL:downloadURL!, textSnippet:"Coding its the best!!!")
                }
            })
            
            self.dismiss(animated: true, completion: nil)
            
        }
    }


}
