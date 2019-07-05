//
//  ProtocolList.swift
//  AssetIntelligence
//
//  Created by LUCAS on 3/18/19.
//  Copyright © 2019 Atomiton. All rights reserved.
//

import Foundation
import UIKit

protocol Presenter: class {
    associatedtype Delegate
    var presenter : Delegate { get set }
}

protocol BasicController {
    func setupViews()
    func updateUIs()
}

protocol RefreshableController {
    func loadNewData()
    func loadMoreData()
}

protocol SetupTypeDetailDelegate: class {
    func didSelectSetupType(_ index: Int)
}
