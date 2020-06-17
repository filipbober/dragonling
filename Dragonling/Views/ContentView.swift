//
//  ContentView.swift
//  Dragonling
//
//  Created by Filip Bober on 2020-05-25.
//  Copyright © 2020 Filip Cyrus Bober. All rights reserved.
//

import SwiftUI

struct ContentView: View {

    @ObservedObject private var combatListVM: CombatListViewModel = CombatListViewModel()
    @State private var editMode = EditMode.inactive
    
    var body: some View {

        // done - Add 'End turn' button under current item
        // done -  Disable Next Turn button until all entities ended turn
        // track order in the list - highlight current item
        // should work after Edit -> Move reordered items
        //      highest initiative should be highlighted
        // Make 'Current Turn' sticky at the top

        // Add 'activated' field to Entity to track if it has moved already this turn

        // Add 'wait' along with End Turn button - wait changes to end turn when all
        // other entities moved

        // scroll to current element or next turn if all have been activated
        // mark activated items with separate color

        // move functions in views to extension - to better separate?

        NavigationView {
            Form {
                Text("Current turn: \(combatListVM.currentTurn)")
                CombatListView(combatListViewModel: combatListVM)
            }
            .navigationBarTitle(Text("Combat Tracker"))
            .navigationBarItems(leading: addButton, trailing: EditButton())
            .environment(\.editMode, $editMode)
        }
    }

    private var addButton: some View {
        // Better performance than embedding in AnyView
        Group {
            if editMode == .active {
                Button(action: onAdd) { Image(systemName: "plus") }
            }
        }
    }

    private func onAdd() {
        combatListVM.add()
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()

            ContentView()
                .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
                .previewDisplayName("iPhone 8")

            ContentView()
                .previewDevice(PreviewDevice(rawValue: "iPhone XS Max"))
                .previewDisplayName("iPhone XS Max")
                .environment(\.colorScheme, .dark)
        }
    }
}
