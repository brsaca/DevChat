//
//  LoginVC.swift
//  DevChat
//
//  Created by brenda saavedra on 14/09/16.
//  Copyright © 2016 bsc. All rights reserved.
//

import UIKit

class LoginVC: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var emailTextfield: RoundTextField!
    @IBOutlet weak var passwordTextfield: RoundTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    //MARK: Keyboard
    func textFieldDidBeginEditing(_ textField: UITextField) {
        moveTextfield(textfield: textField, moveDistance: -100, up: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        moveTextfield(textfield: textField, moveDistance: -100, up: false)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    func moveTextfield(textfield:UITextField, moveDistance: Int, up: Bool){
        let moveDuration = 0.3
        let movement:CGFloat = CGFloat(up ? moveDistance : -moveDistance)
        
        UIView.beginAnimations("animateTextField",context:nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(moveDuration)
        self.view.frame = self.view.frame.offsetBy(dx:0,dy:movement)
        UIView.commitAnimations()
        
    }

    @IBAction func loginBtnPressed(_ sender: RoundedButton) {
        if let email = emailTextfield.text, let pass = passwordTextfield.text , (email.characters.count > 0 && pass.characters.count > 0){
            AuthService.instance.login(email: email, password: pass, onComplete: { (errMsg, data) in
                guard errMsg == nil else {
                    let alert = UIAlertController(title: "Error Authentication", message: errMsg, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    self.present(alert, animated:true, completion:nil)
                    return
                }
            })
        }else{
            let alert = UIAlertController(title: "Username and Password required", message: "You must enter both a username and a password", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }

}
