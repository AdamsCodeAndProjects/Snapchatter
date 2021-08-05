//
//  LoginViewController.swift
//  Snapchatter
//
//  Created by adam janusewski on 8/3/21.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var topButton: UIButton!
    @IBOutlet weak var bottomButton: UIButton!
    
    var signupMode = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    

    @IBAction func topTapped(_ sender: UIButton) {
        if let email = emailTextField.text {
            if let password = passwordTextField.text {
                if signupMode {
                    // Sign Up
                    FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password) { user, error in
                        if let error = error {
                            self.presentAlert(alert: error.localizedDescription)
                        } else {
                            print("Sign Up Successful! =) ")
                        }
                    }
                } else {
                    // Log In
                    FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password) { user, error in
                        if let error = error {
                            self.presentAlert(alert: error.localizedDescription)
                        } else {
                            print("Log in success!")
                        }
                    }
                }
            }
        }
    }
    func presentAlert(alert: String) {
        let alertVC = UIAlertController(title: "Error", message: alert, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { action in
            alertVC.dismiss(animated: true, completion: nil)
        }
        alertVC.addAction(okAction)
        present(alertVC, animated: true, completion: nil)
    }
    
    @IBAction func bottomTapped(_ sender: UIButton) {
        if signupMode {
            // Switch to Login
            signupMode = false
            topButton.setTitle("Log In", for: .normal)
            bottomButton.setTitle("Switch to Sign Up", for: .normal)
        } else {
            // Switch to Sign Up
            signupMode = true
            topButton.setTitle("Sign Up", for: .normal)
            bottomButton.setTitle("Switch to Log In", for: .normal)
        }
    }
}

