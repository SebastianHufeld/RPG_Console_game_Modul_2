//
//  Tank.swift
//  RPG
//
//  Created by Sebastian Hufeld on 20.01.25.
//

import Foundation

class Tank: Hero {
    var stamina: Int
    
    init(name: String, hp: Double, attackPoints: Int, defensePoints: Int, stamina: Int) {
        self.stamina = stamina
        super.init(name: name, hp: hp, attackPoints: attackPoints, defensePoints: defensePoints)
    }
    override var description: String{
        return super.description + ", \(stamina) Staminapunkte"
    }
    
    
    func jumpAttack(jumpTo: Enemy){
        if self.stamina <= 15 {
            jumpTo.hp -= 12
            print("Du kannst diesen Angriff nicht ausführen, da du keine Stamina mehr hast. Daher wurde ein normaler Angriff ausgeführt, welcher 12 Lebenspunkte abgezogen hat.")
        }
        self.stamina -= 15
        jumpTo.hp -= 30
        print("💨💨Sprungangriff💨💨")
        print("Du hast einen Sprungangriff genutzt und \(jumpTo.name) 20 Lebenspunkte abgezogen. Der Angriff hat dich ")
    }
    
    func massivePunch(target: Enemy){
        if self.stamina <= 10{
            target.hp -= 12
            print("Aktuell hast du nicht genug Stamina. Nimm in der nächsten Runde einen Stamina Trank. Du hast jetzt einen Normalen Angriff gestartet.")
        }
        
        self.stamina -= 10
        target.hp -= 20
        print("🔨🔨Gewaltiger Hammerschlag🔨🔨")
        print("Du hast einen gewaltigen Schlag ausgeführt! \(target.name) bekommt 20 Lebenspunkte abgezogen und hat noch \(target.hp)")
    }
    
    func blockAttack(attack: Enemy){
        if self.stamina <= 8{
            attack.hp -= 12
            print("Du kannst diesen Schildangriff nicht ausführen, da du keine Stamina mehr hast. Ein normaler Angriff wurde ausgeführt, welcher 12 Lebenspunkte abgezogen hat.")
        }
        
        self.stamina -= 8
        attack.hp -= 18
        print("🛡️🛡️Schildattack🛡️🛡️")
        print("Du hast mit deiner Schildattacke 18 Schaden ausgeteilt! \(attack.name) hat noch \(attack.hp) Lebenspunkte!")
    }
}
