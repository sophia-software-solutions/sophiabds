//
//  ProfileVC.swift
//  PostingProject
//
//  Created by LUCAS on 7/9/19.
//  Copyright © 2019 Atomiton. All rights reserved.
//

import UIKit
import SpringIndicator
import AccountKit

class ProfileVC: UIViewController, BasicController, Presenter {

    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var avatarView: UIView!
    @IBOutlet weak var usernameLabel: UILabel!
    
    var accountKit: AccountKit?
    var presenter = ProfilePresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateUIs()
    }
    
    @IBAction func onPressLogout(_ sender: Any) {
        if let _ = accountKit?.currentAccessToken {
            accountKit?.logOut{ [weak self] (success, error) in
                guard let strongSelf = self else { return }
                if success {
                    strongSelf.notify("Logout successfully!", "Success", didSelectOK: {
                        strongSelf.performDisplayLanding()
                    })
                } else if let error = error?.localizedDescription {
                    strongSelf.notify("Logout failed with error \(error).")
                } else {
                    strongSelf.notify("Logout failed with error. Please try again.")
                }
            }
        }
    }
}

extension ProfileVC {
    func setupViews() {
        logoutButton.layer.borderColor = C.Color.BG.orange.cgColor
        logoutButton.layer.borderWidth = 1.0
        avatarView.layer.borderColor = C.Color.BG.orange.cgColor
        avatarView.layer.borderWidth = 3.0
        
        if accountKit == nil {
            accountKit = AccountKit(responseType: .accessToken)
        }
    }
    
    func updateUIs() {
        guard presenter.retrieveUserData() else { return }
        
        usernameLabel.text = presenter.user.username
    }
}
