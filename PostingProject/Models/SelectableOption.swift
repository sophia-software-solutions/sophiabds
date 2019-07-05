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
    
    init(_ string: String) {
        description = string
    }
}
