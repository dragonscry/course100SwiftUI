//
//  TextView.swift
//  DiceRoll
//
//  Created by Denys on 09.12.2021.
//

import SwiftUI

struct HorizontalTextView: View {
    var text: String
    var textResult: String
    var fontSize: Int
    var textColor: Color
    var resultColor: Color
    
    var body: some View {
        VStack{
            Text(text)
                .font(Font.system(size: CGFloat(self.fontSize), weight: .heavy, design: .default))
                .foregroundColor(textColor)
            +
            Text(textResult)
                .font(.system(size: CGFloat(self.fontSize), weight: .heavy, design: .rounded))
                .foregroundColor(resultColor)
        }
    }
}

struct DynamicHorizontalTextView: View {
    var text: String
    var textResult: String
    var fontSize: Int
    var textColor: Color
    var resultColor: Color
    
    var body: some View {
        HStack {
            Text(text)
                .font(Font.system(size: CGFloat(self.fontSize), weight: .heavy, design: .default))
                .foregroundColor(textColor)
            Spacer()
            Text(textResult)
                .font(.system(size: CGFloat(self.fontSize), weight: .heavy, design: .rounded))
                .foregroundColor(resultColor)
            
            
        }
    }
}

