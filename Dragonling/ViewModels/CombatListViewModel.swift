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

    func add() {
        items.append(CombatItemViewModel(item: CombatItem(name: "New monster")))
    }

    func move(from source: IndexSet, to destination: Int) {
        items.move(fromOffsets: source, toOffset: destination)
    }

    func remove(at offsets: IndexSet) {
        if let first = offsets.first {
            self.items.remove(at: first)
        }
    }

    func loadItems() {
        let items = CombatItem.all()
        self.items = items.map(CombatItemViewModel.init)
    }
}
