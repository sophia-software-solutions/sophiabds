//
//  SignupVC.swift
//  PostingProject
//
//  Created by LUCAS on 6/20/19.
//  Copyright © 2019 Atomiton. All rights reserved.
//

import UIKit
import SpringIndicator

class SignupVC: UIViewController, Presenter {
    
    @IBOutlet weak var indicator: SpringIndicator!
    @IBOutlet weak var firstNameTF: UITextField!
    @IBOutlet weak var lastNameTF: UITextField!
    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var confirmPassTF: UITextField!
    
    var presenter = SignUpPresenter()
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
        
        notify("You account has been signed up successfully!", "Congratulation") { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.back()
        }
    }
}

extension SignupVC: BasicController {
    func setupViews() {
        
    }
    
    func updateUIs() {
        
    }
    
    func validating() -> Bool {
        guard
            let firstName = firstNameTF.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines),
            !firstName.isEmpty
        else {
            notify("First name can not be empty!")
            return false
        }
        
        guard
            let lastName = lastNameTF.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines),
            !lastName.isEmpty
        else {
            notify("Last name can not be empty!")
            return false
        }
        
        guard
            let username = usernameTF.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines),
            !username.isEmpty
        else {
            notify("Username can not be empty!")
            return false
        }
        
        guard
            let email = emailTF.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines),
            !email.isEmpty
        else {
            notify("Email can not be empty!")
            return false
        }
        
        guard
            let password = passwordTF.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines),
            !password.isEmpty
        else {
            notify("Password can not be empty!")
            return false
        }
        
        guard
            let confirmPass = confirmPassTF.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines),
            !confirmPass.isEmpty
        else {
            notify("Confirm password can not be empty!")
            return false
        }
        
        guard confirmPass == password else {
            notify("Passwords mismatch!")
            return false
        }
        
        return true
    }
}

extension SignupVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case firstNameTF:
            lastNameTF.becomeFirstResponder()
        case lastNameTF:
            usernameTF.becomeFirstResponder()
        case usernameTF:
            emailTF.becomeFirstResponder()
        case emailTF:
            passwordTF.becomeFirstResponder()
        case passwordTF:
            confirmPassTF.becomeFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        return true
    }
}
