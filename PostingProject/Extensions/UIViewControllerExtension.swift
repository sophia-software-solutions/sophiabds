//
//  UIViewControllerExtension.swift
//  AssetIntelligence
//
//  Created by LUCAS on 3/18/19.
//  Copyright © 2019 Atomiton. All rights reserved.
//

import UIKit
import NotificationCenter

extension UIViewController {
    @IBAction func back() {
        view.endEditing(true)
        let _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func close() {
        self.view.endEditing(true)
        self.dismiss(animated: true, completion: nil)
    }
    
    func listeningToKeyboard(_ handler: Selector) {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: handler, name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: handler, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    func stopListeningToKeyboard() {
        NotificationCenter.default.removeObserver(self)
    }
    
    func addBarItems(_ backAvailable: Bool = true, _ selector: Selector? = nil, _ image: UIImage? = nil) {
        if backAvailable {
            let leftButton = UIBarButtonItem(image: UIImage(named: "icons8-left_4"), style: .plain, target: self, action: #selector(back))
            navigationItem.leftBarButtonItem = leftButton
        }
        
        if let selector = selector {
            let rightButton = UIBarButtonItem(image: image ?? UIImage(named: "icons8-plus"), style: .plain, target: self, action: selector)
            navigationItem.rightBarButtonItem = rightButton
        }
    }
    
    func notify(_ message: String, _ title: String = "Notify", didSelectOK: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (alert) in
            if let action = didSelectOK {
                action()
            }
        }))
        alert.view.tintColor = C.Color.BG.darkJungleGreen
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func performDisplayHome() {
        let storyboard = UIStoryboard(name: C.StoryboardID.storyboardName, bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: C.StoryboardID.tabbar)
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        appdelegate.window?.rootViewController = controller
    }
    
    func performDisplayLanding() {
        UserProfile.removeData()
        
        let storyboard = UIStoryboard(name: C.StoryboardID.storyboardName, bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: C.StoryboardID.landing)
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        appdelegate.window?.rootViewController = controller
    }
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}

class CheckBox: UIButton {
    // Images
    let checkedImage = UIImage(named: "icons8-checked_checkbox")! as UIImage
    let uncheckedImage = UIImage(named: "icons8-unchecked_checkbox")! as UIImage
    
    // Bool property
    var isChecked: Bool = false {
        didSet{
            if isChecked == true {
                self.setImage(checkedImage, for: UIControl.State.normal)
            } else {
                self.setImage(uncheckedImage, for: UIControl.State.normal)
            }
        }
    }
    
    override func awakeFromNib() {
        self.addTarget(self, action:#selector(buttonClicked(sender:)), for: UIControl.Event.touchUpInside)
        self.isChecked = false
    }
    
    @objc func buttonClicked(sender: UIButton) {
        if sender == self {
            isChecked = !isChecked
        }
    }
}
