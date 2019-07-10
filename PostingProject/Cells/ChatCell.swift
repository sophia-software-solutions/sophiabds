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
    
    @IBOutlet weak var leftMessageView: UIView!
    @IBOutlet weak var leftMessageLabel: UILabel!
    @IBOutlet weak var rightMessageView: UIView!
    @IBOutlet weak var rightMessageLabel: UILabel!
    @IBOutlet weak var datetimeLabel: UILabel!
    @IBOutlet weak var leftView: UIView!
    @IBOutlet weak var rightView: UIView!    
    
    @IBOutlet weak var trailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func mapData(_ message: Message) {
        leftView.isHidden = !message.isMe
        rightView.isHidden = message.isMe
        avatarImageView.isHidden = message.isMe
        datetimeLabel.textAlignment = message.isMe ? .right : .left
        
        leftMessageView.isHidden = message.isMe
        rightMessageView.isHidden = !message.isMe
        
        if let image = message.image {
            avatarImageView.image = image
        }
        
        if let stamp = message.datetime?.toString(DateToStringStyles.dateTime(.medium)) {
            datetimeLabel.text = stamp
        }
        
        leftMessageLabel.text = message.description
        rightMessageLabel.text = message.description
    }
}
