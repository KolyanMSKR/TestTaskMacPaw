//
//  Extension+UILabel.swift
//  TestTaskMacPaw
//
//  Created by Admin on 17.04.2020.
//  Copyright © 2020 Mykola Korotun. All rights reserved.
//

import UIKit

extension UILabel {
    
    convenience init(title: String? = nil, font: UIFont?, numberOfLines: Int = 1) {
        self.init()
        
        self.text = title
        self.font = font
        self.numberOfLines = numberOfLines
    }
    
}
