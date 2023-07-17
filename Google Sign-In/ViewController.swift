//
//  ViewController.swift
//  Google Sign-In
//
//  Created by Tushar Khandaker on 17/7/23.
//

import UIKit
import GoogleSignIn

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupGoogleSignInButton()
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

    @objc func googleSignIn(sender: UIButton!) {
        print("Button tapped")
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { signInResult, error in
            guard error == nil else { return }
            
            signInResult?.user.profile?.email
            
        }
     }
    
}

