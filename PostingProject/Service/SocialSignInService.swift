//
//  SocialSignInService.swift
//  PostingProject
//
//  Created by LUCAS on 7/15/19.
//  Copyright © 2019 Atomiton. All rights reserved.
//

import Foundation
import UIKit
import GoogleSignIn
import FacebookCore
import FacebookLogin
import FBSDKLoginKit
import AccountKit

typealias GoogleSignInResponse = (_ user: GIDGoogleUser?, _ error: Error?) -> ()
typealias FacebookSignInResponse = (_ result: LoginManagerLoginResult?, _ error: Error?) -> ()
typealias AccountKitSignInResponse = (_ account: Account?, _ token: FBSDKCoreKit.AccessToken?,_ error: Error?) -> ()

enum AccountKitVerifyType {
    case email(_ email: String?)
    case phone(_ phone: String?, contryCode: String?)
}

protocol SocialSignInInterface {
    func signInWithGoogle(in viewController: UIViewController, completion: GoogleSignInResponse?)
    func signInWithFacebook(in viewController: UIViewController, readPermissions: [String], completion: FacebookSignInResponse?)
    func signInWithAccountKit(in viewController: UIViewController, verifyType: AccountKitVerifyType, completion: AccountKitSignInResponse?)
}

final class SocialSignInService: NSObject {
    
    private var presenter: UIViewController?
    private var googleSignInResponse: GoogleSignInResponse?
    private var accountKitSignInResponse: AccountKitSignInResponse?
    
    private lazy var facebookLoginManager: LoginManager = {
        return LoginManager()
    }()
    private lazy var accountKit: AccountKit = {
        let acc = AccountKit(responseType: .accessToken)
        return acc
    }()
    
    override init() {
        super.init()
        print("Init SocialLoginService")
        self.setupGoogleSignIn()
    }
    
    private func setupGoogleSignIn() {
        GIDSignIn.sharedInstance()?.signOut()
        GIDSignIn.sharedInstance()?.delegate = self
        GIDSignIn.sharedInstance()?.uiDelegate = self
    }
    private func prepareAccountKitView(loginViewController: AKFViewController) {
        loginViewController.delegate = self
        loginViewController.uiManager = SkinManager(skinType: .classic, primaryColor: .green)
    }
}

extension SocialSignInService: SocialSignInInterface {
    func signInWithGoogle(in viewController: UIViewController, completion: GoogleSignInResponse?) {
        self.presenter = viewController
        self.googleSignInResponse = completion
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    func signInWithFacebook(in viewController: UIViewController, readPermissions: [String], completion: FacebookSignInResponse?) {
        facebookLoginManager.logIn(permissions: readPermissions, from: viewController) { (result, error) in
            completion?(result, error)
        }
    }
    
    func signInWithAccountKit(in viewController: UIViewController, verifyType: AccountKitVerifyType, completion: AccountKitSignInResponse?) {
        self.accountKitSignInResponse = completion
        let inputState = UUID().uuidString
        switch verifyType {
        case .email(let initialEmail):
            let vc = accountKit.viewControllerForEmailLogin(with: initialEmail, state: inputState)
            self.prepareAccountKitView(loginViewController: vc)
            viewController.present(vc, animated: true, completion: nil)
        case .phone(let initialPhone, let contryCode):
            var phone: PhoneNumber?
            if let phoneString = initialPhone, !phoneString.isEmpty {
                phone = PhoneNumber(countryCode: contryCode ?? "", phoneNumber: phoneString)
            }
            let vc = accountKit.viewControllerForPhoneLogin(with: phone, state: inputState)
            self.prepareAccountKitView(loginViewController: vc)
            viewController.present(vc, animated: true, completion: nil)
        }
    }
}

extension SocialSignInService: GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn?, didSignInFor user: GIDGoogleUser?, withError error: Error?) {
        self.googleSignInResponse?(user, error)
    }
}

extension SocialSignInService: GIDSignInUIDelegate {
    func sign(_ signIn: GIDSignIn!, present viewController: UIViewController!) {
        self.presenter?.present(viewController, animated: true, completion: nil)
    }
    func sign(_ signIn: GIDSignIn!, dismiss viewController: UIViewController!) {
        self.presenter = nil
        viewController.dismiss(animated: true, completion: nil)
    }
}

extension SocialSignInService: AKFViewControllerDelegate {
    func viewController(_ viewController: (UIViewController & AKFViewController), didCompleteLoginWith code: String, state: String) {
        print("didCompleteLoginWithAuthorizationCode: \(String(describing: code)) - state: \(String(describing: state))")
    }
    
    func viewController(_ viewController: UIViewController & AKFViewController, didCompleteLoginWith accessToken: FBSDKCoreKit.AccessToken, state: String) {
        self.accountKit.requestAccount {[unowned self] (account, error) in
            self.accountKitSignInResponse?(account, accessToken, error)
        }
    }
    
    func viewController(_ viewController: (UIViewController & AKFViewController), didFailWithError error: Error) {
        self.accountKitSignInResponse?(nil, nil, error)
    }
}
