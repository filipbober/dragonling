//
//  CombatListView.swift
//  Dragonling
//
//  Created by Filip Bober on 2020-05-27.
//  Copyright © 2020 Filip Cyrus Bober. All rights reserved.
//

import SwiftUI

struct CombatListView: View {

    @ObservedObject var combatListVM: CombatListViewModel

    init(combatListViewModel: CombatListViewModel) {
        self.combatListVM = combatListViewModel
    }

    var body: some View {
        List {
            ForEach(self.combatListVM.items, id:\.id) { item in
                VStack {
                    NavigationLink(destination: CombatItemDetailView(combatItemDetailVM: CombatItemDetailViewModel(item: item.item)))
                    {
                        self.createCombatListCell(for: item)
                        //CombatListCell(combatListCellVM: item)
                    }
                }
            }
            .onDelete(perform: delete)
            .onMove(perform: move)

            Button(action: {
                self.combatListVM.currentTurn += 1
            }) {
                Text("Next turn")
                    .foregroundColor(.blue)
            }
        }
    }

    private func delete(at offsets: IndexSet) {
        self.combatListVM.remove(at: offsets)
    }

    private func move(from source: IndexSet, to destination: Int) {
        self.combatListVM.move(from: source, to: destination)
    }

    private func add() {
        self.combatListVM.add()
    }

    private func createCombatListCell(for item: CombatListCellViewModel) -> some View  {

        item.active = combatListVM.currentEntityId == item.id ? true : false
        return CombatListCell(combatListCellVM: item, endTurnAction: endTurn)

//        if self.combatListVM.currentEntityId == item.id {
//            item.active = true
//            return CombatListCell(combatListCellVM: item)
//        } else {
//            item.active = false
//            return CombatListCell(combatListCellVM: item)
//        }
    }

    private func endTurn() {
        combatListVM.currentItemIndex += 1
        if combatListVM.currentItemIndex >= combatListVM.items.count {
            combatListVM.currentItemIndex = 0
        }

        combatListVM.currentEntityId = combatListVM.items[combatListVM.currentItemIndex].id
    }

    private func nextTurn() {

    }

}

struct CombatListView_Previews: PreviewProvider {
    static var previews: some View {
        CombatListView(combatListViewModel: CombatListViewModel())
    }
}
