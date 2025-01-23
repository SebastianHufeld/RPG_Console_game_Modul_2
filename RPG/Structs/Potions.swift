//
//  Tränke.swift
//  RPG
//
//  Created by Sebastian Hufeld on 20.01.25.
//

struct Potions: Inventory{
    
    var name: String
    var effect: String
    var potionsLeft: Int
    var used: Int = 0
    
    mutating func usedPotion(){
        if potionsLeft <= 0 {
            print("Du hast keine Zaubertränke mehr!")
        } else {
            potionsLeft -= 1
            used += 1
            print("\(name) mit dem \(effect) wurde eingenommen.")
        }
    }
    func description() -> String {
        return "Trank: \(name), \nEffekt: \(effect), \nVerbleinde Anzahl an Tränken: \(potionsLeft)"
    }
}
