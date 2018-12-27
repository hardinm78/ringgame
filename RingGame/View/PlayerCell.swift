//
//  PlayerCell.swift
//  RingGame
//
//  Created by Michael Hardin on 12/19/18.
//  Copyright © 2018 Michael Hardin. All rights reserved.
//

import UIKit

class PlayerCell: UICollectionViewCell {

    @IBOutlet weak var playerImage: UIImageView!
    @IBOutlet weak var playerBalance: UILabel!
    @IBOutlet weak var playerName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 5
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 2, height: 2)
        layer.shadowRadius = 2
        layer.shadowOpacity = 0.8
        layer.masksToBounds = false
        
        playerImage.layer.cornerRadius = 10
    }

    override var isHighlighted:Bool{
        didSet{
            if(isHighlighted == true){
                self.backgroundColor = UIColor.init(red: 95/255.0, green: 191/255.0, blue: 249/255.0, alpha: 1.0)
            }else{
                self.backgroundColor =  UIColor.init(red: 55/255.0, green: 114/255.0, blue: 255/255.0, alpha: 1.0)
            }
        }
    }

}
