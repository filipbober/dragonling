//
//  CombatItemDetailView.swift
//  Dragonling
//
//  Created by Filip Bober on 2020-06-11.
//  Copyright © 2020 Filip Cyrus Bober. All rights reserved.
//

import SwiftUI

struct CombatItemDetailView: View {

    let combatItemDetailVM: CombatItemDetailViewModel

    var body: some View {
        VStack {
            Text(combatItemDetailVM.name)
            Text("This is detail view")
        }
    }
}

struct CombatItemDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CombatItemDetailView(combatItemDetailVM: CombatItemDetailViewModel(item: CombatItem(name: "Goblin")))
    }
}
