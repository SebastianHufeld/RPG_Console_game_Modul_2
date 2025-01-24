//
//  Enemy.swift
//  RPG
//
//  Created by Sebastian Hufeld on 20.01.25.
//

import Foundation

class Enemy: Charakter, CustomStringConvertible{
    var attackPoints: Int
    var blockPoints: Int
    
    init(name: String, hp: Double, attackPoints: Int, blockPoints: Int) {
        self.attackPoints = attackPoints
        self.blockPoints = blockPoints
        super.init(name: name, hp: hp)
    }
    var description: String {
        return "Die Gegner: \(name): \(hp) Lebenspunkte, \(attackPoints) Angriffspunkte, \(blockPoints) Blockpunkte"
    }
    
    func randomAttack(_ hero: [Hero]){
        normalAttack(target: hero.randomElement()!)
    }
}
