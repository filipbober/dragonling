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
    let name: String
}

extension CombatItem {
    static func all() -> [CombatItem] {
        return [
            CombatItem(name: "Goblin"),
            CombatItem(name: "Dragon"),
            CombatItem(name: "Skeleton"),
            CombatItem(name: "Lich")
        ]
    }
}


