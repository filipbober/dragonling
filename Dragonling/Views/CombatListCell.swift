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
    let useReaction: (UUID) -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(combatListCellVM.name)
            Text("Activated: \(String(combatListCellVM.hasActivated))")
            Text("Delaying: \(String(combatListCellVM.isDelaying))")
            Text("Initiative: \(combatListCellVM.item.initiative)")
            HStack {
                endTurnButton
                Spacer()
                delayButton
                Spacer()
                reactionButton
            }
        }
    }
    
    var endTurnButton: some View {
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
    
    var delayButton: some View {
        Group {
            if !combatListCellVM.hasActivated {
                if !combatListCellVM.isDelaying && combatListCellVM.active {
                    Button(action: delayAction) {
                        HStack {
                            Text("Delay")
                            Image(systemName: "hourglass")
                        }
                    }
                    .accentColor(.blue)
                    .buttonStyle(BorderlessButtonStyle())
                }
                else if combatListCellVM.isDelaying && !combatListCellVM.hasActivated {
                    HStack {
                        Text("Waiting")
                        Image(systemName: "hourglass.tophalf.fill")
                    }
                }
            }
        }
    }

    var reactionButton: some View {
        Group {
            if !combatListCellVM.usedReaction {
                Button(action: { self.useReaction(self.combatListCellVM.id) }) {
                    Text("Reaction")
                }
                .accentColor(.blue)
                .buttonStyle(BorderlessButtonStyle())
            } else {
                Text("Reacted")
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
        CombatListCell(combatListCellVM: CombatListCellViewModel(item: CombatItem(name: "Test name"), active: true), endTurnAction: { _ in },
                       delayAction: {}, useReaction: { _ in })
            .previewLayout(.sizeThatFits)
    }
}
