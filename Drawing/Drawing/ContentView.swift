//
//  ContentView.swift
//  Drawing
//
//  Created by Denys on 12.09.2021.
//


struct Arrow : Shape {
    
    var amount : CGFloat = 3
    var with : CGFloat = 1.4
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        var triangle = Path()
        triangle.move(to: CGPoint(x: rect.maxX/with , y: rect.minY + rect.maxY/7))
        triangle.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        triangle.addLine(to: CGPoint(x: rect.maxX/with, y: rect.maxY - rect.maxY/7))
        triangle.addLine(to: CGPoint(x: rect.maxX/with, y: rect.minY + rect.maxY/7))

      var rect = CGRect(x: rect.minX, y: rect.minY+(rect.maxX/amount), width: rect.maxY/with, height: rect.maxX-(rect.maxX/amount)*2)
        
        path.addRect(rect)
        path.addPath(triangle)
        
        return path
    }
}


import SwiftUI

struct ContentView: View {
    
    var body: some View {
        VStack(spacing: 0){
            Arrow()
                .frame(width: 300, height: 300)
                
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
