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
    override var description: String{
        return super.description + ", \(helper) Helfer verfügbar"
    }
    
    func callHelper(helpingHand: Helper) -> Helper?{
        if self.hp < 80 && helper > 0 {
            print("Die Gesundheit des Bosses ist unter 80 Lebenspunkte! Er beschwört seinen Helfer. 🪄")
            let newHelper: Helper = Helper(name: "Zeroth, der Heiler", hp: 50, attackPoints: 0, blockPoints: 50, spawns: 1)
            self.helper -= 1
            print("\(newHelper.name) ist jetzt auf dem Schlachfeld und heilt \(self.name) mit 50 Lebenspunkten")
            newHelper.healBoss(heal: self)
            return newHelper
        }
        return nil
    }
    
    func groupAttack(target: [Hero]){
        target.forEach{ hero in hero.hp -= 30 }
        print("🌪️🌪️🌪️🌪️🌪️🌪️")
        print("Oh nein! Der Endboss \(self.name) hat einen starken Gruppenangriff gestartet, der die Rüstung direkt durchdringt und deinen Helden jeweils 30 Lebenspunkte abzieht!")
    }
    
    func specialAttack(target: Hero){
        target.hp -= 50
        print("\(self.name) hat \(target.name) mit einer mächtigen Specialattacke angegriffen! \(target.name) verliert 50 Lebenspunkte!")
    }
    
    override func normalAttack(target: Charakter) {
        target.hp -= 20
        print("\(self.name) hat \(target.name) 20 Lebenspunkte abgezogen. \(target.hp) Lebenspunkt sind noch vorhanden.")
    }
    
    override func randomAttack(_ hero: [Hero]) {
        var randomNr: Int = Int.random(in: 1...3)
        
        switch randomNr{
        case 1:
            specialAttack(target: hero.randomElement()!)
        case 2:
            groupAttack(target: hero)
        default:
            normalAttack(target: hero.randomElement()!)
        }
    }
}
