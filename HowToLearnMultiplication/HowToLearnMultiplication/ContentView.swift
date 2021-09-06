//
//  ContentView.swift
//  HowToLearnMultiplication
//
//  Created by Denys on 06.09.2021.
//

import SwiftUI

struct ContentView: View {
    
    @State private var upTo = 2
    @State private var startGame = false
    @State private var endGame = false
    
    @State private var answer = ""
    @State private var answerStep = 0
    
    let possibleMultiplications = Array(1...12)
    @State var questions = [(Int,Int)]()
    
    @State private var score = 0
    
    @State private var questionNumber = 0
    @State private var questionCount = ["5","10","20","all"]
    private var howManyQuestions : Int {
        if let quest = Int(questionCount[questionNumber]){
            return quest
        }
        else {
            return 12 * upTo
        }
        
    }
    
    
    var body: some View {
        VStack{
            if !startGame {
                Group {
                    Stepper(value: $upTo, in: 2...12, step: 1){
                        Text("From 1 to \(upTo) will be shown")
                    }
                    .padding(10)
                    Picker(selection: $questionNumber, label: Text("How many question will be"), content: {
                        ForEach(0..<questionCount.count){num in
                            Text("\(questionCount[num])")
                        }
                    }).pickerStyle(SegmentedPickerStyle())
                }
            }
            
            if startGame {
                VStack{
                    QuestionView(first: questions[answerStep].0, second: questions[answerStep].1)
                }.transition(AnyTransition.opacity.combined(with: .slide))
                
            }
            
            
            
            
            Spacer()
            TextField("Print correct ansert", text: $answer, onCommit: {withAnimation{incrementAnswer()}})
                .padding().textFieldStyle(RoundedBorderTextFieldStyle()).keyboardType(.numberPad)
            HStack{
                if !startGame {
                    Button(action: {withAnimation{starts()}}, label: {
                        Text("Start")
                    })
                    .padding().foregroundColor(.white).background(Color(#colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1))).cornerRadius(10)
                }
                if startGame {
                    Button(action: {withAnimation{end()}}, label: {
                        Text("End")
                    })
                    .padding().foregroundColor(.white).background(Color(#colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1))).cornerRadius(10)
                }
            }
            .padding(.horizontal)
            Text("Score is \(score)")
        }.alert(isPresented: $endGame, content: {
            Alert(title: Text("Game is finished"), message: Text("Your score is \(score)"), dismissButton: .default(Text("Ok")))
        })
    }
    func starts() {
        questions = createDict(num: upTo)
        startGame = true
        score = 0
    }
    func end() {
        startGame = false
        endGame = true
        answerStep = 0
    }
    
    func createDict(num:Int)->[(Int,Int)]{
        var dict = [Int:[Int]]()
        for i in 1...num {
            dict[i] = possibleMultiplications
        }
        var array = [(Int,Int)]()
        var howManyQuestions = 0
        if let quest = Int(questionCount[questionNumber]){
            howManyQuestions = quest
        }
        else {
            howManyQuestions = 12 * upTo
        }
        while array.count < howManyQuestions {
            let first = Int.random(in: 1...num)
            guard dict[first] != [] else {continue}
            let second = dict[first]!.remove(at: Int.random(in: 0..<dict[first]!.count))
            array.append((first,second))
        }
        return array
    }
    
    func incrementAnswer(){
        if let answ = Int(answer){
            if answ == questions[answerStep].0 * questions[answerStep].1{
                score += 1
            }
        }
        if answerStep < howManyQuestions-1{
            answerStep += 1
        }
        else {
            end()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
