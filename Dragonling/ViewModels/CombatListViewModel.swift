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
    @Published private(set) var cellVms = [CombatListCellViewModel]()
    
    private var currentItemIndex = 0
    
    init() {
        loadItems()
        updateCurrentItem()
    }
    
    func add() {
        cellVms.append(CombatListCellViewModel(itemVm: CombatItemViewModel(item: CombatItem(name: "New monster")), active: false))
        
        updateCurrentItem()
    }
    
    func move(from source: IndexSet, to destination: Int) {
        cellVms.move(fromOffsets: source, toOffset: destination)
        
        updateCurrentItem()
    }
    
    func remove(at offsets: IndexSet) {
        if let first = offsets.first {
            self.cellVms.remove(at: first)
        }
        
        updateCurrentItem()
    }
    
    func updateCurrentItem() {
        // Current item is first active and not waiting from the list
        for (index, item) in self.cellVms.enumerated() {
            if !item.hasActivated && !item.isDelaying {
                currentItemIndex = index
                break
            }
        }
        
        if (cellVms.count > 0) {
            currentEntityId = cellVms[currentItemIndex].id
        } else {
            currentEntityId = nil
        }
        
        refreshActiveItems()
    }
    
    func refreshActiveItems() {
        // If all entities had action disable active and wait till end round is pressed
        if allActivated() {
            for item in self.cellVms {
                item.active = false
            }
        } else {
            for item in self.cellVms {
                item.active = self.currentEntityId == item.id ? true : false
            }
        }
    }
    
    func allActivated() -> Bool {
        for item in cellVms {
            if !item.hasActivated {
                return false
            }
        }
        
        return true
    }
    
    func endTurn(for id: UUID) {
        let index = self.cellVms.firstIndex { $0.id == id }
        
        guard let unwrappedIndex = index else {
            return
        }
        
        self.cellVms[unwrappedIndex].hasActivated = true
        self.currentItemIndex = unwrappedIndex
        
        updateCurrentItem()
    }
    
    func delay() {
        self.cellVms[self.currentItemIndex].isDelaying = true
        
        if let firstActiveItemIndex = cellVms.firstIndex(where: { !$0.hasActivated && !$0.isDelaying }) {
            currentItemIndex = firstActiveItemIndex
        }
        
        updateCurrentItem()
    }
    
    func useReaction(for id: UUID) {
        let index = self.cellVms.firstIndex { $0.id == id }
        
        guard let unwrappedIndex = index else {
            return
        }
        
        self.cellVms[unwrappedIndex].usedReaction = true
        
        updateCurrentItem()
    }
    
    func nextRound() {
        self.currentRound += 1
        
        // Reset activated
        for item in cellVms {
            item.hasActivated = false
            item.isDelaying = false
            item.usedReaction = false
        }
        
        updateCurrentItem()
    }
    
    func sortItemsByInitiative() {
        self.cellVms = self.cellVms.sorted()
        
        updateCurrentItem()
    }
    
    func loadItems() {
        self.currentRound = 1
        
        // Load example items
        let items = CombatItem.all()
        
        self.cellVms = items.map() { CombatListCellViewModel.init(itemVm: CombatItemViewModel(item: $0), active: false) }
        
        // Set some values to initiative
        var currentInitiative = 1
        self.cellVms.forEach {
            $0.initiative = currentInitiative
            currentInitiative += 1
        }
        // Make one first and last item have the same initiative - for testing purposes
        self.cellVms[self.cellVms.count - 1].initiative = 1
        
        // Set current turn to the first item - the one with highest initiative
        sortItemsByInitiative()
    }
}
