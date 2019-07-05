//
//  SignInVC.swift
//  PostingProject
//
//  Created by LUCAS on 6/20/19.
//  Copyright © 2019 Atomiton. All rights reserved.
//

import UIKit
import SpringIndicator

class SignInVC: UIViewController, Presenter {
    
    @IBOutlet weak var indicator: SpringIndicator!
    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    var presenter = SignInPresenter()
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
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateUIs()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    
    @IBAction func onPressDone(_ sender: Any) {
        view.endEditing(true)
        guard validating() else { return }
        performSegue(withIdentifier: C.segueID.toHomeSegueID, sender: nil)
    }
}

extension SignInVC: BasicController {
    func setupViews() {
    }
    
    func updateUIs() {
    }
    
    func validating() -> Bool {
        guard
            let username = usernameTF.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines),
            !username.isEmpty
        else {
            notify("Username can not be empty!")
            return false
        }
        
        guard
            let password = passwordTF.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines),
            !password.isEmpty
        else {
            notify("Password can not be empty!")
            return false
        }
        
        return true
    }
}

extension SignInVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case usernameTF:
            passwordTF.becomeFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        return true
    }
}
