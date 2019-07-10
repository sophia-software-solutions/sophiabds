//
//  MessageVC.swift
//  PostingProject
//
//  Created by LUCAS on 7/9/19.
//  Copyright © 2019 Atomiton. All rights reserved.
//

import UIKit
import SpringIndicator
import GrowingTextView

class MessageVC: UIViewController, Presenter {
    
    @IBOutlet weak var indicator: SpringIndicator!
    @IBOutlet weak var chatTableView: UITableView!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var inputTextView: GrowingTextView!
    @IBOutlet weak var kbViewHeightConstraint: NSLayoutConstraint!
    
    var presenter = MessagePresenter()
    var isProcessing: Bool = false {
        didSet {
            if self.isProcessing {
                indicator.alpha = 1
                indicator.start()
            } else {
                indicator.stop(with: true) { idc in
                    idc.alpha = 0
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateUIs()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    @IBAction func onPressSend(_ sender: Any) {
        inputTextView.resignFirstResponder()
        
        guard
            let text = inputTextView.text,
            !text.isEmpty
        else { return }
        
        inputTextView.text = nil
        kbViewHeightConstraint.constant = 0
        view.layoutIfNeeded()
        
        let newMsg = Message(text, Date(), true, nil)
        let repMsg = Message(text, Date(), false, nil)
        presenter.messageList.append(contentsOf: [newMsg, repMsg])
        reloadAllData()
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height            
            kbViewHeightConstraint.constant = keyboardHeight > 50 ? keyboardHeight - 50 : 0
            view.layoutIfNeeded()
        }
    }
}

extension MessageVC: BasicController {
    func setupViews() {
        setupCollectionView()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func updateUIs() {
        //reloadAllData()
    }
    
    private func reloadAllData() {
        chatTableView.reloadData()
        chatTableView.layoutIfNeeded()
        
        if chatTableView.contentSize.height > chatTableView.frame.size.height {
            let lastIndexPath = IndexPath(row: presenter.messageList.count-1, section: 0)
            chatTableView.scrollToRow(at: lastIndexPath, at: .top, animated: true)
        }
    }
    
    private func setupCollectionView() {
        chatTableView.register(UINib(nibName: C.CellNib.chatCell, bundle: nil), forCellReuseIdentifier: C.CellNib.chatCell)
        chatTableView.rowHeight =  UITableView.automaticDimension
        chatTableView.estimatedRowHeight = 60.0
        chatTableView.tableFooterView = UIView()
    }
}

extension MessageVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.messageList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: C.CellNib.chatCell, for: indexPath) as! ChatCell
        cell.mapData(presenter.messageList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //
    }
}

extension MessageVC: GrowingTextViewDelegate {
    //
}
