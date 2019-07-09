//
//  HomeVC.swift
//  PostingProject
//
//  Created by LUCAS on 6/20/19.
//  Copyright © 2019 Atomiton. All rights reserved.
//

import UIKit
import SpringIndicator

class HomeVC: UIViewController, Presenter {
    
    @IBOutlet weak var indicator: SpringIndicator!
    
    @IBOutlet weak var projectCollectionView: UICollectionView!
    @IBOutlet weak var tradingCollectionView: UICollectionView!
    @IBOutlet weak var rentingCollectionView: UICollectionView!
    @IBOutlet weak var newsTableView: UITableView!
    @IBOutlet weak var seeAllNewsButton: UIButton!
    
    var presenter = SignInPresenter()
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
    
    @IBAction func onPressLogOut(_ sender: Any) {
        _ = navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func onPressSeeAll(_ sender: Any) {
        
    }
}

extension HomeVC: BasicController {
    func setupViews() {
        setupCollectionView()
        seeAllNewsButton.layer.borderColor = C.Color.BG.orange.cgColor
        seeAllNewsButton.layer.borderWidth = 1.0
    }
    
    func updateUIs() {
//        reloadAllData()
    }

    private func reloadAllData() {
        projectCollectionView.reloadData()
        tradingCollectionView.reloadData()
        rentingCollectionView.reloadData()
        newsTableView.reloadData()
    }
    
    private func setupCollectionView() {
        projectCollectionView.register(UINib(nibName: C.CellNib.homeCell, bundle: nil), forCellWithReuseIdentifier: C.CellNib.homeCell)
        tradingCollectionView.register(UINib(nibName: C.CellNib.homeCell, bundle: nil), forCellWithReuseIdentifier: C.CellNib.homeCell)
        rentingCollectionView.register(UINib(nibName: C.CellNib.homeCell, bundle: nil), forCellWithReuseIdentifier: C.CellNib.homeCell)
        
        newsTableView.register(UINib(nibName: C.CellNib.newsItemCell, bundle: nil), forCellReuseIdentifier: C.CellNib.newsItemCell)
        newsTableView.rowHeight =  100.0
        newsTableView.tableFooterView = UIView()
    }
}

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: C.CellNib.newsItemCell, for: indexPath) as! NewsItemCell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell = cell as! NewsItemCell
        cell.mapData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}

extension HomeVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case projectCollectionView:
            return CGSize(width: 180.0, height: 180.0)
        default:
            return CGSize(width: 160.0, height: 180.0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: C.CellNib.homeCell, for: indexPath) as! HomeItemCell
        cell.mapData()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
    }
}
