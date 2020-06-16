//
//  RandomColorExtension.swift
//  TeknaTrialProject
//
//  Created by Burak Yılmaz on 16.06.2020.
//  Copyright © 2020 Burak Yılmaz. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    class var random: UIColor {
        return UIColor(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1), alpha: 1.0)
    }
}
