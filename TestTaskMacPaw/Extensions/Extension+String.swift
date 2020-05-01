//
//  Extension+String.swift
//  TestTaskMacPaw
//
//  Created by Admin on 18.04.2020.
//  Copyright © 2020 Mykola Korotun. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    func height(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect,
                                            options: .usesLineFragmentOrigin,
                                            attributes: [.font: font],
                                            context: nil)
        
        return ceil(boundingBox.height)
    }
    
}
