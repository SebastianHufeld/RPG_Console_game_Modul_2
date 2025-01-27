//
//  Enums.swift
//  RPG
//
//  Created by Sebastian Hufeld on 20.01.25.
//

import Foundation

enum GameStatus: String {
    case prepare = "Mach dich für den Kampf bereit!"
    case fight = "Kämpft! "
    case win = "Du hast den Gegner besiegt!"
    case gameover = "Alle deine Helden wurden vernichtet!"
}

enum Condition: String {
    
    case fit
    case wounded
    case eliminated
}
