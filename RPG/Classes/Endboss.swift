//
//  Endboss.swift
//  RPG
//
//  Created by Sebastian Hufeld on 20.01.25.
//

import Foundation

class Endboss: Enemy{
    
    var helper: Int
    
    init(name: String, hp: Double, attackPoints: Int, blockPoints: Int, helper: Int) {
        self.helper = helper
        super.init(name: name, hp: hp, attackPoints: attackPoints, blockPoints: blockPoints)
    }
    
    func callHelper(helpingHand: Helper){
        if self.hp < 50 && helper > 0 {
            print("Die Gesundheit des Bosses ist unter 50 Lebenspunkte! Er beschwört seinen Helfer. 🪄")
        }
    }
    
    func groupAttack(target: [Hero]){
        target.forEach{ hero in hero.hp -= 30 }
        print("Oh nein! Der Endboss \(self.name) hat einen starken Gruppenangriff gestartet, der die Rüstung direkt durchdringt und deinen Helden jeweils 30 Lebenspunkte abzieht!")
    }
}
