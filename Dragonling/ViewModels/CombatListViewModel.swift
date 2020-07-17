//
//  CombatListViewModel.swift
//  Dragonling
//
//  Created by Filip Bober on 2020-05-26.
//  Copyright © 2020 Filip Cyrus Bober. All rights reserved.
//

import Foundation

final class CombatListViewModel: ObservableObject {

    @Published var currentRound: Int = 1
    @Published var currentEntityId: UUID?
    // Should this be private?
    // Array of [CombatItem]
    @Published private(set) var items = [CombatListCellViewModel]()

    private var currentItemIndex = 0

    init() {
        loadItems()
        updateCurrentItem()
    }

    func add() {
        items.append(CombatListCellViewModel(item: CombatItem(name: "New monster"), active: false))

        updateCurrentItem()
    }

    func move(from source: IndexSet, to destination: Int) {
        items.move(fromOffsets: source, toOffset: destination)

        updateCurrentItem()
    }

    func remove(at offsets: IndexSet) {
        if let first = offsets.first {
            self.items.remove(at: first)
        }

        updateCurrentItem()
    }

    func updateCurrentItem() {
        // Current item is first active and not waiting from the list
        for (index, item) in self.items.enumerated() {
            if !item.hasActivated && !item.isDelaying {
                currentItemIndex = index
                break
            }
        }

        if (items.count > 0) {
            currentEntityId = items[currentItemIndex].id
        } else {
            currentEntityId = nil
        }

        refreshActiveItems()
    }

    func refreshActiveItems() {
        // If all entities had action disable active and wait till end round is pressed
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

    func endTurn(for id: UUID) {
        let index = self.items.firstIndex { $0.id == id }

        guard let unwrappedIndex = index else {
            return
        }

        self.items[unwrappedIndex].hasActivated = true
        self.currentItemIndex = unwrappedIndex

        updateCurrentItem()
    }

    func delay() {
        self.items[self.currentItemIndex].isDelaying = true

        if let firstActiveItemIndex = items.firstIndex(where: { !$0.hasActivated && !$0.isDelaying }) {
            currentItemIndex = firstActiveItemIndex
        }

        updateCurrentItem()
    }

    func useReaction(for id: UUID) {
        let index = self.items.firstIndex { $0.id == id }

        guard let unwrappedIndex = index else {
            return
        }

        self.items[unwrappedIndex].usedReaction = true

        updateCurrentItem()
    }

    func nextRound() {
        self.currentRound += 1

        // Reset activated
        for item in items {
            item.hasActivated = false
            item.isDelaying = false
            item.usedReaction = false
        }

        updateCurrentItem()
    }

    func sortItemsByInitiative() {
        self.items = self.items.sorted()

        updateCurrentItem()
    }

    func loadItems() {
        self.currentRound = 1

        // Load example items
        let items = CombatItem.all()

        self.items = items.map() { CombatListCellViewModel.init(item: $0, active: false) }

        // Set some values to initiative
        var currentInitiative = 1
        self.items.forEach {
            $0.initiative = currentInitiative
            currentInitiative += 1
        }
        // Make one first and last item have the same initiative - for testing purposes
        self.items[self.items.count - 1].initiative = 1

        // Set current turn to the first item - the one with highest initiative
        sortItemsByInitiative()
    }
}
