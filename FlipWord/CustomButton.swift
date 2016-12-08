//
//  Button.swift
//  FlipWord
//
//  Created by Chris Chueh on 11/27/16.
//  Copyright © 2016 Chris Chueh. All rights reserved.
//

import Foundation
import UIKit

class CustomButton: UIButton {
    var status: Bool = true
    
    override init(frame: CGRect) {
        self.status = true
        
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
