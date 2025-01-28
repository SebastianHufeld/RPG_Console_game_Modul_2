//
//  Archer.swift
//  RPG
//
//  Created by Sebastian Hufeld on 20.01.25.
//

import Foundation

class Archer: Hero{
    var arrows: Int
    var backPack: Items
    private var sneakAttackCount: Int = 1
    
    init(name: String, hp: Double, attackPoints: Int, defensePoints: Int ,arrows: Int, backPack: Items) {
        self.arrows = arrows
        self.backPack = backPack
        super.init(name: name, hp: hp, attackPoints: attackPoints, defensePoints: defensePoints)
    }
    override var description: String{
        return super.description + ", \(backPack.arrows) normale Pfeile, \(backPack.arrows) normale Pfeile im Rucksack sowie \(backPack.fireArrows) Feuerpfeile"
    }
    
    override func normalAttack(target: Charakter) {
        arrows -= 1
        target.applyDamage(damage: 12)
        print("🏹🏹🏹🏹🏹🏹Normale Pfeilattacke🏹🏹🏹🏹🏹🏹")
        Thread.sleep(forTimeInterval: 0.5)
        print("Diese Attacke hat dich einen Pfeil gekostet. Du hast noch \(arrows) Pfeile direkt bei dir.")
        print("Lebenspunkte von \(target.name): \(target.hp)")
        Thread.sleep(forTimeInterval: 0.8)
    }
    
    func sneakAttach(target: Enemy){
        if sneakAttackCount <= 0 {
            print("Du kannst diese Aktion nicht mehr ausführen! Du hast keine Schleichangriffe mehr!")
            Thread.sleep(forTimeInterval: 0.8)
            return
        }
        
        sneakAttackCount -= 1
        let arrowDamage = attackPoints * 2
        target.applyDamage(damage: arrowDamage)
        arrows -= 2
        print("🥷 🏹🥷 🏹🥷 🏹")
        Thread.sleep(forTimeInterval: 0.5)
        print("Dein Schleichangriff war erfolgreich! Der Schaden beträgt \(arrowDamage).")
        print("Du kannst noch \(sneakAttackCount) Schleichangriff(e) durchführen!")
        print("Lebenspunkte von \(target.name): \(target.hp) | Verteidigungspunkte: \(target.blockPoints)")
        Thread.sleep(forTimeInterval: 0.8)
    }
    
    
    func trippleAttack(target: Enemy){
        print("Welche Pfeile möchtest du für deinen Angriff verwenden?")
        Thread.sleep(forTimeInterval: 0.5)
        print("1. Normale Pfeile (30% mehr Schaden. Aktuell vorhandene Pfeile im eigenen Inventar: \(arrows), im Rucksack \(backPack.arrows) 🏹🏹🏹🏹")
        print("2. Feuerpfeile (50% mehr Schaden, aber limitierte Stückzahl. Aktuell vorhandene Pfeile: \(backPack.fireArrows) 🔥🔥🔥🔥")
        
        if let arrowChoise = Int(readLine()!) {
            switch arrowChoise {
            case 1:
                if arrows >= 3 {
                    let trippleDamage = Int(Double(attackPoints*3) * 1.3)
                    arrows -= 3
                    target.applyDamage(damage: trippleDamage)
                    print("🏹🏹🏹🏹🏹🏹🏹")
                    Thread.sleep(forTimeInterval: 0.5)
                    print("Du hast \(trippleDamage) Schaden mit 3 normalen Pfeilen gemacht. Du hast noch \(arrows) normale Pfeile im Inventar.")
                    print("Lebenspunkte von \(target.name): \(target.hp) | Verteidigungspunkte: \(target.blockPoints)")
                    Thread.sleep(forTimeInterval: 0.8)
                } else if backPack.arrows >= 3 {
                    let backPackDamage = Int(Double(attackPoints*3) * 1.3)
                    backPack.arrows -= 3
                    target.applyDamage(damage: backPackDamage)
                    print("🏹🏹🏹🏹🏹🏹🏹")
                    Thread.sleep(forTimeInterval: 0.5)
                    print("Du hast \(backPackDamage) Schaden mit 3 normalen Pfeilen gemacht. Du hast noch \(backPack.arrows) normale Pfeile im Rucksack.")
                    print("Lebenspunkte von \(target.name): \(target.hp) | Verteidigungspunkte: \(target.blockPoints)")
                    Thread.sleep(forTimeInterval: 0.8)
                } else {
                    print("Du hast keine normalen Pfeile mehr! Nutze Feuerpfeile.")
                    Thread.sleep(forTimeInterval: 0.8)
                }
            case 2:
                if backPack.fireArrows >= 3{
                    let fireDamage = Int(Double(attackPoints*3) * 1.5)
                    backPack.fireArrows -= 3
                    target.applyDamage(damage: fireDamage)
                    print("🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥")
                    Thread.sleep(forTimeInterval: 0.5)
                    print("Du hast \(fireDamage) Schaden mit 3 \(backPack.arrowName) gemacht. Du hast noch \(backPack.fireArrows) \(backPack.arrowName) im Rucksack.")
                    print("Lebenspunkte von \(target.name): \(target.hp) | Verteidigungspunkte: \(target.blockPoints)")
                    Thread.sleep(forTimeInterval: 0.8)
                } else {
                    print("Du hast keine \(backPack.arrowName) mehr.")
                    Thread.sleep(forTimeInterval: 0.8)
                }
            default:
                print("Du hast keine Auswahl getroffen, bitte versuche es erneut.")
            }
        }
    }
    override func attackMenu(_ enemies: [Enemy], _ heros: [Hero]) {
        print("\nSie hat \(self.arrows) normale Pfeile & \(self.backPack.fireArrows) \(self.backPack.arrowName).")
        print("Wähle deine Attacke:")
        print("[1] - Normale Attacke (12 Lebenspunkte Schade, Kostet einen Pfeil. Verfügbare Pfeile \(arrows).")
        print("[2] - Schleichattacke (Doppelter Schaden, \(sneakAttackCount) verfügbare Angriffe")
        print("[3] - Dreifachangriff (Entweder mit normalen oder \(backPack.arrowName).")
        
        let input = readLine()!
        
        switch input {
        case "1":
            normalAttack(target: enemies.randomElement()!)
        case "2":
            sneakAttach(target: enemies.randomElement()!)
        case "3":
            trippleAttack(target: enemies.randomElement()!)
        default:
            print("Du hast keine Attacke ausgewählt! Wähle eine Attacke aus.")
            attackMenu(enemies, heros)
        }
    }
}
