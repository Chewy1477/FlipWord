//
//  Button.swift
//  FlipWord
//
//  Created by Chris Chueh on 11/27/16.
//  Copyright © 2016 Chris Chueh. All rights reserved.
//

import Foundation
import UIKit

class Button: UIButton {
    var status: Bool?

    override init(frame: CGRect) {
        self.status = true
        
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
