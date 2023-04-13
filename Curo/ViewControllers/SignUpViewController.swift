//
//  SignUpViewController.swift
//  Curo
//
//  Created by John Ho on 2023-04-11.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth


class SignUpViewController: UIViewController {


    @IBOutlet weak var firstNameTf: UITextField!
    @IBOutlet weak var lastNameTf: UITextField!
    @IBOutlet weak var emailTf: UITextField!
    @IBOutlet weak var passwordTf: UITextField!
    
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var errorLb: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpElements()
    }
    

    @IBAction func signUpTapped(_ sender: Any) {
        //validate the fields
        let error = validateFields()
        
        if error != nil {
            //if error show message
            showError(message: error!)
        }
        else {
            //create cleaned versions of data
            let firstName = firstNameTf.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastNameTf.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTf.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTf.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            
            //create the user
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                //check for errors
                if err != nil {
                    //there was an error creating the user
                    self.showError(message: "Error creating user")
                }
                else {
                    //User was created successfully, now store first and last name to database
                    let db = Firestore.firestore()
                    
                    db.collection("users").addDocument(data: ["firstname": firstName, "lastname": lastName, "uid": result!.user.uid]) { (error) in
                        if error != nil {
                            //show error message
                            self.showError(message: "Error saving user data")
                        }
                    }
                    //transition to dashboard
                    self.transitionToLogin()
                }
            }
        }
    }
    
    func setUpElements(){
        //hide error label
        errorLb.alpha = 0
    }
    
    //validates fields - if correct return nil, else error msg
    func validateFields() -> String? {
        
        //check all fields filled
        if firstNameTf.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            lastNameTf.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailTf.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTf.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "Please fill in all fields"
        }
        
        return nil
    }
    
    func showError ( message: String) {
        errorLb.text = message
        errorLb.alpha = 1
    }
    
    func transitionToLogin(){
        performSegue(withIdentifier: "signUpToLogin", sender: self)
    }
    
}
