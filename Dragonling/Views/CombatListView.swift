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

        // Will refresh every time the View is rebuilt - when ObservedObject changes
        combatListVM.refreshActiveItems()
    }

    var body: some View {
        List {
            ForEach(self.combatListVM.items, id:\.id) { item in
                VStack {
                    NavigationLink(destination: CombatItemDetailView(combatItemDetailVM: CombatItemDetailViewModel(item: item.item)))
                    {
                        CombatListCell(combatListCellVM: item, endTurnAction: self.endTurn, delayAction: self.delay)
                    }
                }
            }
            .onDelete(perform: delete)
            .onMove(perform: move)

            Button(action: {
                self.nextTurn()
            }) {
                Text("Next turn")
                    .accentColor(.blue)
            }
            .disabled(!self.combatListVM.allActivated())
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

    private func endTurn() {
        self.combatListVM.endTurn()
    }

    private func delay() {
        self.combatListVM.delay()
    }

    private func nextTurn() {
        self.combatListVM.nextTurn()
    }

}

struct CombatListView_Previews: PreviewProvider {
    static var previews: some View {
        CombatListView(combatListViewModel: CombatListViewModel())
    }
}
