//
//  SignupVC.swift
//  PostingProject
//
//  Created by LUCAS on 6/20/19.
//  Copyright © 2019 Atomiton. All rights reserved.
//

import UIKit
import SpringIndicator
import AccountKit

class SignupVC: UIViewController, Presenter {
    
    @IBOutlet weak var indicator: SpringIndicator!
    @IBOutlet weak var firstNameTF: UITextField!
    @IBOutlet weak var lastNameTF: UITextField!
    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var confirmPassTF: UITextField!
    
    var accountKit: AccountKit?
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
    
    @IBAction func onPressSignupWithFB(_ sender: Any) {
        loginWithEmail()
    }
    
    func prepareFBLoginVC(_ loginViewController: AKFViewController) {
        loginViewController.delegate = self
        loginViewController.uiManager = SkinManager(skinType: .classic, primaryColor: C.Color.BG.orange)
    }
    
    func loginWithPhone(){
        let inputState = UUID().uuidString
        guard let controller = accountKit?.viewControllerForPhoneLogin(with: nil, state: inputState) else {
            return
        }
        
        controller.isSendToFacebookEnabled = true
        prepareFBLoginVC(controller)
        present(controller as UIViewController, animated: true, completion: nil)
    }
    
    func loginWithEmail() {
        let inputState = NSUUID().uuidString
        guard let controller = accountKit?.viewControllerForEmailLogin(with: nil, state: inputState) else {
            return
        }
        
        prepareFBLoginVC(controller)
        present(controller as UIViewController, animated: true, completion: nil)
    }
}

extension SignupVC: BasicController {
    func setupViews() {
        if accountKit == nil {
            accountKit = AccountKit(responseType: .accessToken)
        }
        
        accountKit?.requestAccount{ [weak self] (account, error) in
            guard let strongSelf = self else { return }
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func updateUIs() {
        if accountKit?.currentAccessToken != nil {
            // if the user is already logged in, go to the main screen
            // ...
        }
        else {
            // Show the login screen
        }
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

extension SignupVC: AKFViewControllerDelegate {
    func viewController(_ viewController: UIViewController & AKFViewController, didCompleteLoginWith code: String, state: String) {
        print("Did complete login with code \(code) state \(state)")
    }
    
    func viewController(_ viewController: UIViewController & AKFViewController, didCompleteLoginWith accessToken: AccessToken, state: String) {
        print("Did complete login with access token \(accessToken.tokenString) state \(state)")
    }
    
    func viewController(_ viewController: UIViewController & AKFViewController, didFailWithError error: Error) {
        print("Did fail with error \(error.localizedDescription)")
    }
    
    func viewControllerDidCancel(_ viewController: UIViewController & AKFViewController) {
        print("Did cancel the login")
    }
}
