//
//  RevatureHeaderLabel.swift
//  iRevatureTrainingRoomPlanner
//
//  Created by admin on 2/18/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class RevatureHeaderLabel: UILabel{
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    func setupButton(){
        applyContentStyles()
        applyLayoutStyles()
    }
    
    func applyContentStyles(){
        textColor = .gray
        font = font.withSize(25)
    }
    
    func applyLayoutStyles(){
        
    }
    
    func applyAnimations(){
        
    }
}
