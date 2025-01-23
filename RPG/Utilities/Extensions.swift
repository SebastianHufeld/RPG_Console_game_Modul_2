//
//  Extensions.swift
//  RPG
//
//  Created by Sebastian Hufeld on 20.01.25.
//

import Foundation


extension Int {
    func roundHeader() -> String{
        return "========= RUNDE \(self) BEGINNT =========\n"
    }
}

extension Double {
    var twoDigits: Double {
        return Double(String(format: "%.2f",self))!
    }
}
