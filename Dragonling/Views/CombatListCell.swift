//
//  CombatListCell.swift
//  Dragonling
//
//  Created by Filip Bober on 2020-06-1.
//  Copyright © 2020 Filip Cyrus Bober. All rights reserved.
//

import SwiftUI

struct CombatListCell: View {

    let combatListCellVM: CombatListCellViewModel
    let endTurnAction: (UUID) -> Void
    let delayAction: () -> Void

    var body: some View {
        VStack(alignment: .leading) {
            Text(combatListCellVM.name)
            Text("Activated: \(String(combatListCellVM.hasActivated))")
            Text("Delaying: \(String(combatListCellVM.isDelaying))")
            HStack {
                EndTurnButton
                Spacer()
                DelayButton
                Spacer()
                Text("Initiative: \(combatListCellVM.item.initiative)")
            }
        }
    }

    var EndTurnButton: some View {
        Group {
            if self.combatListCellVM.active {
                Button(action: { self.endTurnAction(self.combatListCellVM.id) }) {
                    Text("End turn")
                }
                .accentColor(.blue)
                .buttonStyle(BorderlessButtonStyle())
            }
        }
    }

    var DelayButton: some View {
        Group {
            if !self.combatListCellVM.isDelaying && self.combatListCellVM.active {
                Button(action: self.delayAction) {
                    Text("Delay")
                }
                .accentColor(.blue)
                .buttonStyle(BorderlessButtonStyle())
            }
            else if self.combatListCellVM.isDelaying && combatListCellVM.active {
                Text("Waiting")
            }
        }
    }

}

struct CombatListCell_Previews: PreviewProvider {
    static var previews: some View {
        CombatListCell(combatListCellVM: CombatListCellViewModel(item: CombatItem(name: "Test name"), active: true), endTurnAction: {_ in },
                       delayAction: {})
            .previewLayout(.sizeThatFits)
    }
}
