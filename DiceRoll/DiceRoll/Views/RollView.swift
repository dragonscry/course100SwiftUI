//
//  RollView.swift
//  DiceRoll
//
//  Created by Denys on 08.12.2021.
//

import SwiftUI

struct DiceView: View {
    var result = 1
    var height: CGFloat
    var widht: CGFloat
    var fontSize: CGFloat
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.yellow)
                .frame(width: self.widht, height: self.height)
            Text("\(result)")
                .font(.system(size: self.fontSize))
                .foregroundColor(.white)
        }
    }
}

struct RollView: View {
    
    @Environment(\.managedObjectContext) var viewContext
    
    @State var results = [1,1,1]
    
    @Binding var numberOfEdges : Int
    @Binding var  diceCount : Int
    
    var body: some View {
        
        VStack {
            HStack {
                ForEach(0..<diceCount, id: \.self){ dice in
                    DiceView(result: results[dice], height: 100, widht: 100, fontSize: 48)
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
        for _ in 0..<3{
            tempArray.append(Int.random(in: 1...numberOfEdges))
        }
        results = tempArray
        self.saveToCoreDate()
    }
    
    func totalResult() -> Int {
        var temp = 0
        for i in 0..<diceCount {
            temp += results[i]
        }
        return temp
    }
    
    func saveToCoreDate() {
        let newResult = Result(context: viewContext)
        newResult.id = UUID()
        newResult.date = Date()
        newResult.totalResult = Int16(self.totalResult())
        for i in 0..<self.diceCount {
            let newDice = Dice(context: self.viewContext)
            newDice.id = UUID()
            newDice.diceResult = Int16(results[i])
            newDice.numberOfSides = Int16(numberOfEdges)
            newResult.addToDice(newDice)
        }
        newResult.numberOfDice = Int16(diceCount)
        do {
            try self.viewContext.save()
        } catch {
            print("Error to save in Core Datq")
        }
    }
}

//struct RollView_Previews: PreviewProvider {
//    static var previews: some View {
//        RollView()
//    }
//}
