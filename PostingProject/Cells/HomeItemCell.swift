//
//  HomeItemCell.swift
//  NeuronInterface
//
//  Created by LUCAS on 4/14/19.
//  Copyright © 2019 Atomiton. All rights reserved.
//

import UIKit

class HomeItemCell: UICollectionViewCell {

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
