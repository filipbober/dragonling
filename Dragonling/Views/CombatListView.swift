//
//  CombatListView.swift
//  Dragonling
//
//  Created by Filip Bober on 2020-05-27.
//  Copyright © 2020 Filip Cyrus Bober. All rights reserved.
//

import SwiftUI

struct CombatListView: View {

    let combatListVM: CombatListViewModel

    init(combatListViewModel: CombatListViewModel) {
        self.combatListVM = combatListViewModel
    }

    var body: some View {
        List {
            ForEach(self.combatListVM.items, id:\.id) { item in
                VStack {
                    Text(item.name)
                }
            }
        }
    }
}

struct CombatListView_Previews: PreviewProvider {
    static var previews: some View {
        CombatListView(combatListViewModel: CombatListViewModel())
    }
}
