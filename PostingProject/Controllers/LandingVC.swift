//
//  LandingVC.swift
//  PostingProject
//
//  Created by LUCAS on 6/20/19.
//  Copyright © 2019 Atomiton. All rights reserved.
//

import UIKit
import SpringIndicator

class LandingVC: UIViewController, Presenter {
    
    @IBOutlet weak var indicator: SpringIndicator!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    
    var presenter = LandingPresenter()
    var isProcessing: Bool = false {
        didSet {
            if self.isProcessing {
                indicator.alpha = 1
                indicator.start()
            } else {
                indicator.stop(with: true) { idc in
                    idc.alpha = 0
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateUIs()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    
    @IBAction func onPressSignIn(_ sender: Any) {
        performSegue(withIdentifier: C.segueID.toSignInSegueID, sender: nil)
    }
    
    @IBAction func onPressSignUp(_ sender: Any) {
        performSegue(withIdentifier: C.segueID.toSignUpSegueID, sender: nil)
    }
}

extension LandingVC: BasicController {
    func setupViews() {
        loginButton.layer.borderColor = C.Color.BG.aquaBlue.cgColor
        loginButton.layer.borderWidth = 2.0
    }
    
    func updateUIs() {
        
    }
}
