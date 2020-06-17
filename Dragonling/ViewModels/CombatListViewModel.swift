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

    //private var currentEntityId: UUID?
    private var currentItemIndex = 0

    init() {
        loadItems()
        updateCurrentItem()
        refreshActiveItems()
    }

    func add() {
        items.append(CombatListCellViewModel(item: CombatItem(name: "New monster"), active: false))

        updateCurrentItem()
        refreshActiveItems()
    }

    func move(from source: IndexSet, to destination: Int) {
        items.move(fromOffsets: source, toOffset: destination)

        updateCurrentItem()
        refreshActiveItems()
    }

    func remove(at offsets: IndexSet) {
        if let first = offsets.first {
            self.items.remove(at: first)
        }

        updateCurrentItem()
        refreshActiveItems()
    }

    func updateCurrentItem() {
        // Current item is first active and not waiting from the list
        var index = 0
        for item in self.items {
            if !item.hasActivated {
                currentItemIndex = index
                break
            }
            
            index += 1
        }

        if (items.count > 0) {
            currentEntityId = items[currentItemIndex].id
        } else {
            currentEntityId = nil
        }
    }

    func refreshActiveItems() {
        // If all entities had action disable active and wait till end turn is pressed
        if allActivated() {
            for item in self.items {
                item.active = false
            }
        } else {
            for item in self.items {
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

        updateCurrentItem()
        refreshActiveItems()
    }

    func nextTurn() {
        self.currentTurn += 1

        // Reset activated
        for item in items {
            item.hasActivated = false
        }

        updateCurrentItem()
        refreshActiveItems()
    }

    func sortItemsByInitiative() {
        self.items = self.items.sorted()
        updateCurrentItem()
    }

    func loadItems() {
        self.currentTurn = 1

        // Load example items
        let items = CombatItem.all()

        self.items = items.map() { CombatListCellViewModel.init(item: $0, active: false) }

        // Set some values to initiative
        var currentInitiative = 1
        self.items.forEach {
            $0.item.initiative = currentInitiative
            currentInitiative += 1
        }
        // Make one first and last item have the same initiative - for testing purposes
        self.items[self.items.count - 1].item.initiative = 1


        // Set current turn to the first item - the one with highest initiative
        sortItemsByInitiative()
    }
}
