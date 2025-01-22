//
//  Archer.swift
//  RPG
//
//  Created by Sebastian Hufeld on 20.01.25.
//

import Foundation

class Archer: Hero{
    var arrows: Int
    private var sneakAttackCount: Int = 2
    
    init(name: String, hp: Double, attackPoints: Int, defensePoints: Int ,arrows: Int) {
        self.arrows = arrows
        super.init(name: name, hp: hp, attackPoints: attackPoints, defensePoints: defensePoints)
    }
    
    func sneakAttach(target: Enemy){
        if sneakAttackCount <= 0 {
            print("Du kannst diese Aktion nicht mehr ausführen! Du hast keine Schleichangriffe mehr!")
            return
        }
        
        sneakAttackCount -= 1
        let damage = attackPoints * 2
        target.hp -= Double(damage)
        print("🥷 🏹")
        print("Dein Schleichangriff war erfolgreich! Der Schaden beträgt \(damage). Damit hat \(target.name) noch \(target.hp) Lebenspunkte.")
        print("Du kannst noch \(sneakAttackCount) Schleichangriff(e) durchführen!")
    }
    
    
    func trippleAttack(target: Enemy){
        if arrows >= 3 {
            print("Du hast keine Pfeile mehr! Schau im Rucksack nach, ob dort noch welche sind.")
            return
        }
    }
}
