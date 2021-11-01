//
//  CircleView.swift
//  PhotoWithName
//
//  Created by Denys on 01.11.2021.
//

import SwiftUI

struct CircleView: View {
    var body: some View {
        Circle()
            .fill(Color.green)
            .opacity(0.3)
            .frame(width: 30, height: 30)
    }
}

struct CircleView_Previews: PreviewProvider {
    static var previews: some View {
        CircleView()
    }
}
