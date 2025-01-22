//
//  Hero.swift
//  RPG
//
//  Created by Sebastian Hufeld on 20.01.25.
//

import Foundation

class Hero: Charakter{
    var attackPoints: Int
    var defensePoints: Int
    
    init(name: String, hp: Double, attackPoints: Int, defensePoints: Int) {
        self.attackPoints = attackPoints
        self.defensePoints = defensePoints
        super.init(name: name, hp: hp)
    }
    
    func toHeal (_ toHeal: Double){
        self.hp += toHeal
    }
}
