//
//  LoggedInViewController.swift
//  Google Sign-In
//
//  Created by Tushar Khandaker on 17/7/23.
//

import UIKit
import GoogleSignIn

class LoggedInViewController: UIViewController {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    // variable
    var emailAddress = ""
    var fullName = ""
    var profilePicUrl: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
    }
    
    func configure() {
        nameLabel.text = fullName
        emailLabel.text = emailAddress
        guard let url = profilePicUrl else { return }
        let data = try? Data(contentsOf: url)

        if let imageData = data {
            let image = UIImage(data: imageData)
            profileImageView.image = image
        }
    }
    
    @IBAction func didTappedOnSignOut(_ sender: UIButton) {
        GIDSignIn.sharedInstance.signOut()
        self.navigationController?.popViewController(animated: true)
        
    }
    
    

}
