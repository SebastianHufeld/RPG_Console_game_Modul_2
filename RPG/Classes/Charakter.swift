//
//  Charakter.swift
//  RPG
//
//  Created by Sebastian Hufeld on 20.01.25.
//

import Foundation

class Charakter {
    
    let name: String
    var hp: Double
    let red = "\u{001B}[31m"
    let green = "\u{001B}[32m"
    let yellow = "\u{001B}[33m"
    let bold = "\u{001B}[1m"
    let reset = "\u{001B}[0m"
    
    init(name: String, hp: Double) {
        self.name = name
        self.hp = hp
    }
    
    func normalAttack(target: Charakter){
        target.hp -= 12
        print("Dein Angriff hat \(target.name) 12 Lebenspunkte abgezogen. \(target.hp) Lebenspunkt sind noch vorhanden.")
    }
}
