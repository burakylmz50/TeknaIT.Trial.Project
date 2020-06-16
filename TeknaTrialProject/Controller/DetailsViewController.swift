//
//  DetailsViewController.swift
//  TeknaTrialProject
//
//  Created by Burak Yılmaz on 16.06.2020.
//  Copyright © 2020 Burak Yılmaz. All rights reserved.
//

import UIKit

// Delegate protocol declaration
protocol AddContactDelegate{
    func addContact(changedColor : UIColor,cellHeight : CGFloat)
}

class DetailsViewController: UIViewController {
    
    // Keeps reference to the delegate
    static var delegate : AddContactDelegate!
    var cellHeight : CGFloat?
    
    // Color names according to their height.
    var cellName = Dictionary<CGFloat, String>()

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
    
    let colorNameLabel = UILabel()
    func setcolorNameLabel() {
        container.addSubview(colorNameLabel)
        colorNameLabel.snp.makeConstraints { (make) -> Void  in
            colorNameLabel.textColor = .white
            colorNameLabel.font = colorNameLabel.font.withSize(30)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.top.equalTo(150)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        colorNameLabel.text = cellName[cellHeight!]
    }
    override func viewDidLoad() {
        setContainer()
        setrefreshButton()
        setcolorNameLabel()
    }
    
    // Random color func.
    func random() -> UIColor {
        return UIColor(red: .random(in: 0...1),
                       green: .random(in: 0...1),
                       blue: .random(in: 0...1),
                       alpha: 1.0)
    }
    
    let refreshButton = ColorChangeButton()
    func setrefreshButton(){
        container.addSubview(refreshButton)
        refreshButton.setTitle("Refresh Color", for: .normal)
        refreshButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(50)
        }
        refreshButton.addTarget(self, action: #selector(refreshButtonAction), for: .touchUpInside)
    }
    
    @objc func refreshButtonAction(sender: UIButton!) {
        DetailsViewController.delegate.addContact(changedColor:  random(), cellHeight: cellHeight!)
        self.navigationController?.popViewController(animated: true)
    }
}


