//
//  LoginViewController.swift
//  Curo
//
//  Created by John Ho on 2023-04-11.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTf: UITextField!
    @IBOutlet weak var passwordTf: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var errorLb: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpElements()
    }

    func setUpElements(){
        //hide error label
        errorLb.alpha = 0
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        //validate textfields
        
        //create cleaned versions of the text fields
        let email = emailTf.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTf.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        //signing in the user
        Auth.auth().signIn(withEmail: email, password: password) { result, err in
            if err != nil {
                //couldn't sign in
                self.errorLb.text = err!.localizedDescription
                self.errorLb.alpha = 1
            }
            else{
                //user signed in successfully
                self.transitionToDash()
            }
        }
    }
    
    func validateFields() -> String? {
        //check all fields filled
        if emailTf.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTf.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "Please fill in all fields"
        }
        return nil
    }
    
    func showError ( message: String) {
        errorLb.text = message
        errorLb.alpha = 1
    }
    
    func transitionToDash(){
        performSegue(withIdentifier: "loginToDash", sender: self)
    }
}
