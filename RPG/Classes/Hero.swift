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
    var condition: Condition = .fit
    
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
    func updateCondition() {
        if hp <= 0 {
            condition = .eliminated
            print("\(red)\(name) ist eleminiert!\(reset)")
        } else if hp < 50 {
            condition = .wounded
            print("\(yellow)\(name) ist verletzt. \(reset)")
            
        } else {
            condition = .fit
            print("\(green)\(name) ist Gesund und kann Kämpfen. \(reset)")
        }
    }
    
    func takeDamage(_ damage: Int) {
            var remainingDamage = damage

            if defensePoints > 0 {
                if defensePoints >= remainingDamage {
                    defensePoints -= remainingDamage
                    remainingDamage = 0
                } else {
                    remainingDamage -= defensePoints
                    defensePoints = 0
                }
            }

            if remainingDamage > 0 {
                hp -= Double(remainingDamage)
                if hp < 0 { hp = 0 }
            }

            print("\(name) hat \(damage) Schaden genommen. Verteidigung: \(defensePoints), Lebenspunkte: \(hp)")
        }
}
