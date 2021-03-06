//
//  ContentView.swift
//  iExpense
//
//  Created by Denys on 07.09.2021.
//

import SwiftUI

struct ExpenseItem : Identifiable, Codable {
    let id = UUID()
    let name : String
    let type : String
    let amount : Int
}

class Expenses : ObservableObject {
    @Published var items = [ExpenseItem](){
        didSet{
            let encoder = JSONEncoder()
            
            if let encoded = try? encoder.encode(items){
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init(){
        if let items = UserDefaults.standard.data(forKey: "Items"){
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([ExpenseItem].self, from: items) {
                self.items = decoded
                return
            }
        }
        self.items = []
    }
}

struct AmountModifier : ViewModifier{
    
    var amount: Int
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(color(am: amount))
    }
    
    func color (am : Int) -> Color {
        switch am{
        case ..<10:
            return .green
        case ..<100:
            return .blue
        default:
            return .red
        }
    }
}

extension View {
    func AmountColor(amount:Int) -> some View{
        self.modifier(AmountModifier(amount: amount))
    }
}

struct ContentView: View {
    
    @ObservedObject var expenses = Expenses()
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationView{
            List{
                ForEach(expenses.items){ item in
                    HStack{
                        VStack(alignment: .leading){
                            Text(item.name).font(.headline)
                            Text(item.type)
                        }
                        Spacer()
                        Text("$\(item.amount)").AmountColor(amount: item.amount)
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationBarTitle("iExpense")
            .navigationBarItems(leading: EditButton(), trailing:
                                    Button(action: {
                                        self.showingAddExpense = true
                                    }){
                                        Image(systemName: "plus")
                                    }
                                
            )
            
            //.navigationBarItems(leading: EditButton())
            .sheet(isPresented: $showingAddExpense, content: {
                AddView(expenses: self.expenses)
            })
        }
    }
    
    func removeItems(at offset: IndexSet){
        expenses.items.remove(atOffsets: offset)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
