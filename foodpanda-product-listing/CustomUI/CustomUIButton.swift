//
//  CustomUIButton.swift
//  Baloora
//
//  Created by SOTSYS115 on 5/9/19.
//  Copyright © 2019 SOTSYS203. All rights reserved.
//

import UIKit

class CustomUIButton: UIButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        sharedInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        sharedInit()
    }
    
    override func prepareForInterfaceBuilder() {
        delay(0.2) {
            self.sharedInit()
        }
        
    }
    
    func sharedInit() {
        self.layer.cornerRadius = 10.0
        self.layer.masksToBounds = true
        self.layoutIfNeeded()
        self.layer.backgroundColor = UIColor.lightGray.cgColor
        self.layer.shadowColor =  UIColor.black.cgColor
        self.layer.borderWidth = 0.1
        self.layoutIfNeeded()
    }


}
