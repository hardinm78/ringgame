//
//  RoundedButton.swift
//  RingGame
//
//  Created by Michael Hardin on 12/20/18.
//  Copyright © 2018 Michael Hardin. All rights reserved.
//

import UIKit

class RoundedButton: UIButton {

    override func awakeFromNib() {
        layer.cornerRadius = 10
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 2, height:2)
        layer.shadowRadius = 2
        layer.shadowOpacity = 0.8
        
        
    }

}
