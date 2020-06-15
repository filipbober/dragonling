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
    @State var active: Bool

    var body: some View {
        VStack(alignment: .leading) {
            Text(combatListCellVM.name)
            EndTurnButton
        }
    }

    var EndTurnButton: some View {
        Group {
            if active {
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                    Text("End turn")
                }
                .foregroundColor(.blue)
            }
        }
    }

}

struct CombatListCell_Previews: PreviewProvider {
    static var previews: some View {
        CombatListCell(combatListCellVM: CombatListCellViewModel(item: CombatItem(name: "Test name")), active: true)
            .previewLayout(.sizeThatFits)
    }
}
