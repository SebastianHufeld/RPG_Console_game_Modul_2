//
//  Game.swift
//  RPG
//
//  Created by Sebastian Hufeld on 20.01.25.
//

import Foundation

func game() {
    var heros: [Hero] = [
        Magican(name: "Sylvaris, der Magiermeister", hp: 100, attackPoints: 15, defensePoints: 80, mana: 100),
        Tank(name: "Flameborn, der Tank", hp: 120, attackPoints: 30, defensePoints: 100, stamina: 100),
        Archer(name: "Faelor, die Meisterschützin", hp: 100, attackPoints: 20, defensePoints: 40, arrows: 20, backPack: Items(arrows: 20, arrowName: "Feuerpfeile", fireArrows: 15))
        ]
    
    var enemies: [Enemy] = [
        Endboss(name: "Malvortas, der Unbesiegte", hp: 200, attackPoints: 55, blockPoints: 80, helper: 1),
        Helper(name: "Zeroth, der Heiler", hp: 50, attackPoints: 0, blockPoints: 50, spawns: 1)
    ]
    
    
    

    
    var currentRound = 1
    var gameStatus: GameStatus = .prepare
    
    while gameStatus != .win && gameStatus != .gameover{
        
        print("-----HELDEN-----")
        heros.forEach{ print ($0) }
        print("-----GEGNER-----")
        enemies.forEach{ print ($0) }
    }
    
    func gameRound() {
        print(currentRound.roundHeader())
        
        for hero in heros{
            //actionHero(Hero)
        }
        
        for enemy in enemies{
            //actionEnemy(Enemy)
        }
        
        currentRound += 1
    }
    
    func actionHero(_ hero: Hero){
        print("\(hero.name) ist jetzt dran!")
        magicMenu(hero)
    }
    
    func magicMenu(_ hero: Magican, _ backpack: Backpack) {
        print("\(hero.name) ist am Zug. Was möchtest du tun?")
        print("[1] Angriff ausüben")
        print("[2] Rucksack nutzen")
        let input = readLine()!
        switch input {
        case "1":
            hero.attackMenu(enemies, heros)
        case "2":
            backpack.potionsMenu(hero)
        default:
            print("Ungültige Eingabe!")
        }
    }
        
    }
    
    inventory.forEach{ item in
        print(item.description())
    }
    
}
