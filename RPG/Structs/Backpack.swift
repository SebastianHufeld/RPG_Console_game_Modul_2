//
//  Backpack.swift
//  RPG
//
//  Created by Sebastian Hufeld on 20.01.25.
//

import Foundation

struct BackPack: Inventory{
    var arrows: Int
    var arrowName: String 
    var fireArrows: Int
    func description() -> String {
        return "Du hast noch \(arrows) normale Pfeile und \(fireArrows) \(arrowName) im Rucksack!"
    }
}
