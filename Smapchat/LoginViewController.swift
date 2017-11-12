//
//  LoginViewController.swift
//  Smapchat
//
//  Created by Dinesh  Gurnani on 11/11/17.
//  Copyright © 2017 Dinesh  Gurnani. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var loginSigninButton: UIButton!
    @IBOutlet weak var loginSigninToggle: UIButton!
    
    var signupMode = false;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func LoginSignin(_ sender: Any) {
        if let emailAddress = emailTF.text {
            if let password = passwordTF.text {
                if signupMode {
                    // signup case
                    Auth.auth().createUser(withEmail: emailAddress, password: password,
                        completion: {(user, error) in
                            if let error = error {
                                self.PresentAlert(alert: error.localizedDescription)
                            } else {
                                print("Signup was a success")
                                self.performSegue(withIdentifier: "towardsSnaps", sender: nil)
                            }
                    })
                } else {
                    // login case
                    Auth.auth().signIn(withEmail: emailAddress, password: password,
                        completion: {(user, error) in
                            if let error = error {
                                self.PresentAlert(alert: error.localizedDescription)
                            } else {
                                print("login was a success")
                                self.performSegue(withIdentifier: "towardsSnaps", sender: nil)
                            }
                        })
                }
            }
        }
    }
    
    @IBAction func ToggleLoginSignin(_ sender: Any) {
        if (signupMode) {
            // signup case
            loginSigninButton.setTitle("Login", for: .normal);
            loginSigninToggle.setTitle("or Tap to Signup", for: .normal);
        } else {
            // login case
            loginSigninButton.setTitle("Signup", for: .normal);
            loginSigninToggle.setTitle("or Tap to Login", for: .normal);
        }
        
        signupMode = !signupMode; // toggle
    }
    
    func PresentAlert(alert:String) {
        let alertController = UIAlertController(title: "Error", message: alert, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default) {(action) in
            alertController.dismiss(animated:true, completion: nil)
        }
        
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}

