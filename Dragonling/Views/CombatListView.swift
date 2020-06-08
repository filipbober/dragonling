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
                    CombatListCell(combatItemViewModel: item)
                }
            }
            .onDelete(perform: delete)
            .onMove(perform: move)
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

}

struct CombatListView_Previews: PreviewProvider {
    static var previews: some View {
        CombatListView(combatListViewModel: CombatListViewModel())
    }
}
