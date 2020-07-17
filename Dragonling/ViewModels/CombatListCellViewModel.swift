//
//  CombatItemViewModel.swift
//  Dragonling
//
//  Created by Filip Bober on 2020-05-26.
//  Copyright © 2020 Filip Cyrus Bober. All rights reserved.
//

import Foundation

final class CombatListCellViewModel: ObservableObject {

    // Should this be exposed or private?
    @Published private(set) var item: CombatItem
    @Published var active: Bool
    @Published var hasActivated: Bool = false
    @Published var isDelaying: Bool = false
    @Published var usedReaction: Bool = false

    init(item: CombatItem, active: Bool) {
        self.item = item
        self.active = active
    }

    var id: UUID {
        return item.id
    }

    var name: String {
        return self.item.name.capitalized
    }

    var initiative: Int {
        set {
            item.initiative = newValue
        }
        get {
            return self.item.initiative
        }
    }
}

extension CombatListCellViewModel: Comparable {
    static func < (lhs: CombatListCellViewModel, rhs: CombatListCellViewModel) -> Bool {
        return lhs.item.initiative > rhs.item.initiative
    }

    static func == (lhs: CombatListCellViewModel, rhs: CombatListCellViewModel) -> Bool {
        return lhs.item.id == rhs.item.id
    }
}
