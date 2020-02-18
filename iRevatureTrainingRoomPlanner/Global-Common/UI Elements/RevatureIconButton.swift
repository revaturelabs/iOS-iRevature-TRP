//
//  RevatureIconButton.swift
//  iRevatureTrainingRoomPlanner
//
//  Created by admin on 2/17/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class RevatureIconButton: UIButton{
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
     tintColor = .orange
        
    }
    
    func applyLayoutStyles(){
        
    }
    
    func applyAnimations(){
        
    }
}
