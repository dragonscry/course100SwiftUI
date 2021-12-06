//
//  Geometry.swift
//  LayoutAndGeometry
//
//  Created by Denys on 06.12.2021.
//

import SwiftUI

struct OuterView: View {
    var body: some View {
        VStack {
            Text("Top")
            InnerView()
                .background(Color.green)
            Text("Bottom")
        }
    }
}

struct InnerView : View {
    var body: some View {
        HStack {
            Text("Left")
            GeometryReader { geo in
                Text("Center")
                    .background(.blue)
                    .position(x: geo.frame(in: .local).midX, y: geo.frame(in: .local).midY)
                    .onTapGesture {
                        print("Global center: \(geo.frame(in: .global).midX) x \(geo.frame(in: .global).midY)")
                        print("Custom Center: \(geo.frame(in: .named("Custom")).midX) x \(geo.frame(in: .named("Custom")).midY) ")
                        print("Local Center: \(geo.frame(in: .local).midX) x \(geo.frame(in: .local).midY)")
                    }
            }
            .background(.orange)
            Text("Right")
        }
    }
}

struct Geometry: View {
    var body: some View {
        OuterView()
             .background(.red)
             .coordinateSpace(name: "Custom")
    }
}

struct Geometry_Previews: PreviewProvider {
    static var previews: some View {
        Geometry()
    }
}
