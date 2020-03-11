//
//  LoginViewController.swift
//  TestChat
//
//  Created by Taufik Rohmat on 11/03/20.
//  Copyright © 2020 Taufik. All rights reserved.
//

import UIKit
import FirebaseAuth
import SVProgressHUD

class LoginViewController: UIViewController, UITextFieldDelegate{

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func didTapLogin(_ sender: Any) {
        
        let email = emailTextField.text?.trimmingCharacters(in: .whitespaces)
        if email == ""{
            SVProgressHUD.showError(withStatus: "Email cannot empty")
            return
        }
        
        let password = passwordTextField.text?.trimmingCharacters(in: .whitespaces)
        if password == ""{
            SVProgressHUD.showError(withStatus: "Password cannot empty")
            return
        }
        
        SVProgressHUD.show()
        Auth.auth().signIn(withEmail: email!, password: password!) { (result, error) in
            SVProgressHUD.dismiss()
            if error != nil{
                SVProgressHUD.showError(withStatus: error?.localizedDescription)
            }else{
                let chatVC = self.storyboard!.instantiateViewController(withIdentifier: "chatNavVC")
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.window?.rootViewController = chatVC
                appDelegate.window?.makeKeyAndVisible()
            }
            
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField{
            passwordTextField.becomeFirstResponder()
            return false
        }
        if textField == passwordTextField{
            self.didTapLogin(textField)
            textField.resignFirstResponder()
        }
        return true
    }
}
