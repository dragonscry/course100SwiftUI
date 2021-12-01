//
//  ContentView.swift
//  LayoutAndGeometry
//
//  Created by Denys on 01.12.2021.
//

import SwiftUI

extension VerticalAlignment {
    struct MidAccountAndName : AlignmentID {
        static func defaultValue(in d: ViewDimensions) -> CGFloat {
            d[.top]
        }
    }
    
    static let midAccountAndName = VerticalAlignment(MidAccountAndName.self)
}

struct ContentView: View {
    var body: some View {
        HStack(alignment: .midAccountAndName) {
            VStack{
                Text("@dmrktn")
                    .alignmentGuide(.midAccountAndName) {
                        d in
                        d[VerticalAlignment.center]
                    }
                Image(systemName: "gear")
                    .font(.system(size: 64))
                
            }
            VStack {
                Text("Full name:")
                Text("DENYS MERKOTUN")
                    .alignmentGuide(.midAccountAndName) {
                        d in
                        d[VerticalAlignment.center]
                    }
                    .font(.largeTitle)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
