//
//  Player.swift
//  RingGame
//
//  Created by Michael Hardin on 12/19/18.
//  Copyright © 2018 Michael Hardin. All rights reserved.
//

import Foundation

class Player{
    
    var name: String
    var balance: Int
    var imageName : String = "unknown"
    
    
    init(name:String, balance:Int) {
        self.name = name
        self.balance = balance
        
        
        switch self.name {
        case "Mike Hardin":
            self.imageName = "mikeh"
        case "Jay Haley":
            self.imageName = "jay"
        case "Zach Boyd":
            self.imageName = "zach"
        case "Kenny McMinn":
            self.imageName = "kenny"
        default:
            self.imageName = "unknown"
        }
        
        
        }
    
}
