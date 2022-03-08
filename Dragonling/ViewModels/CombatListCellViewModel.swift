//
//  CombatItemViewModel.swift
//  Dragonling
//
//  Created by Filip Bober on 2020-05-26.
//  Copyright © 2020 Filip Cyrus Bober. All rights reserved.
//

import Foundation

final class CombatListCellViewModel: ObservableObject {
    
    @Published private(set) var itemVm: CombatItemViewModel
    @Published var active: Bool
    @Published var hasActivated: Bool = false
    @Published var isDelaying: Bool = false
    @Published var usedReaction: Bool = false
    
    init(itemVm: CombatItemViewModel, active: Bool) {
        self.itemVm = itemVm
        self.active = active
    }
    
    var id: UUID {
        return itemVm.id
    }
    
    var name: String {
        return self.itemVm.name.capitalized
    }
    
    var initiative: Int {
        set {
            objectWillChange.send()
            itemVm.initiative = newValue
        }
        get {
            return self.itemVm.initiative
        }
    }
}

extension CombatListCellViewModel: Comparable {
    static func < (lhs: CombatListCellViewModel, rhs: CombatListCellViewModel) -> Bool {
        return lhs.itemVm > rhs.itemVm
    }
    
    static func == (lhs: CombatListCellViewModel, rhs: CombatListCellViewModel) -> Bool {
        return lhs.itemVm == rhs.itemVm
    }
}
