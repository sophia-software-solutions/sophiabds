//
//  UserProfile.swift
//  PostingProject
//
//  Created by LUCAS on 7/11/19.
//  Copyright © 2019 Atomiton. All rights reserved.
//

import Foundation

class UserProfile {

    //Current User
    var username: String = ""
    var userFullName: String = ""
    var userAccessToken: String = ""
    var userID: Int = -1
    
    init(_ token: String = "", _ name: String = "") {
        userAccessToken = token
        username = name
    }
    
    static func saveData(_ user: UserProfile) {
        UserDefaults.standard.set(user.username, forKey: C.Key.UserDefault.lastLoginUsername)
        UserDefaults.standard.set(user.userAccessToken, forKey: C.Key.UserDefault.accessToken)
    }
    
    static func parseData() -> (result: Bool, user: UserProfile?) {
        guard
            let lastUsername = UserDefaults.standard.string(forKey: C.Key.UserDefault.lastLoginUsername),
            let token = UserDefaults.standard.string(forKey: C.Key.UserDefault.accessToken)
        else {
            return (false, nil)
        }
        
        let user = UserProfile()
        user.username = lastUsername
        user.userAccessToken = token
        
        return (true, user)
    }
    
    static func removeData() {
        UserDefaults.standard.removeObject(forKey: C.Key.UserDefault.lastLoginUsername)
        UserDefaults.standard.removeObject(forKey: C.Key.UserDefault.accessToken)
    }
}
