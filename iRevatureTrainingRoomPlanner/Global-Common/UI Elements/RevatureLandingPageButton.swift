//
//  RevatureLandingPageButton.swift
//  iRevatureTrainingRoomPlanner
//
//  Created by admin on 2/17/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class RevatureLandingPageButton: UIButton{
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
        
        setTitle("", for: .normal)
        tintColor = .orange
        
    }
    
    func applyLayoutStyles(){
        layer.cornerRadius = 5.0
        layer.borderWidth = 2.0
        layer.borderColor = UIColor.orange.cgColor
        
    }
    
    func applyAnimations(){
        
    }
}
