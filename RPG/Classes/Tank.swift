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
        print("Du hast einen Sprungangriff genutzt und \(jumpTo.name) 20 Lebenspunkte abgezogen. Der Angriff hat dich ")
    }
}
