//
//  ContentView.swift
//  WorldScramble
//
//  Created by Denys on 01.09.2021.
//

import SwiftUI

struct ContentView: View {
    
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    @State private var score = 0
    
    
    var body: some View {
        NavigationView{
            VStack{
                TextField("Enter your word", text: $newWord, onCommit: addNewWord).textFieldStyle(RoundedBorderTextFieldStyle()).autocapitalization(.none).padding()
                Text("Your score : \(score)").foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                List(usedWords, id: \.self){ word in
                    HStack {
                        Image(systemName: "\(word.count).circle")
                        Text(word)
                    }
                    .accessibilityElement(children: .ignore)
                    .accessibility(label: Text("\(word), \(word.count) letters"))

                }
            }
            .navigationBarItems(leading: Button(action: {restartGame()}, label: {
                Text("Restart Game")
            }))
            .navigationBarTitle(rootWord)
            .onAppear(perform:startGame)
            .alert(isPresented: $showingError, content: {
                Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("OK")))
            })
        }
    }
    
    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard answer.count > 0 else {
            return
        }
        
        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Be more original")
            return
        }
        
        guard isPossible(word: answer) else {
            wordError(title: "Word not recognized", message: "You can't just make them up, you know")
            return
        }
        
        guard isReal(word: answer) else {
            wordError(title: "Word not possible", message: "That is not a real word")
            return
        }
        
        guard isMoreThanThreeLetter(word: answer) else {
            wordError(title: "Word too small", message: "Word shoul contain more than 3 letters")
            return
            
        }
        
        guard notFirstLetters(word: answer) else {
            wordError(title: "Not so easy", message: "Dont just type easy words")
            return
            
        }
        score += answer.count
        usedWords.insert(answer, at: 0)
        newWord = ""
    }
    func startGame() {
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt"){
            if let startWords = try? String(contentsOf: startWordsURL){
                let allWords = startWords.components(separatedBy: "\n")
                rootWord = allWords.randomElement() ?? "silkworm"
                return
            }
        }
        
        fatalError("Could not load start.txt from bundle.")
    }
    
    func restartGame(){
        startGame()
        usedWords = [String]()
        score = 0

    }
    
    func isOriginal (word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    func isPossible (word: String) -> Bool {
        var tempWord = rootWord.lowercased()
        for letter in word {
            if let pos = tempWord.firstIndex(of:letter){
                tempWord.remove(at: pos)
            }
            else {
                return false
            }
        }
        return true
    }
    
    func isReal(word:String)->Bool{
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
    }
    
    func isMoreThanThreeLetter(word:String)->Bool {
        return word.count > 3
    }
    
    func notFirstLetters(word: String) -> Bool{
        let index = rootWord.firstIndex(of: word[word.startIndex])
            for i in 0..<word.count {
                if word[word.index(word.startIndex, offsetBy: i)] != rootWord[rootWord.index(index ?? rootWord.startIndex, offsetBy: i)]{
                    return true
                }
            }
            return false
    }
    
    func wordError(title:String, message:String){
        errorTitle = title
        errorMessage = message
        showingError = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
