//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Denys on 22.09.2021.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var order: anotherOrder
    
    @State private var titleErrorMessage = ""
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    
    var body: some View {
        GeometryReader {
            geo in
            ScrollView {
                VStack{
                    Image("cupcakes")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width)
                    
                    Text("Your total is $\(order.order.cost, specifier: "%.2f")")
                        .font(.title)
                    
                    Button("Place Order"){
                        self.placeOrder()
                    }
                    .padding()
                }
            }
        }
        .navigationBarTitle("Check out", displayMode: .inline)
        .alert(isPresented: $showingConfirmation, content: {
            Alert(title: Text(titleErrorMessage), message: Text(confirmationMessage), dismissButton: .default(Text("OK")))
        })
    }
    
    func placeOrder() {
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("Failed to encode order")
            return
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = encoded
        
        URLSession.shared.dataTask(with: request) {data, response, error in
            guard let data = data
            else {
                self.titleErrorMessage = "Oops"
                self.confirmationMessage = "Something go wrong! Check your internet connection or try again later!"
                self.showingConfirmation = true
                return
            }
            if let decodedOrder = try? JSONDecoder().decode(anotherOrder.self, from: data) {
                self.titleErrorMessage = "Thank You!"
                self.confirmationMessage = "Your order for \(decodedOrder.order.quantity)x \(Order.types[decodedOrder.order.type].lowercased()) cupcakes is on its way!"
                self.showingConfirmation = true
            } else {
                self.titleErrorMessage = "Oops"
                self.confirmationMessage = "Something go wrong! Check your internet connection or try again later!"
                self.showingConfirmation = true
            }
            
            
        }.resume()
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: anotherOrder())
    }
}
