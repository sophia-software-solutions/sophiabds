//
//  ProfileVC.swift
//  PostingProject
//
//  Created by LUCAS on 7/9/19.
//  Copyright © 2019 Atomiton. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController, BasicController {

    @IBOutlet weak var logoutButton: UIButton!
    
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
        navigationController?.dismiss(animated: true, completion: nil)
    }
}

extension ProfileVC {
    func setupViews() {
        logoutButton.layer.borderColor = C.Color.BG.orange.cgColor
        logoutButton.layer.borderWidth = 1.0
    }
    
    func updateUIs() {
        
    }
}
