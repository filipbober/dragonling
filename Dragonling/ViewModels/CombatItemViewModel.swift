//
//  CombatItemViewModel.swift
//  Dragonling
//
//  Created by Filip Bober on 2020-09-30.
//  Copyright © 2020 Filip Cyrus Bober. All rights reserved.
//

import Foundation

final class CombatItemViewModel: ObservableObject, Identifiable {

    @Published private(set) var item: CombatItem
    //let id = UUID()
    //@Published var name: String
    //@Published var initiative: Int = 0

    init(item: CombatItem) {
        self.item = item

        name = item.name
        initiative = item.initiative
    }

    var id: UUID {
        return item.id
    }
    
    var name: String {
        get {
            return self.item.name.capitalized
        }
        set {
            objectWillChange.send()
            item.name = newValue.capitalized
        }
    }

    var initiative: Int {
        get {
            return item.initiative
        }
        set {
            objectWillChange.send()
            item.initiative = newValue
        }
    }
}

extension CombatItemViewModel: Comparable {
    static func < (lhs: CombatItemViewModel, rhs: CombatItemViewModel) -> Bool {
        return lhs.item.initiative > rhs.item.initiative
    }
    
    static func == (lhs: CombatItemViewModel, rhs: CombatItemViewModel) -> Bool {
        return lhs.item.id == rhs.item.id
    }
}

extension CombatItemViewModel {
    static func all() -> [CombatItem] {
        return CombatItem.all()
    }
}
