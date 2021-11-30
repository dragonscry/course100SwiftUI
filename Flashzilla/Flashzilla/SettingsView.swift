//
//  SettingsView.swift
//  Flashzilla
//
//  Created by Denys on 30.11.2021.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var returnWrongCards: Bool
    
    var body: some View {
        
        VStack {
            Toggle("Return wrong cards?", isOn: $returnWrongCards)
                .padding()
            Button(action: {self.dismiss()}){
                Text("Done")
            }
        }
    }
    
    func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
}

//struct SettingsView_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingsView(whatIsOn: false)
//    }
//}
