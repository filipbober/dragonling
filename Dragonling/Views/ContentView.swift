//
//  ContentView.swift
//  Dragonling
//
//  Created by Filip Bober on 2020-05-25.
//  Copyright © 2020 Filip Cyrus Bober. All rights reserved.
//

import SwiftUI

struct ContentView: View {

    @ObservedObject private var combatListVm: CombatListViewModel = CombatListViewModel()

    var body: some View {
        NavigationView {
            Form {
                CombatListView(combatListViewModel: combatListVm)
            }
        .navigationBarTitle(Text("Combat Tracker"))
        }
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
