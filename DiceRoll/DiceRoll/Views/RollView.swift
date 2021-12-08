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
    
    @State var results = [1,1,1]
    
    @State var diceCount = 3
    
    var body: some View {
        
        VStack {
            HStack {
                ForEach(0..<diceCount){ dice in
                    Dice(result: results[dice])
                }
            }
            
            Text("Total result is \(totalResult())")
            
            Spacer()
            Button(action: {
                rollDice()
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
    
    func rollDice() {
        var tempArray = [Int]()
        for _ in 0..<diceCount {
            tempArray.append(Int.random(in: 1...6))
        }
        results = tempArray
    }
    
    func totalResult() -> Int {
        return self.results.reduce(0, +)
    }
}

struct RollView_Previews: PreviewProvider {
    static var previews: some View {
        RollView()
    }
}
