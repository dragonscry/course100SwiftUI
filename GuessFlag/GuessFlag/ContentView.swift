//
//  ContentView.swift
//  GuessFlag
//
//  Created by Denys on 29.08.2021.
//

import SwiftUI

struct FlagImage : View {
    
    var image:String
    
    var body:some View{
        Image(image)
            .renderingMode(.original)
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
            .shadow(color: .black, radius: 2)
    }
}


struct ContentView: View {
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var message = ""
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom).ignoresSafeArea(.all)
            VStack (spacing: 20){
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                
                ForEach(0 ..< 3) { number in
                    Button(action: {
                        self.flagTapped(number)
                    }) {
                        FlagImage(image: self.countries[number])
                    }
                    
                }
                
                Text("Your current score is : \(score)").foregroundColor(.white)
                    .font(.largeTitle)
                    .fontWeight(.black)
                
                Spacer()
            }
        }
        .alert(isPresented: $showingScore, content: {
            Alert(title: Text(scoreTitle),
                  message: Text("""
\(message)
Your score is \(score)
"""), dismissButton: .default(Text("Continue?")){
                self.askQuestion()
            })
        })
        
    }
    
    func flagTapped(_ number: Int){
        if number == correctAnswer {
            scoreTitle = "Correct!"
            score += 1
            message = "You are right!"
        }else {
            scoreTitle = "Wrong!"
            score += -1
            message = "That's the flag of \(countries[number])!"
        }
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer  = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
