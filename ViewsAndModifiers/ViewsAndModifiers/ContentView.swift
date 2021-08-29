//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Denys on 26.08.2021.
//

import SwiftUI

struct BlueTitle: ViewModifier{
    
    var text : String
    
    func body(content: Content) -> some View {
        ZStack(alignment: .top){
            content
            Text(text).font(.largeTitle).foregroundColor(.blue).padding()
        }
    }
}

extension View {
    func blueTitle(with text:String) -> some View {
        self.modifier(BlueTitle(text: text))
    }
}

struct ContentView: View {
    
    var body: some View {
        Text("Hello").frame(width: 300, height: 200, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).background(Color(#colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1))).cornerRadius(30).blueTitle(with: "Title")
        }
    }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
