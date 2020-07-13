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

        // done - Add 'activated' field to Entity to track if it has moved already this turn

        // Add 'wait' along with End Turn button - wait changes to end turn when all
        // other entities moved

        // scroll to current element or next turn if all have been activated
        // mark activated items with separate color

        // move functions in views to extension - to better separate?

        // done - BUG - why doesnt update and refresh work in the same function?

        // WAIT
        // postpones an action until trigger fires
        // burns a reaction - store it in the model
        // store if reaction is ready on combat tracker

        // Separate row for current statuses, bonus actions, reactions

        // Reactions
        // additional button?
        // SF Icon indicating if it was used but set in details?
        // Button instead of initiative, initiative -> move to details

        // SF Symbols
        // visualize with system icon 'waiting', 'done'
        // hourglass, checkmark
        // visualize when reaction is used
        // Visualize item status
        // List of statuses: poisoned, prone etc. [Pro version]

        // Refactor self.
        // Use self. only in closures and when necessary (properties)
        // instead of making it a useless noise

        // Initiative
        // Sort by initiative if there is one set
        // Otherwise initial initiative is nil and order is used
        // any initiative that is set comes before order without initiative
        //  but can be later moved manually (order)
        // Use picker in DetailsView - from -10 or -5 to +40
        // Set default picker value to 10 (usually it's 10+ something)

        // Round > Turn
        // Each character has one Turn in a Round
        // When all characters moved in combat the Round Ends
        // Fix naming

        // Scrolling
        // EndTurn -> Scroll to the next item if out of view (remember about delaying)
        // EndRound -> Scroll to the top

        // Haptic Feedback
        // Use one bump for EndTurn
        // Use two bumps for EndRound

        // Reaction & Bonus Action
        // Display icon in the list whether reaction is ready or used
        // Display icon in the list whether bonus action is ready or used
        // Consider separate buttons in the list (maybe for active
        // and delaying only?)
        // Bonus action not needed - check if bonus action is ALWAYS
        //  used as part of an action

        // Expand current item (active) and delaying
        // Provide Bonus Action / Reaction buttons like
        // Use reaction (isDelayin already used this)
        // Use bonus action
        // Provide icon for each
        // Small status icons under item name
        //  details view provies legend for those
        //  poison icon in the list; poison icon with 'poisoned' in details

        // Implement ads
        // Custom View for Buttons and other reusable view components
        // Languages: English, Polish, German?, Danish?
        // Settings -> Restore Purchases
        // Dark Mode / Light Mode?

        // Monster portrait on the left


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
