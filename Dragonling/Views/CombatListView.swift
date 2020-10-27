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

    private var clickedId = UUID()

    // TODO Use @StateObject in the list instead of the @ObservableObject
    // @ObservedObject var something = SomeType() should almost always used @StateObject instead
    // create your object somewhere using @StateObject, then use it in other views with @ObservedObject

    init(combatListViewModel: CombatListViewModel) {
        self.combatListVM = combatListViewModel

        // Will refresh every time the View is rebuilt - when ObservedObject changes
        combatListVM.refreshActiveItems()
    }
//https://stackoverflow.com/questions/64526552/swiftui-how-to-update-a-variable-transiting-from-a-parent-view-only-when-wanted
    var body: some View {
        List {
            ForEach(self.combatListVM.cellVms, id:\.id) { cellVm in
                VStack {
                    // Maybe all view models should operate on CombatItem structs?
                    NavigationLink(destination: CombatItemDetailView(combatItemDetailVM: CombatItemDetailViewModel(itemVm: cellVm.itemVm/*.item*/)))
                    {
                        CombatListCell(combatListCellVM: cellVm, endTurnAction: { _ in
                            self.endTurn(for: cellVm.id)
                        }, delayAction: self.delay, useReaction: { _ in self.useReaction(for: cellVm.id) })
                        Divider()
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .onDelete(perform: self.delete)
            .onMove(perform: self.move)

            Button(action: {
                self.nextRound()
            }) {
                Text("Next round")
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

    private func endTurn(for id: UUID) {
        self.combatListVM.endTurn(for: id)
    }

    private func delay() {
        self.combatListVM.delay()
    }

    private func useReaction(for id: UUID) {
        self.combatListVM.useReaction(for: id)
    }

    private func nextRound() {
        self.combatListVM.nextRound()
    }

}

struct CombatListView_Previews: PreviewProvider {
    static var previews: some View {
        CombatListView(combatListViewModel: CombatListViewModel())
    }
}
