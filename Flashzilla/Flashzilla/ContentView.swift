//
//  ContentView.swift
//  Flashzilla
//
//  Created by Denys on 16.11.2021.
//

import SwiftUI

extension View {
    func stacked(at position: Int, in total: Int) -> some View {
        let offset = CGFloat(total - position)
        return self.offset(CGSize(width: 0, height: offset * 10))
    }
}

struct ContentView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    @Environment(\.accessibilityEnabled) var accessibilityEnabled
    @State private var cards = [Card]()
    
    @State private var isActive = true
    
    @State private var isTimeOut = false
    
    @State private var timeRemaining = 10
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @State private var isShowingSheet = false
    
    enum TypeOfSheet {
        case edit, settings
    }
    @State private var typeSheet : TypeOfSheet = .edit
    
    @State private var returnWrongCards = false
    
    var body: some View {
        ZStack{
            Image(decorative: "background")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            VStack{
                Text("Time: \(timeRemaining)")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 5)
                    .background(
                        Capsule()
                            .fill(Color.black)
                            .opacity(0.75)
                    )
                ZStack {
                    ForEach(0..<cards.count, id: \.self) {
                        index in
                        CardView(card: self.cards[index], isWrongCard: self.returnWrongCards) { (correct) in
                            withAnimation{
                                self.removeCard(at: index, isSuccess: correct)
                            }
                        }
                        .stacked(at: index, in: self.cards.count)
                        .allowsHitTesting(index == self.cards.count - 1)
                        .accessibility(hidden: index < self.cards.count - 1)
                    }
                }
                .alert(isPresented: $isTimeOut){
                    Alert(title: Text("Time is out"), message: Text("Try Again!"), dismissButton: .default(Text("OK"), action: resetCards))
                }
                .allowsHitTesting(timeRemaining > 0)
                
                if cards.isEmpty{
                    Button("Start Again", action: resetCards)
                        .padding()
                        .background(Color.white)
                        .foregroundColor(Color.black)
                        .clipShape(Capsule())
                }
                
            }
            
            VStack {
                HStack {
                    Spacer()
                    VStack{
                        Button(action: {
                            self.typeSheet = .edit
                            self.isShowingSheet = true
                            
                        }) {
                            Image(systemName: "plus.circle")
                                .padding()
                                .background(Color.black.opacity(0.75))
                                .clipShape(Circle())
                        }
                        Button(action: {
                            self.typeSheet = .settings
                            self.isShowingSheet = true
                            
                        }) {
                            Image(systemName: "gear")
                                .padding()
                                .background(Color.black.opacity(0.75))
                                .clipShape(Circle())
                        }
                        
                    }
                    
                    
                }
                Spacer()
            }
            .foregroundColor(.white)
            .font(.largeTitle)
            .padding()
            
            if differentiateWithoutColor || accessibilityEnabled {
                VStack {
                    Spacer()
                    HStack {
                        Button(action: {
                            withAnimation{
                                self.removeCard(at: self.cards.count - 1, isSuccess: false)
                            }
                        }) {
                            Image(systemName: "xmark.circle")
                                .padding()
                                .background(Color.black.opacity(0.7))
                                .clipShape(Circle())
                        }
                        .accessibility(label: Text("Wrong"))
                        .accessibility(hint: Text("Mark your answer as being incorrect"))
                        Spacer()
                        Button(action: {
                            withAnimation{
                                self.removeCard(at: self.cards.count - 1, isSuccess: true)
                            }
                        }) {
                            Image(systemName: "checkmark.circle")
                                .padding()
                                .background(Color.black.opacity(0.7))
                                .clipShape(Circle())
                        }
                        .accessibility(label: Text("Correct"))
                        .accessibility(hint: Text("Mark your answer being correct"))
                    }
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .padding()
                }
            }
        }
        .onReceive(timer) {
            time in
            
            guard self.isActive else {return}
            
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
            }
            else {
                isTimeOut = true
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) {
            _ in
            self.isActive = false
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) {
            _ in
            if self.cards.isEmpty == false {
                self.isActive = true
            }
        }
        .sheet(isPresented: $isShowingSheet, onDismiss: resetCards){
            switch self.typeSheet {
            case .edit:
                EditCard()
            case .settings:
                SettingsView(returnWrongCards: $returnWrongCards)
            }
        }
        .onAppear(perform: resetCards)
        
    }
    
    func removeCard(at index: Int, isSuccess: Bool)
    {
        guard index >= 0 else {return}
        
        
        let card = cards.remove(at: index)
        if returnWrongCards && !isSuccess {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                self.cards.insert(card, at: 0)
            }
        }
        
        if cards.isEmpty {
            isActive = false
        }
    }
    
    func resetCards() {
        cards = [Card](repeating: Card.example, count: 10)
        timeRemaining = 100
        isActive = true
        loadData()
    }
    
    func loadData() {
        if let data = UserDefaults.standard.data(forKey: "Cards") {
            if let decoded = try? JSONDecoder().decode([Card].self, from: data) {
                self.cards = decoded
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
