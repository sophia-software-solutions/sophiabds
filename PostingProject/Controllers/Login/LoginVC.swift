//
//  LoginVC.swift
//  PostingProject
//
//  Created by LUCAS on 7/15/19.
//  Copyright © 2019 Atomiton. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class LoginVC: UIViewController {
    
    var socialSignInService: SocialSignInInterface = SocialSignInService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func lognWithGoogle(_ sender: Any) {
        socialSignInService.signInWithGoogle(in: self) { (user, error) in
            if let error = error {
                print("login with google error: \(error.localizedDescription)")
            } else if let user = user {
                print("user email: \(String(describing: user.profile.email))")
            }
        }
    }
    
    @IBAction func loginWithFacebook(_ sender: Any) {
        socialSignInService.signInWithFacebook(in: self, readPermissions: ["public_profile", "email"]) { (result, error) in
            if let error = error {
                print("login with facebook error: \(error.localizedDescription)")
            }
            guard let result = result else {
                print("facebook response result is nil")
                return
            }
            if result.isCancelled {
                print("user is cancelled")
            }
            print("facebook token: \(String(describing: result.token?.tokenString))")
        }
    }
    
    @IBAction func loginWithAccountKit(_ sender: Any) {
        /*
         socialSignInService.signInWithAccountKit(in: self, verifyType: .phone("0986075044", contryCode: nil)) { (account, token, error) in
         if let error = error {
         print("error: \(error.localizedDescription)")
         }
         if let account = account {
         print("phone: \(account.phoneNumber?.phoneNumber ?? "nil"), contryCode: \(account.phoneNumber?.countryCode ?? "nil")")
         print("email: \(String(describing: account.emailAddress))")
         }
         }
         */
        
//        socialSignInService.signInWithAccountKit(in: self, verifyType: .email("ngohongthai.uet@gmail.com")) { (account, token, error) in
//            if let error = error {
//                print("error: \(error.localizedDescription)")
//            }
//            if let account = account {
//                print("phone: \(account.phoneNumber?.phoneNumber ?? "nil"), contryCode: \(account.phoneNumber?.countryCode ?? "nil")")
//                print("email: \(String(describing: account.emailAddress))")
//            }
//        }
    }
    
}
