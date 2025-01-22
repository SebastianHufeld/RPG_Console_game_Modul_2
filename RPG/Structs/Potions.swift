//
//  Tränke.swift
//  RPG
//
//  Created by Sebastian Hufeld on 20.01.25.
//

struct Potions{
    var name: String
    var effect: String
    var potionsLeft: Int
    var used: Int {
        didSet{
            used += 1
            print("\(name) mit dem \(effect) wurde eingenommen.")
        }
    }
    
    mutating func usedPotion(){
        if potionsLeft <= 0 {
            print("Du hast keine Zaubertränke mehr!")
        } else {
            potionsLeft -= 1
            print("Du hast einen Trank genommen!")
        }
    }
}
