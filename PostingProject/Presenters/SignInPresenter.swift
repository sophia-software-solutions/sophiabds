//
//  SignInPresenter.swift
//  PostingProject
//
//  Created by LUCAS on 6/20/19.
//  Copyright © 2019 Atomiton. All rights reserved.
//

class SignInPresenter {
    private var currentUser: UserProfile = UserProfile()
    
    func saveUserData(_ username: String, _ token: String) {
        currentUser.username = username
        currentUser.userAccessToken = token
    }
    
    func retrieveUserData() -> Bool {
        if let user = UserProfile.parseData().user {
            currentUser = user
            return true
        } else {
            return false
        }
    }
    
    func syncUserData() {
        UserProfile.saveData(currentUser)
    }
}
