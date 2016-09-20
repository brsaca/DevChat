//
//  User.swift
//  DevChat
//
//  Created by brenda saavedra on 20/09/16.
//  Copyright © 2016 bsc. All rights reserved.
//

import UIKit

struct User {
    
    private var _firstName: String
    private var _uid: String
    
    var uid:String{
        return _uid
    }

    var firstName:String{
        return _firstName
    }
    
    init(uid:String, firstName:String){
        _uid = uid
        _firstName = firstName
    }
    
}
