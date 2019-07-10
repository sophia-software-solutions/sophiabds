//
//  ChatCell.swift
//  PostingProject
//
//  Created by LUCAS on 7/10/19.
//  Copyright © 2019 Atomiton. All rights reserved.
//

import UIKit
import SwiftDate

class ChatCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var datetimeLabel: UILabel!
    @IBOutlet weak var leftView: UIView!
    @IBOutlet weak var rightView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func mapData(_ message: Message) {
        leftView.isHidden = !message.isMe
        rightView.isHidden = message.isMe
        avatarImageView.isHidden = message.isMe
        
        messageView.backgroundColor = message.isMe ? C.Color.BG.orange : C.Color.BG.textBG
        messageLabel.textColor = message.isMe ? C.Color.BG.snow : C.Color.BG.darkSlateGray
        
        messageLabel.textAlignment = message.isMe ? .right : .left
        datetimeLabel.textAlignment = message.isMe ? .right : .left
        
        if let image = message.image {
            avatarImageView.image = image
        }
        
        if let stamp = message.datetime?.toString(DateToStringStyles.dateTime(.medium)) {
            datetimeLabel.text = stamp
        }
        
        messageLabel.text = message.description
    }
}
