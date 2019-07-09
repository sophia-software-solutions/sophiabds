//
//  NewsItemCell.swift
//  PostingProject
//
//  Created by LUCAS on 7/9/19.
//  Copyright © 2019 Atomiton. All rights reserved.
//

import UIKit

class NewsItemCell: UITableViewCell {

    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var additionalLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func mapData() {
        
    }
}
