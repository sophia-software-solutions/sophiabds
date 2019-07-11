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
        UserProfile.removeData()
        
        let storyboard = UIStoryboard(name: C.StoryboardID.storyboardName, bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: C.StoryboardID.landing)
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        appdelegate.window?.rootViewController = controller
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
