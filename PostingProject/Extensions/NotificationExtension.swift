//
//  NotificationExtension.swift
//  AssetIntelligence
//
//  Created by LUCAS on 4/18/19.
//  Copyright © 2019 Atomiton. All rights reserved.
//

import Foundation
import UIKit

extension Notification {
    var keyboardSize: CGSize? {
        guard let sizeValue = userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return nil }
        return sizeValue.cgRectValue.size
    }
    
    var keyboardAnimationDuration: Double? {
        return userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double
    }
}
