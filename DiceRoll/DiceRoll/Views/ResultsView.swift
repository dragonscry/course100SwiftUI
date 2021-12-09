//
//  ResultsView.swift
//  DiceRoll
//
//  Created by Denys on 08.12.2021.
//

import SwiftUI
import CoreData

struct ResultsView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(entity: Result.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Result.totalResult, ascending: false)]) var results: FetchedResults<Result>
    
    @State private var countOfDice = 1
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(results, id: \.wrappedId) {
                        result in
                        HStack {
                            HStack {
                                DiceView(result: self.findDiceIndex(at: result) + 1, height: 24, widht: 24, fontSize: 10)
                                ForEach(result.diceArray, id: \.diceResult) { dice in
                                    DiceView(result: dice.wrappedDiceResult, height: 54, widht: 54, fontSize: 24)
                                    
                                }
                            }
                            Spacer()
                            
                            VStack(alignment: .leading) {
                                HorizontalTextView(text: "Result: ", textResult: "\(result.wrappedTotalResult)", fontSize: 16, textColor: .green, resultColor: .red)
                                HorizontalTextView(text: "Date: ", textResult: "\(result.wrappedDate)", fontSize: 12, textColor: .blue, resultColor: .purple)
                                HorizontalTextView(text: "Time: ", textResult: "\(result.wrappedTime)", fontSize: 12, textColor: .blue, resultColor: .primary)
                            }
                        }
                    }
                    .onDelete(perform: deleteResult(at:))
                }
                HorizontalTextView(text: "Number of results: ", textResult: "\(results.count)", fontSize: 30, textColor: .green, resultColor: .red)
            }
            .navigationTitle("Results")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }

    func deleteResult(at offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                let result = results[index]
                for dice in result.diceArray {
                    viewContext.delete(dice)
                }
                viewContext.delete(result)
                
                do {
                    try viewContext.save()
                } catch {
                    print("Error with saving after deleting result")
                }
            }
        }
    }
    
    func findDiceIndex(at result: Result) -> Int {
        guard let index = results.firstIndex(of: result) else {
            return 0
        }
        return index
    }
    
    

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

}

//struct ResultsView_Previews: PreviewProvider {
//    static var previews: some View {
//        ResultsView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//    }
//}
