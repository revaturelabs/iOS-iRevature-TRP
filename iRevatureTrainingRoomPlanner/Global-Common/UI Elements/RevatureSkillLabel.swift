//
//  RevatureSkillLabel.swift
//  iRevatureTrainingRoomPlanner
//
//  Created by admin on 2/17/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class RevatureSkillLabel: UILabel{
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
        backgroundColor = .gray
        textColor = .white
        
    }
    
    func applyLayoutStyles(){
        layer.cornerRadius = 5.0
        layer.borderWidth = 2.0
        layer.borderColor = UIColor.gray.cgColor
    }
    
    func applyAnimations(){
        
    }
}
