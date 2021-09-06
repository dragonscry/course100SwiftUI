//
//  QuestionView.swift
//  HowToLearnMultiplication
//
//  Created by Denys on 06.09.2021.
//

import SwiftUI

struct QuestionView: View {
    
    var first:Int
    var second:Int
    
    let colors = [Color(#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)), Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)), Color(#colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)), Color(#colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1))]
    
    var body: some View {
        VStack{
            Text("Print Correct Answer!").font(.largeTitle).foregroundColor(.white)
                .padding()
            Text("\(first) * \(second) = ?").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).foregroundColor(.white)
        }.frame(width: 350, height: 200).background(colors[Int.random(in: 0..<colors.count)]).cornerRadius(25)
        .padding(.top, 50)
    }
}

struct QuestionView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionView(first: 5, second: 7)
    }
}
