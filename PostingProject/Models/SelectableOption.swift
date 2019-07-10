//
//  SelectableOption.swift
//  AssetIntelligence
//
//  Created by LUCAS on 4/17/19.
//  Copyright © 2019 Atomiton. All rights reserved.
//

import UIKit

class SelectableOption {
    var description: String = ""
    var image: UIImage?
    var isSelected: Bool = false
    var datetime: Date?
    
    init(_ string: String, _ time: Date? = nil) {
        description = string
        if let date = time {
            datetime = date
        }
    }
}

class Message {
    var isMe: Bool = false
    var description: String = ""
    var image: UIImage?
    var isSelected: Bool = false
    var datetime: Date?
    
    init(_ string: String, _ time: Date? = nil, _ isCurrentUser: Bool = false, _ avatar: UIImage? = nil) {
        description = string
        isMe = isCurrentUser
        image = avatar
        datetime = time
    }
}
