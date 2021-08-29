//
//  ContentView.swift
//  BrainGame
//
//  Created by Denys on 29.08.2021.
//

import SwiftUI

struct ContentView: View {
    
    @State var choises = ["Paper", "Rock", "Scissors"].shuffled()
    
    var aiChoise = 0
    
    @State var winOrLose = Bool.random()
    
    @State var playersPoint = 0
    
    @State var alertTitle = ""
    
    @State var answer = false
    
    @State var questionNumber = 1
    
    var body: some View {
        VStack{
            
            Text("It's \(questionNumber) question").font(.largeTitle).fontWeight(.black).padding().background(Color(#colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1))).cornerRadius(25)
            
            HStack {
                Text("AI Choose").fontWeight(.black)
                Spacer()
                Text(choises[aiChoise]).fontWeight(.black)
                    .padding().background(Color(#colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1))).cornerRadius(10)
            }
            .font(.largeTitle)
            .padding()
            
            HStack {
                Text("You should")
                Text(winOrLose ? "Win" : "Lose")
                    .padding()
                    .background(Color(#colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1))).cornerRadius(15)
            }
            .font(.largeTitle)
            .padding()
            
            HStack(spacing:10){
                
                Button(action: {self.playersChoose("Paper")}, label: {
                    Text("Paper")
                })
                .padding().background(Color(#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1))).foregroundColor(.white).cornerRadius(15)
                Button(action: {self.playersChoose("Rock")}, label: {
                    Text("Rock")
                })
                .padding().background(Color(#colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1))).foregroundColor(.white).cornerRadius(15)
                Button(action: {self.playersChoose("Scissors")}, label: {
                    Text("Scissors")
                }) .padding().background(Color(#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1))).foregroundColor(.white).cornerRadius(15)
                
            }
            Spacer()
        }.padding(.top, 50.0).background(Color(#colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1))).ignoresSafeArea(.all)
        .alert(isPresented: $answer, content: {
            switch questionNumber {
            case 1..<10:
                return Alert(title: Text(alertTitle), message: Text(""), dismissButton: .default(Text("Continue?")){self.nextQuestion()
                    questionNumber += 1
                })
            default:
                return Alert(title: Text("The End"), message: Text("Your score is \(playersPoint)"), dismissButton: .default(Text("Play Again")){
                    questionNumber = 1
                    playersPoint = 0
                    self.nextQuestion()
                })
            }

        })
        
    }
    
    func playersChoose(_ what: String){
        
        if what == self.whatPlayerShouldAnswer(){
            alertTitle = "You score the point"
            playersPoint += 1
            answer = true
        }
        else {
            alertTitle = "You loose the point"
            playersPoint -= 1
            answer = true
        }

        
    }
    
    func whatPlayerShouldAnswer()->String{
        let condition = winOrLose
        switch choises[aiChoise]{
        case "Paper":
            return condition ? "Scissors" : "Rock"
        case "Rock":
            return condition ? "Paper" : "Scissors"
        case "Scissors":
            return condition ? "Rock" : "Paper"
            
        default: return ""
        }
        
    }
    
    func nextQuestion(){
        choises.shuffle()
        winOrLose = Bool.random()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
