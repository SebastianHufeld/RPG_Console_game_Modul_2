//
//  Extensions.swift
//  RPG
//
//  Created by Sebastian Hufeld on 20.01.25.
//

import Foundation


extension Int {
    func roundHeader() -> String{
        return "========= RUNDE \(self) BEGINNT =========\n"
    }
}

extension Double {
    var twoDigits: Double {
        return Double(String(format: "%.2f",self))!
    }
}

extension Charakter {
    func applyDamage(damage: Int) {
        var remainingDamage = damage
        
        if self is Enemy {
            let enemy = self as! Enemy
            if enemy.blockPoints > 0 {
                if enemy.blockPoints >= remainingDamage {
                    enemy.blockPoints -= remainingDamage
                    remainingDamage = 0
                } else {
                    remainingDamage -= enemy.blockPoints
                    enemy.blockPoints = 0
                }
            }
        } else if self is Hero {
            let hero = self as! Hero
            if hero.defensePoints > 0 {
                if hero.defensePoints >= remainingDamage {
                    hero.defensePoints -= remainingDamage
                    remainingDamage = 0
                } else {
                    remainingDamage -= hero.defensePoints
                    hero.defensePoints = 0
                }
            }
        }
        if remainingDamage > 0 {
            hp -= Double(remainingDamage)
            if hp < 0 { hp = 0 }
        }
    }
}

