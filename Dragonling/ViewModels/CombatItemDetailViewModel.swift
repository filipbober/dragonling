//
//  CombatItemDetailViewModel.swift
//  Dragonling
//
//  Created by Filip Bober on 2020-06-11.
//  Copyright © 2020 Filip Cyrus Bober. All rights reserved.
//

import Foundation

final class CombatItemDetailViewModel: ObservableObject {

    @Published private(set) var itemVm: CombatItemViewModel

    init(itemVm: CombatItemViewModel) {
        self.itemVm = itemVm
    }

    var id: UUID {
        return itemVm.id
    }

    var name: String {
        get {
            return self.itemVm.name.capitalized
        }
        set {
            itemVm.name = newValue.capitalized
        }
    }

    var initiative: Int {
        get {
            //item.initiative += 1
            return itemVm.initiative
        }
        set {
            itemVm.initiative = newValue
        }
    }
}
