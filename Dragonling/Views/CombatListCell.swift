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
            if showEndTurn() {
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
            if !combatListCellVM.hasActivated {
                if !combatListCellVM.isDelaying && combatListCellVM.active {
                    Button(action: delayAction) {
                        Text("Delay")
                    }
                    .accentColor(.blue)
                    .buttonStyle(BorderlessButtonStyle())
                }
                else if combatListCellVM.isDelaying && !combatListCellVM.hasActivated {
                    Text("Waiting")
                }
            }
        }
    }
    
    private func showEndTurn() -> Bool {
        if combatListCellVM.hasActivated {
            return false
        } else if combatListCellVM.active {
            return true
        } else if combatListCellVM.isDelaying {
            return true
        } else {
            return false
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
