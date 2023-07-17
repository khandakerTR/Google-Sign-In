//
//  ViewController.swift
//  Google Sign-In
//
//  Created by Tushar Khandaker on 17/7/23.
//

import UIKit
import GoogleSignIn

class ViewController: UIViewController {
    
    var emailAddress = ""
    var fullName = ""
    var profilePicUrl: URL?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupGoogleSignInButton()
    }
    
    func restorePreviousSignIn() {
        if GIDSignIn.sharedInstance.hasPreviousSignIn(){
            GIDSignIn.sharedInstance.restorePreviousSignIn()
            print("Already Login")
            self.performSegue(withIdentifier: "LoggedInNavViewController", sender: self)
        }
    }
    
    func setupGoogleSignInButton() {
        let button = GIDSignInButton()
        button.frame.size.width = 250
        button.frame.size.height = 80
        button.colorScheme = .dark
        button.style = .wide
        
        button.addTarget(self, action: #selector(googleSignIn), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        
        let centerXConstraint = NSLayoutConstraint(item: button, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let centerYConstraint = NSLayoutConstraint(item: button, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1.0, constant: 0.0)
            NSLayoutConstraint.activate([centerXConstraint, centerYConstraint])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "LoggedInNavViewController" {
            if let destinationVC = segue.destination as? LoggedInViewController {
                destinationVC.emailAddress = emailAddress
                destinationVC.fullName = fullName
                destinationVC.profilePicUrl = profilePicUrl
            }
        }
    }
    
    @objc func googleSignIn(sender: UIButton!) {
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { signInResult, error in
            
            guard error == nil else { return }
            guard let signInResult = signInResult else { return }
            
            let user = signInResult.user
            
            self.emailAddress = user.profile?.email ?? ""
            self.fullName = user.profile?.name ?? ""
            self.profilePicUrl = user.profile?.imageURL(withDimension: 320)
            
            self.performSegue(withIdentifier: "LoggedInNavViewController", sender: self)
        }
     }
    
}

