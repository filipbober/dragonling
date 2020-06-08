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

        ZStack(alignment: .top) {

            NavigationView {
                Form {
                    CombatListView(combatListViewModel: combatListVM)
                }
                .navigationBarTitle(Text("Combat Tracker"))
                .navigationBarItems(leading: addButton, trailing: EditButton())
                .environment(\.editMode, $editMode)
            }
            VStack {
                editTitle
            }
        }
    }

    private var editTitle: some View {
        Group {
            if editMode == .active {
                Text("Edit")
                    .font(.headline)
                    .padding()
            }
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
