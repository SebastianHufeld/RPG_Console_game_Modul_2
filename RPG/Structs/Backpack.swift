//
//  Backpack.swift
//  RPG
//
//  Created by Sebastian Hufeld on 20.01.25.
//

import Foundation

struct Backpack{
    var arrows = Items(arrows: 20, arrowName: "Feuerpfeile", fireArrows: 15)
    
    var potions: [Potions] = [
        Potions(name: "Heilungstrank", effect: "Heilt dich um 20 Lebenspunkte", potionsLeft: 6, used: 0),
        Potions(name: "Schildtrank", effect: "Stellt 20 Verteidigungspunkte her", potionsLeft: 6, used: 0),
        Potions(name: "Manatrank", effect: "Stellt 20 Manapunkte her", potionsLeft: 6, used: 0),
        Potions(name: "Staminatrank", effect: "Stellt 20 Staminaounkte her", potionsLeft: 6, used: 0)
    ]
    
    mutating func potionsMenu(_ hero: Hero){
        print("Welchen Trank willst du ausrüsten?")
        potions.enumerated().forEach({print("\($0+1).\($1)")})
        
        var input: Int = Int(readLine()!) ?? 0
        if input >= 1 && input <= potions.count {
            hero.potions = potions[input-1]
            print("\(potions[input-1].name) erfolreich ausgerüstet!")
            potions.remove(at: input-1)
        } else {
            print("Ungültige Eingabe! Wähle eine Zahl von 1-\(potions.count)!")
            potionsMenu(hero)
        }
        
    }
}
