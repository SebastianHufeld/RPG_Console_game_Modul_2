//
//  Hero.swift
//  RPG
//
//  Created by Sebastian Hufeld on 20.01.25.
//

import Foundation

class Hero: Charakter, CustomStringConvertible{
    var attackPoints: Int = 0
    var defensePoints: Int = 0
    var potions: Potions?
    
    var description: String {
        return "Unser Held: \(name): \(hp) Lebenspunkte, \(attackPoints) Angriffspunkte, \(defensePoints) Verteidungungspunkte" }
    
    init(name: String, hp: Double, attackPoints: Int, defensePoints: Int) {
        self.attackPoints = attackPoints
        self.defensePoints = defensePoints
        super.init(name: name, hp: hp)
    }
    
    func toHeal (_ toHeal: Double){
        self.hp += toHeal
    }
    
    func attackMenu(_ enemies: [Enemy], _ heros: [Hero]){
        
    }
}
