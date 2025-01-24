//
//  Magican.swift
//  RPG
//
//  Created by Sebastian Hufeld on 20.01.25.
//

import Foundation

class Magican: Hero{
    var mana: Int
    
    init(name: String, hp: Double, attackPoints: Int, defensePoints: Int, mana: Int) {
        self.mana = mana
        super.init(name: name, hp: hp, attackPoints: attackPoints, defensePoints: defensePoints)
    }
    
    override var description: String{
        return super.description + ", \(mana) Manapunkte"
    }
    
    func healHeros(toHeal: Hero){
        toHeal.hp += 20
        mana -= 20
        print("Du hast einen Heilungszauber ausgewählt. 🩹")
        print("\(toHeal.name) hat jetzt 20 Lebenspunkte dazubekommen.")
    }
    
    func poisenEnemy(target: Enemy){
        target.hp -= 15
        mana -= 15
        print("Mit deinem Giftzauber hast du den Gegner vergiftet! 🧪")
        print("Der Gegner \(target.name) hat jetzt noch \(target.hp).")
    }
    
    func magicShield(heroes: [Hero]){
        if mana < 40 {
            print("Du hast nicht genug Mana mehr! Dein magisches Schild kann nicht genutzt werden.")
            return
        }
        
        self.defensePoints += 40
        mana -= 40
        heroes.forEach{ hero in hero.defensePoints += 40 }
        print("Du hast das magische Schild ausgewählt! Du und deine Mitstreiter haben wieder 40 Punkte in der Verteidungung dazubekommen.")
    }
    
    override func attackMenu(_ enemies: [Enemy], _ heros: [Hero]) {
        print("\(self.name) ist dran! Er hat \(self.hp) Lebenspunkte & \(self.mana) Manapunkte.")
        print("Wähle aus, was du machen möchtest:")
        print("[1] - Heldenheilung (Ein Zufälliger Held erhält 20 Lebenspunkte. Kosten: 20 Manapunkte)")
        print("[2] - Gegner vergiften (Schaden: 15, Manakosten: 15, Hält 2 Runden)")
        print("[3] - Magisches Schild (40 Verteidigungspunkte für deine Helden. Kosten: 40 Manapunkte)")
        
        let input = readLine()!
        
        switch input {
        case "1":
            healHeros(toHeal: heros.randomElement()!)
        case "2":
            poisenEnemy(target: enemies.randomElement()!)
        case "3":
            magicShield(heroes: heros)
        default:
            print("Du hast keine Attacke ausgewählt! Wähle eine Attacke aus.")
            attackMenu(enemies, heros)
        }
    }
}
