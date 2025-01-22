//
//  Helper.swift
//  RPG
//
//  Created by Sebastian Hufeld on 22.01.25.
//

import Foundation

class Helper: Enemy{
    var spawns: Int = 1
    
    init(name: String, hp: Double, attackPoints: Int, blockPoints: Int, spawns: Int) {
        self.spawns = spawns
        super.init(name: name, hp: hp, attackPoints: attackPoints, blockPoints: blockPoints)
    }
    
    func healBoss(heal: Endboss){
        heal.hp += 50
        print("\(self.name) hat \(heal.name) wieder 50 Lebenspunkte gegeben! \(heal.name) hat nun \(heal.hp) Lebenspunkte! ❤️‍🩹")
    }
}
