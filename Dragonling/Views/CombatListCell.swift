//
//  CombatListCell.swift
//  Dragonling
//
//  Created by Filip Bober on 2020-06-1.
//  Copyright © 2020 Filip Cyrus Bober. All rights reserved.
//

import SwiftUI

struct CombatListCell: View {

    let combatItemViewModel: CombatItemViewModel

    var body: some View {
        Text(combatItemViewModel.name)
    }
}

struct CombatListCell_Previews: PreviewProvider {
    static var previews: some View {
        CombatListCell(combatItemViewModel: CombatItemViewModel(item: CombatItem(name: "Test name")))
            .previewLayout(.sizeThatFits)
    }
}
