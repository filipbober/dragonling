//
//  CombatListViewModel.swift
//  Dragonling
//
//  Created by Filip Bober on 2020-05-26.
//  Copyright © 2020 Filip Cyrus Bober. All rights reserved.
//

import Foundation

final class CombatListViewModel: ObservableObject {

    @Published var currentTurn: Int = 1
    @Published var currentEntityId: UUID?
    @Published var items = [CombatListCellViewModel]()

    private var currentItemIndex = 0

    init() {
        loadItems()
    }

    func add() {
        items.append(CombatListCellViewModel(item: CombatItem(name: "New monster"), active: false))
    }

    func move(from source: IndexSet, to destination: Int) {
        items.move(fromOffsets: source, toOffset: destination)
    }

    func remove(at offsets: IndexSet) {
        if let first = offsets.first {
            self.items.remove(at: first)
        }
    }

    func refreshActiveItems() {
        // If all entities had action disable active and wait till end turn is pressed
        if allActivated() {
            for item in items {
                item.active = false
            }
        } else {
            for item in items {
                item.active = self.currentEntityId == item.id ? true : false
            }
        }
    }

    func allActivated() -> Bool {
        for item in items {
            if !item.hasActivated {
                return false
            }
        }

        return true
    }

    func endTurn() {
        self.items[self.currentItemIndex].hasActivated = true

        self.currentItemIndex += 1
        if self.currentItemIndex >= self.items.count {
            self.currentItemIndex = 0
        }

        self.currentEntityId = self.items[self.currentItemIndex].id
    }

    func nextTurn() {
        self.currentTurn += 1

        // Reset activated
        for item in items {
            item.hasActivated = false
        }
    }

    func loadItems() {
        self.currentTurn = 1

        // Load example items
        let items = CombatItem.all()

        // Set current turn to the first item
        currentEntityId = items.first?.id
        
        self.items = items.map() { CombatListCellViewModel.init(item: $0, active: $0.id == currentEntityId) }
    }
}
