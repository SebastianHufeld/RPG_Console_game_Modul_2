//
//  Game.swift
//  RPG
//
//  Created by Sebastian Hufeld on 20.01.25.
//

import Foundation

func game() {
    let magician: Hero = Magican(name: "Sylvaris, der Magiermeister", hp: 100, attackPoints: 15, defensePoints: 80, mana: 100)
    let tank: Hero = Tank(name: "Flameborn, der Tank", hp: 120, attackPoints: 30, defensePoints: 100, stamina: 100)
    let archer: Hero = Archer(name: "Faelor, die Meisterschützin", hp: 100, attackPoints: 20, defensePoints: 40, arrows: 20, backPack: BackPack(arrows: 25, arrowName: "Feuerpfeile", fireArrows: 12))
    
    let heros: [Hero] = [magician, tank, archer]
    
    let endBoss = Endboss(name: "Malvortas, der Unbesiegte", hp: 200, attackPoints: 55, blockPoints: 80, helper: 1)
    let helper = Helper(name: "Zeroth, der Heiler", hp: 50, attackPoints: 0, blockPoints: 50, spawns: 1)
    let backPack = BackPack( arrows: 20, arrowName: "Feuerpfeile", fireArrows: 12)
    let healPotion = Potions(name: "Heilungstrank", effect: "Stellt 20% der Gesundheit wieder her", potionsLeft: 6, used: 0)
    let shieldPotion = Potions(name: "Schildtrank", effect: "Blockt die Angriffe für eine Runde ab", potionsLeft: 6, used: 0)
    
    let inventory: [Inventory] = [backPack, healPotion, shieldPotion]
    
    let enemies: [Enemy] = [endBoss, helper]
    
    var currentRound = 1
    var gameStatus: GameStatus = .prepare
    
    while gameStatus != .win && gameStatus != .gameover{
        print(currentRound.roundHeader())
        print("-----HELDEN-----")
        heros.forEach{ print ($0) }
        print("-----GEGNER-----")
        enemies.forEach{ print ($0) }
    }
    
    
    
    
    
    inventory.forEach{ item in
        print(item.description())
    }
    
}
