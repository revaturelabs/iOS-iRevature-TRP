//
//  RevatureButton.swift
//  iRevatureTrainingRoomPlanner
//
//  Created by admin on 2/17/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import UIKit

class RevatureButton: UIButton{
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupButton(){
        setRevatureColor()
    }
    
    func setRevatureColor(){
        setTitleColor(.orange, for: .normal)
    }
}
