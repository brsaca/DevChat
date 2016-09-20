//
//  DataService.swift
//  DevChat
//
//  Created by brenda saavedra on 20/09/16.
//  Copyright © 2016 bsc. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseStorage

class DataService {
    private static let _instance = DataService()
    
    static var instance: DataService {
        return _instance
    }
    
    var mainRef:FIRDatabaseReference {
        return FIRDatabase.database().reference()
    }
    
    var usersRef:FIRDatabaseReference {
        return mainRef.child(Constants.FIR_CHILD_USERS)
    }
    
    var mainStorageRef: FIRStorageReference {
        return FIRStorage.storage().reference(forURL: Constants.FIR_URL_STORAGE)
    }
    
    var imagesStorageRef: FIRStorageReference {
        return mainStorageRef.child(Constants.FIR_STORAGE_IMAGES)
    }
    
    var videosStorageRef: FIRStorageReference {
        return mainStorageRef.child(Constants.FIR_STORAGE_VIDEOS)
    }
    
    func saveUser(uid: String){
        let profile: Dictionary<String, AnyObject> = [Constants.FIR_CHILD_USERS_PROFILE_FIRSTNAME: "" as AnyObject, Constants.FIR_CHILD_USERS_PROFILE_LASTNAME: "" as AnyObject]
        mainRef.child(Constants.FIR_CHILD_USERS).child(uid).child(Constants.FIR_CHILD_USERS_PROFILE).setValue(profile)
    }
    
    func getUsersFromDictionary(dict:Dictionary<String,AnyObject>)->[User]{
        var users = [User]()
        for (uid, value) in dict {
            if let dict1 = value as? Dictionary<String, AnyObject> {
                if let profile = dict1[Constants.FIR_CHILD_USERS_PROFILE] as? Dictionary<String, AnyObject>{
                    if let firstName = profile[Constants.FIR_CHILD_USERS_PROFILE_FIRSTNAME] as? String{
                        let user = User(uid: uid, firstName: firstName)
                        users.append(user)
                    }
                }
            }
        }
        return users
    }
    
}
