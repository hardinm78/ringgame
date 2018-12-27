//
//  ViewController.swift
//  RingGame
//
//  Created by Michael Hardin on 12/19/18.
//  Copyright © 2018 Michael Hardin. All rights reserved.
//

import UIKit

class GameVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var moneyBallBtn: UIButton!
    @IBOutlet weak var totalLabel: UILabel!
    
    var takeAway = false
    var remove = false
    var game = GameData()    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        game.addPlayers()
        refreshUI()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return game.players.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let player = game.players[indexPath.row]
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "playerCell", for: indexPath) as? PlayerCell{
            cell.playerName.text = player.name
            cell.playerImage.image = UIImage(named:player.imageName)
            cell.playerBalance.text = "$\(player.balance)"
            return cell
        }else{
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let yourWidth = collectionView.bounds.width/3 - 6.7
        let yourHeight = yourWidth
        return CGSize(width: yourWidth, height: yourHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let player = game.players[indexPath.row]
                
        switch game.currentGameState {
        case .live:
            game.score(player:player)
//
        case .remove:
            game.removePlayer(index: indexPath.row)
            game.currentGameState = .live
        case .takeAway:
            game.takeAway(player: player)
            game.currentGameState = .live
        case .setBalance:
            let player = game.players[indexPath.row]
            balanceAlert(player:player)
            game.currentGameState = .live
            
        }
        
        view.backgroundColor = NORMAL_BG_COLOR
        refreshUI()
    }
    
    
    
    @IBAction func moneyBallValuePressed(_ sender: UIButton) {
        switch game.moneyBallValue {
        case 1:
            game.moneyBallValue = 2
            moneyBallBtn.setTitle("Money Ball = $2", for: .normal)
        case 2:
            game.moneyBallValue = 3
            moneyBallBtn.setTitle("Money Ball = $3", for: .normal)
        case 3:
            game.moneyBallValue = 5
            moneyBallBtn.setTitle("Money Ball = $5", for: .normal)
        case 5:
            game.moneyBallValue = 10
            moneyBallBtn.setTitle("Money Ball = $10", for: .normal)
        default:
            game.moneyBallValue = 1
            moneyBallBtn.setTitle("Money Ball = $1", for: .normal)
        }
    }
    
    @IBAction func takeAwayPressed(_ sender: UIButton) {
        
        switch game.currentGameState {
        case .live:
            game.currentGameState = .takeAway
            view.backgroundColor = WARNING_BG_COLOR
        case .remove:
            game.currentGameState = .takeAway
            view.backgroundColor = WARNING_BG_COLOR
        case .takeAway:
            game.currentGameState = .live
            view.backgroundColor = NORMAL_BG_COLOR
        case .setBalance:
            game.currentGameState = .takeAway
            view.backgroundColor = WARNING_BG_COLOR
        }
        
    }
    @IBAction func shuffleBtnPressed(_ sender: UIButton) {
        game.shuffle()
        refreshUI()
    }
    
    @IBAction func addBtnPressed(_ sender: UIButton) {
        let alert = UIAlertController(title: "Add Player", message: "Enter Player Info", preferredStyle: .alert)
        alert.addTextField { (nameField) in
            nameField.placeholder = "Name"
        }
        alert.addTextField { (balanceField) in
            balanceField.placeholder = "Starting Balance"
            balanceField.keyboardType = .numberPad
        }
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { [weak alert] (_) in
            let nameField = alert!.textFields![0]
            let balanceField = alert!.textFields![1]
            
            if nameField.text != "" && (Int(balanceField.text!) != nil){
                self.game.addPlayer(name: nameField.text!, balance: Int(balanceField.text!)!)
                print(nameField)
            }
            self.refreshUI()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert,animated: true,completion: nil)
    }
    
    @IBAction func RemovePressed(_ sender: UIButton) {
        switch game.currentGameState {
        case .live:
            game.currentGameState = .remove
            view.backgroundColor = WARNING_BG_COLOR
        case .takeAway:
            game.currentGameState = .remove
            view.backgroundColor = WARNING_BG_COLOR
        case .remove:
            game.currentGameState = .live
            view.backgroundColor = NORMAL_BG_COLOR
        case .setBalance:
            game.currentGameState = .remove
            view.backgroundColor = WARNING_BG_COLOR
        }
    }
    
    
    @IBAction func setPlayerBalancePressed(_ sender: UIButton) {
        switch game.currentGameState {
        case .live:
            game.currentGameState = .setBalance
            view.backgroundColor = WARNING_BG_COLOR
        case .takeAway:
            game.currentGameState = .setBalance
            view.backgroundColor = WARNING_BG_COLOR
        case .remove:
            game.currentGameState = .setBalance
            view.backgroundColor = WARNING_BG_COLOR
        case .setBalance:
            game.currentGameState = .live
            view.backgroundColor = NORMAL_BG_COLOR
        }
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        collectionView.selectItem(at: indexPath, animated: true,scrollPosition: UICollectionView.ScrollPosition.top)
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    func refreshUI(){
        collectionView.reloadData()
        totalLabel.text = "Total in Pool: $\(game.totalBalance)"
    }
    
    func balanceAlert(player:Player){
        let alert = UIAlertController(title: "Change Balance", message: "New Player Balance", preferredStyle: .alert)
        alert.addTextField { (amountField) in
            amountField.placeholder = "Amount"
            amountField.keyboardType = .numberPad
        }
        
        alert.addAction(UIAlertAction(title: "Update", style: .default, handler: { [weak alert] (_) in
            let amountField = alert!.textFields![0]
            
            if (Int(amountField.text!) != nil){
                player.balance = Int(amountField.text!)!
            }
            self.refreshUI()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert,animated: true,completion: nil)
    }
    
}

