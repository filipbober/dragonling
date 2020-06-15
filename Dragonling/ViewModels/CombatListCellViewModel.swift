//
//  CombatItemViewModel.swift
//  Dragonling
//
//  Created by Filip Bober on 2020-05-26.
//  Copyright © 2020 Filip Cyrus Bober. All rights reserved.
//

import Foundation

final class CombatListCellViewModel {

    @Published var item: CombatItem
    @Published var active: Bool

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
}
