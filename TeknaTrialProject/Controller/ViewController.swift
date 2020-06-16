//
//  ViewController.swift
//  TeknaTrialProject
//
//  Created by Burak Yılmaz on 16.06.2020.
//  Copyright © 2020 Burak Yılmaz. All rights reserved.
//

import UIKit
import SnapKit
import AVKit

class ViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource ,AddContactDelegate, ViewLayoutDelegate{
    func addContact(changedColor: UIColor, cellHeight: CGFloat) {
        newChangedColor = changedColor
        newCellHeight = cellHeight
    }
    
    var detailsViewController = DetailsViewController()
    var cell = CollectionViewCell()
    var newCellHeight : CGFloat?
    var newChangedColor : UIColor?
    var cellColors = Dictionary<CGFloat, UIColor>()
    var cellName = Dictionary<CGFloat, String>()
    let randomInt = Int.random(in: 120...130)
    
    // Random height value for cells
    func randomHeight() -> Int{
        let randomCGFloat = Int.random(in: 5...10)
        let newInt = randomCGFloat * 20
        return newInt
    }
    
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        return CGFloat(randomHeight())
    }
    
    
    let container = UIView()
    func setContainer(){
        view.addSubview(container)
        container.snp.makeConstraints { (make) in
            make.top.equalTo(view)
            make.leading.equalTo(view)
            make.trailing.equalTo(view)
            make.height.equalTo(view)
        }
    }
    
    
    fileprivate let collectionView : UICollectionView = {
        let layout = ViewLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        return collectionView
    }()
    func setCollectionView(){
        container.addSubview(collectionView)
        collectionView.clipsToBounds = true
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom:10, right: 10)
        collectionView.snp.makeConstraints { (make) -> Void in
            collectionView.layer.cornerRadius = 10.0
            make.top.equalTo(container)
            make.leading.equalTo(container).offset(0)
            make.trailing.equalTo(container.snp.trailing).offset(0)
            make.bottom.equalTo(container).offset(0)
        }
    }
    func setupDelegate(){
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    let refreshButton = ColorChangeButton()
    func setrefreshButton(){
        container.addSubview(refreshButton)
        refreshButton.snp.makeConstraints { (make) in
            make.leading.equalTo(container.snp.leading).offset(10)
            make.trailing.equalTo(container.snp.trailing).offset(-10)
            make.bottom.equalTo(container.snp.bottom).offset(-10)
            make.height.equalTo(75)
        }
        refreshButton.addTarget(self, action: #selector( refreshButtonAction), for: .touchUpInside)
    }
    
    @objc func refreshButtonAction(sender: UIButton!) {
        cellColors.removeAll()
        // For different sized cells to arrive
        if let layout = self.collectionView.collectionViewLayout as? ViewLayout {
            layout.reloadData()
        }
        collectionView.reloadData()
        func getColor(height: CGFloat) -> UIColor {
            if let color = cellColors[height] {
                return color
            }
            let randomColor =  random()// generate a random color
            cellColors[height] = randomColor
            return randomColor
        }
    }
    
    
    
    // ---------------------Random structures----------------------------
    func random() -> UIColor {
        return UIColor(red: .random(in: 0...1),
                       green: .random(in: 0...1),
                       blue: .random(in: 0...1),
                       alpha: 1.0)
    }
    func getColor(height: CGFloat) -> UIColor {
        if let color = cellColors[height] {
            return color
        }
        let randomColor =  random()// generate a random color
        cellColors[height] = randomColor
        return randomColor
    }
    func getColorName(height: CGFloat) -> String {
        if let name = cellName[height] {
            return name
        }
        let randomWord =  randomString(length: 10)// generate a random color
        cellName[height] = randomWord
        return randomWord
    }
    func randomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map{ _ in letters.randomElement()! })
    }
    //---------------------------------------------------------------------------------
    
    
    override func viewWillAppear(_ animated: Bool) {
        if(newCellHeight  != nil){
            if(newChangedColor != nil){
                cellColors[newCellHeight!] = newChangedColor
            }
        }
        collectionView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setContainer()
        setupDelegate()
        setCollectionView()
        setrefreshButton()
        DetailsViewController.delegate = self
        
        // Custom UI Transitions
        self.navigationController?.delegate = self
        
        if let layout = collectionView.collectionViewLayout as? ViewLayout {
            layout.delegate = self
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return randomInt
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        let height = cell.frame.height
        
        let _ = getColor(height: height)
        let _ = getColorName(height: height)
        cell.backgroundColor = cellColors[height]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCell:UICollectionViewCell = collectionView.cellForItem(at: indexPath)!
        let selectedBackgroundColor: UIColor = selectedCell.backgroundColor!
        
        detailsViewController.container.backgroundColor = selectedBackgroundColor
        detailsViewController.cellHeight = selectedCell.frame.height
        detailsViewController.cellName = cellName
        self.navigationController?.pushViewController(detailsViewController, animated: true)
    }
}

