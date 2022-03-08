//
//  CombatEntity.swift
//  Dragonling
//
//  Created by Filip Bober on 2020-05-26.
//  Copyright © 2020 Filip Cyrus Bober. All rights reserved.
//

import Foundation

struct CombatItem: Identifiable {
    let id = UUID()
    var name: String
    var initiative: Int = 0
}

extension CombatItem {
    static func all() -> [CombatItem] {
        return [
            CombatItem(name: "Goblin"),
            CombatItem(name: "Dragon"),
            CombatItem(name: "Skeleton"),
            CombatItem(name: "Lich"),
            CombatItem(name: "Orc"),
            CombatItem(name: "Elf"),
            CombatItem(name: "Dwarf"),
            CombatItem(name: "Tiefling"),
            CombatItem(name: "Dragonborn"),
            CombatItem(name: "Beast"),
            CombatItem(name: "Aboleth"),
            CombatItem(name: "Mind Flyer")
        ]
    }
}


