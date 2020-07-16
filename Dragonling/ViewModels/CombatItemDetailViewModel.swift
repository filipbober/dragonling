//
//  CombatItemDetailViewModel.swift
//  Dragonling
//
//  Created by Filip Bober on 2020-06-11.
//  Copyright © 2020 Filip Cyrus Bober. All rights reserved.
//

import Foundation

final class CombatItemDetailViewModel: ObservableObject {

    @Published private(set) var item: CombatItem

    init(item: CombatItem) {
        self.item = item
    }

    var id: UUID {
        return item.id
    }

    var name: String {
        get {
            return self.item.name.capitalized
        }
        set {
            item.name = newValue.capitalized
        }
    }

    var initiative: Int {
        get {
            //item.initiative += 1
            return item.initiative
        }
        set {
            item.initiative = newValue
        }
    }
}
