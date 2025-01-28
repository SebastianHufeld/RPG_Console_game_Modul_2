//
//  Enums.swift
//  RPG
//
//  Created by Sebastian Hufeld on 20.01.25.
//

import Foundation

enum GameStatus: String {
    case prepare = "Mach dich für den Kampf bereit!\n"
    case fight = "Kämpft!\n"
    case win = "Du hast den Gegner besiegt!\n"
    case gameover = "Alle deine Helden wurden vernichtet!\n"
}

enum Condition: String {
    
    case fit
    case wounded
    case eliminated
}
