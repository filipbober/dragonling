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

    var body: some View {
        Text(combatListCellVM.name)
    }
}

struct CombatListCell_Previews: PreviewProvider {
    static var previews: some View {
        CombatListCell(combatListCellVM: CombatListCellViewModel(item: CombatItem(name: "Test name")))
            .previewLayout(.sizeThatFits)
    }
}
