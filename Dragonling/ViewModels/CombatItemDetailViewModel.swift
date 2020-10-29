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
    @Published var item: CombatItem

    init(itemVm: CombatItemViewModel) {
        self.itemVm = itemVm
        item = CombatItem(name: "DeleteMe")
        item.initiative = 0
    }

    var id: UUID {
        return itemVm.id
    }

    var name: String {
        get {
            return self.itemVm.name.capitalized
        }
        set {
            objectWillChange.send()
            itemVm.name = newValue.capitalized
        }
    }

    var initiative: Int {
        get {
            //item.initiative += 1
            return itemVm.initiative
        }
        set {
            objectWillChange.send()
            itemVm.initiative = newValue
        }
    }
}
