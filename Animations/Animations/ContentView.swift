//
//  ContentView.swift
//  Animations
//
//  Created by Denys on 03.09.2021.
//

import SwiftUI

struct CornerRotateModifier: ViewModifier{
    let amount: Double
    let anchor: UnitPoint
    
    func body(content: Content) -> some View {
        content.rotationEffect(.degrees(amount), anchor: anchor).clipped()
    }
}

extension AnyTransition{
    static var pivot: AnyTransition{
        .modifier(active: CornerRotateModifier(amount: -90, anchor: .topLeading), identity: CornerRotateModifier(amount: 0, anchor: .topLeading))
    }
}

struct ContentView: View {
    @State private var seconds = 0
    
    var body: some View {
        Button(action: {
            withAnimation{
                seconds += 360
            }
        }, label: {
            Rectangle().frame(width: 10, height: 100)
        })
        .rotationEffect(.degrees(Double(seconds)), anchor: .bottom)

        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
