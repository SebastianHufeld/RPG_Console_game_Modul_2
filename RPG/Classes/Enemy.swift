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
    var condition: Condition = .fit
    var isPoisoned: Bool = false
    var poisenRoundsRemaining: Int = 0
    
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
    
    func poisinedEffect(){
        if isPoisoned{
            hp -= 15
            poisenRoundsRemaining -= 1
            print("\(name) ist vergiftet! Er verliert 15 Lebenspunkte")
            if poisenRoundsRemaining <= 0 {
                isPoisoned = false
            }
        }
    }
    
    func updateCondition() {
        if hp <= 0 {
            condition = .eliminated
            print("\(red)\(name) ist eleminiert worden.\(reset)")
        } else if hp < 50 {
            condition = .wounded
            print("\(yellow)\(name) ist verwundet.\(reset)")
        } else {
            condition = .fit
            print("\(green)\(name) fühlt sich Gesund.\(reset)")
        }
    }
    func takeDamage(_ damage: Int) {
        var remainingDamage = damage
        
        if blockPoints > 0 {
            if blockPoints >= remainingDamage {
                blockPoints -= remainingDamage
                remainingDamage = 0
            } else {
                remainingDamage -= blockPoints
                blockPoints = 0
            }
        }
        
        if remainingDamage > 0 {
            hp -= Double(remainingDamage)
            if hp < 0 { hp = 0 }
        }
    }
}
