//
//  RollView.swift
//  DiceRoll
//
//  Created by Denys on 08.12.2021.
//

import SwiftUI

struct Dice: View {
    var result = 1
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.yellow)
            .frame(width: 100, height: 100)
            Text("\(result)")
                .font(.system(size: 48))
                .foregroundColor(.white)
        }
    }
}

struct RollView: View {
    var body: some View {
        
        VStack {
            Dice()
                .padding(.top, 50)
            Spacer()
            Button(action: {
                //Roll dice
            }) {
                Text("Roll Dice")
                    .font(.largeTitle)
                    .padding()
                    .foregroundColor(.white)
                    .background(.blue)
                    .clipShape(Capsule())
            }
            .padding(.bottom, 50)
            
            
        }
        .frame(maxWidth: .infinity)
    }
}

struct RollView_Previews: PreviewProvider {
    static var previews: some View {
        RollView()
    }
}
