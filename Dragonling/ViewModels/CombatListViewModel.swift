//
//  CombatListViewModel.swift
//  Dragonling
//
//  Created by Filip Bober on 2020-05-26.
//  Copyright © 2020 Filip Cyrus Bober. All rights reserved.
//

import Foundation

final class CombatListViewModel: ObservableObject {

    @Published var items = [CombatItemViewModel]()

    init() {
        loadItems()
    }

    func loadItems() {
        let items = CombatItem.all()
        self.items = items.map(CombatItemViewModel.init)
    }
}
