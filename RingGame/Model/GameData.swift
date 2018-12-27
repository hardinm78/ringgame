//
//  Players.swift
//  RingGame
//
//  Created by Michael Hardin on 12/19/18.
//  Copyright © 2018 Michael Hardin. All rights reserved.
//

import Foundation

class GameData{
    
    enum gameState {
        case live,remove,takeAway,setBalance
    }
    
    var players = [Player]()
    var moneyBallValue = 1
    var currentGameState = gameState.live
    
    var totalBalance: Int {
        var t = 0
        for p in players {
            t+=p.balance
        }
        return t
    }
        
    func removePlayer(index: Int){
        players.remove(at: index)
    }
    func addPlayer(name:String,balance:Int){
        players.append(Player.init(name: name, balance: balance))
    }
    func shuffle(){
        players.shuffle()
    }
    
    func score(player:Player){
        for p in players {
            if p !== player{
                if p.balance > moneyBallValue{
                    player.balance += moneyBallValue
                    p.balance -= moneyBallValue
                }else {
                    player.balance += p.balance
                    p.balance -= p.balance
                }
            }
            if p.balance <= 0 {
                if let rIndex = players.index(where: {$0 === p}) {
                    removePlayer(index: rIndex)
                }
            }
        }
    }
    
    func takeAway(player:Player){
        for p in players {
            if p !== player{
                p.balance += moneyBallValue
                player.balance -= moneyBallValue
            }
        }
    }
    
    func addPlayers(){
        let p1 = Player.init(name: "Mike Hardin", balance: 20)
        let p2 = Player.init(name: "Zach Boyd", balance: 10)
        let p3 = Player.init(name: "Double D", balance: 20)
        let p4 = Player.init(name: "Nick Milner", balance: 20)
        let p5 = Player.init(name: "Shannon", balance: 10)
        let p6 = Player.init(name: "Kenny McMinn", balance: 20)
        let p7 = Player.init(name: "Jay Haley", balance: 20)
        
        players.append(contentsOf: [p1,p2,p3,p4,p5,p6,p7])
    }
}
