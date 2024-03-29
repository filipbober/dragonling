//
//  CombatItemDetailView.swift
//  Dragonling
//
//  Created by Filip Bober on 2020-06-11.
//  Copyright © 2020 Filip Cyrus Bober. All rights reserved.
//

import SwiftUI

struct CombatItemDetailView: View {
    
    @ObservedObject var combatItemDetailVM: CombatItemDetailViewModel
    @State private var editMode = EditMode.inactive
    @Binding var needRefresh: Bool
    
    var body: some View {
        ZStack {
            VStack {
                Text(combatItemDetailVM.name)
                Text(combatItemDetailVM.itemVm.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                name
                //https://applandeo.com/blog/swiftui-two-way-binding-and-more/
                Button(action: {
                    self.combatItemDetailVM.initiative += 1
                    self.needRefresh = true
                }) {
                    Text("Rename")
                }
                
                Text("initiative: \(self.combatItemDetailVM.initiative)")
                Text("itemId: \(combatItemDetailVM.itemVm.id)")
                
                Spacer()
                
                Text("This is detail view")
                Spacer()
            }
        }
        .navigationBarItems(trailing: EditButton())
        .environment(\.editMode, $editMode)
    }
    
    var name : some View {
        Group {
            if editMode == .active {
                Text("Edit mod")
                TextField(combatItemDetailVM.name, text: $combatItemDetailVM.name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(10)
            } else {
                Text(combatItemDetailVM.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
            }
        }
    }
}

struct CombatItemDetailView_Previews: PreviewProvider {
    @State static var refresh: Bool = false
    static var previews: some View {
        NavigationView {
            CombatItemDetailView(combatItemDetailVM: CombatItemDetailViewModel(itemVm: CombatItemViewModel(item: CombatItem(name: "Goblin"))), needRefresh: $refresh)
        }
    }
}
