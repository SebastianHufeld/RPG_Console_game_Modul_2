//
//  Archer.swift
//  RPG
//
//  Created by Sebastian Hufeld on 20.01.25.
//

import Foundation

class Archer: Hero{
    var arrows: Int
    var backPack: BackPack
    private var sneakAttackCount: Int = 2
    
    init(name: String, hp: Double, attackPoints: Int, defensePoints: Int ,arrows: Int, backPack: BackPack) {
        self.arrows = arrows
        self.backPack = backPack
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
        print("🥷 🏹🥷 🏹🥷 🏹")
        print("Dein Schleichangriff war erfolgreich! Der Schaden beträgt \(damage). Damit hat \(target.name) noch \(target.hp) Lebenspunkte.")
        print("Du kannst noch \(sneakAttackCount) Schleichangriff(e) durchführen!")
    }
    
    
    func trippleAttack(target: Enemy){
        print("Welche Pfeile möchtest du für deinen Angriff verwenden?")
        print("1. Normale Pfeile (30% mehr Schaden. Aktuell vorhandene Pfeile im eigenen Inventar: \(arrows), im Rucksack \(backPack.arrows) 🏹🏹🏹🏹")
        print("2. Feuerpfeile (50% mehr Schaden, aber limitierte Stückzahl. Aktuell vorhandene Pfeile: \(backPack.fireArrows) 🔥🔥🔥🔥")
        
        if let arrowChoise = Int(readLine()!) {
            switch arrowChoise {
            case 1:
                if arrows >= 3 {
                    let damage = Int(Double(attackPoints*3) * 1.3)
                    arrows -= 3
                    target.hp -= Double(damage)
                    print("🏹🏹🏹🏹🏹🏹🏹")
                    print("Du hast \(damage) Schaden mit 3 normalen Pfeilen gemacht. Du hast noch \(arrows) normale Pfeile im Inventar.")
                } else if backPack.arrows >= 3 {
                    let damage = Int(Double(attackPoints*3) * 1.3)
                    backPack.arrows -= 3
                    target.hp -= Double(damage)
                    print("🏹🏹🏹🏹🏹🏹🏹")
                    print("Du hast \(damage) Schaden mit 3 normalen Pfeilen gemacht. Du hast noch \(backPack.arrows) normale Pfeile im Rucksack.")
                } else {
                    print("Du hast keine normalen Pfeile mehr! Nutze Feuerpfeile.")
                }
            case 2:
                if backPack.fireArrows >= 3{
                    let damage = Int(Double(attackPoints*3) * 1.5)
                    backPack.fireArrows -= 3
                    target.hp -= Double(damage)
                    print("🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥")
                    print("Du hast \(damage) Schaden mit 3 Feuerpfeilen gemacht. Du hast noch \(backPack.fireArrows) Feuerpfeile im Rucksack.")
                } else {
                    print("Du hast keine Feuerpfeile mehr.")
                }
            default:
                print("Du hast keine Auswahl getroffen, bitte versuche es erneut.")
            }
        }
    }
}
