//
//  ColorChangeButton.swift
//  TeknaTrialProject
//
//  Created by Burak Yılmaz on 16.06.2020.
//  Copyright © 2020 Burak Yılmaz. All rights reserved.
//

import Foundation
import UIKit

class ColorChangeButton : UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        self.setTitleColor(.darkGray, for: .normal)
        self.contentEdgeInsets = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
        self.backgroundColor = UIColor(white: 1, alpha: 0.8)
        self.titleLabel!.font = UIFont.boldSystemFont(ofSize: 20)
        self.layer.cornerRadius = 20
        self.setTitle("Refresh", for: .normal)
    }
}
