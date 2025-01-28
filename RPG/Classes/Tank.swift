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
        if self.stamina < 15 {
            jumpTo.applyDamage(damage: 12)
            print("Du kannst diesen Angriff nicht ausführen, da du keine Stamina mehr hast. Daher wurde ein normaler Angriff ausgeführt, welcher 12 Schadenspunkte verursacht.")
            print("\(jumpTo.name) hat jetzt noch \(jumpTo.hp) Lebenspunkte.")
            return
        }
        self.stamina -= 15
        jumpTo.applyDamage(damage: 30)
        print("💨💨💨💨💨💨Sprungangriff💨💨💨💨💨💨")
        Thread.sleep(forTimeInterval: 0.5)
        print("Du hast einen Sprungangriff genutzt und \(jumpTo.name) verursachst 30 Schadenpunkte. Du hast noch \(self.stamina) Stamina übrig.")
        print("Lebenspunkte von \(jumpTo.name): \(jumpTo.hp) | Verteidigungspunkte: \(jumpTo.blockPoints)")
        Thread.sleep(forTimeInterval: 0.8)
    }
    
    func massivePunch(target: Enemy){
        if self.stamina < 10{
            target.applyDamage(damage: 12)
            print("Aktuell hast du nicht genug Stamina. Nimm in der nächsten Runde einen Stamina Trank. Du hast jetzt einen Normalen Angriff gestartet.")
            print("\(target.name) hat jetzt noch \(target.hp) Lebenspunkte \(target.blockPoints) Blockpunkte.")
            return
        }
        
        self.stamina -= 10
        target.applyDamage(damage: 20)
        print("🔨🔨🔨🔨🔨🔨Gewaltiger Hammerschlag🔨🔨🔨🔨🔨🔨")
        Thread.sleep(forTimeInterval: 0.5)
        print("Du hast einen gewaltigen Schlag ausgeführt! \(target.name) bekommt 20 Schadenspunkte.")
        print("Lebenspunkte von \(target.name): \(target.hp) | Verteidigungspunkte: \(target.blockPoints)")
        Thread.sleep(forTimeInterval: 0.8)
    }
    
    func blockAttack(attack: Enemy){
        if self.stamina < 8{
            attack.applyDamage(damage: 12)
            print("Du kannst diesen Schildangriff nicht ausführen, da du keine Stamina mehr hast. Ein normaler Angriff wurde ausgeführt, welcher 12 Schaden verursacht.")
            print("Lebenspunkte von \(attack.name): \(attack.hp) | Verteidigungspunkte: \(attack.blockPoints)")
            return
        }
        
        self.stamina -= 8
        attack.applyDamage(damage: 18)
        print("🛡️🛡️🛡️🛡️🛡️🛡️Schildattacke🛡️🛡️🛡️🛡️🛡️🛡️")
        Thread.sleep(forTimeInterval: 0.5)
        print("Du hast mit deiner Schildattacke 18 Schaden ausgeteilt! \(attack.name) hat noch \(attack.hp) Lebenspunkte!")
        Thread.sleep(forTimeInterval: 0.8)
    }
    
    override func attackMenu(_ enemies: [Enemy], _ heros: [Hero]) {
        print("\nWähle deinen Angriff aus:")
        print("[1] - Sprungangriff (Schaden: 30, Staminakosten: 15)")
        print("[2] - Gewaltiger Schlag (Schaden: 20, Staminakosten: 10)")
        print("[3] - Schildattacke (Schaden: 18, Staminakosten: 8)")
        
        let input = readLine()!
        
        switch input {
        case "1":
            jumpAttack(jumpTo: enemies.randomElement()!)
        case "2":
            massivePunch(target: enemies.randomElement()!)
        case "3":
            blockAttack(attack: enemies.randomElement()!)
        default:
            print("Du hast keine Attacke ausgewählt! Wähle eine Attacke aus.")
            attackMenu(enemies, heros)
        }
    }
}
