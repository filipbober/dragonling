//
//  CombatItemViewModel.swift
//  Dragonling
//
//  Created by Filip Bober on 2020-05-26.
//  Copyright © 2020 Filip Cyrus Bober. All rights reserved.
//

import Foundation

final class CombatListCellViewModel {

    let item: CombatItem

    init(item: CombatItem) {
        self.item = item
    }

    var id: UUID {
        return item.id
    }

    var name: String {
        return self.item.name.capitalized
    }
}
