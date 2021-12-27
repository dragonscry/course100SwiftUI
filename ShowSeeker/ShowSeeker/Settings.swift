//
//  Settings.swift
//  ShowSeeker
//
//  Created by Denys on 25.12.2021.
//

import SwiftUI

struct Settings: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var sorted : SortedResorts
    
    let countries = ["All", "United States", "Italy", "France", "Canada", "Austria"]
    let sizes = ["All", "Small", "Average", "Large"]
    let prices = ["All", "$", "$$", "$$$"]
    
    @Binding var countryForFiltering: String
    @Binding var sizeForFiltering: Int
    @Binding var priceForFiltering: Int
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("What sorting do you want?")) {
                    Picker("Select Sorting", selection: $sorted){
                        ForEach(Array(SortedResorts.allCases), id: \.self){ sorted in
                            Text(sorted.rawValue)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .colorMultiply(Color.orange)
                }
                
                Section(header: Text("Select country for filtering: ")) {
                    Picker(selection: $countryForFiltering, label: Text("Select country for filtering")){
                        ForEach(countries, id: \.self){ country in
                            Text("\(country)")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                    .colorMultiply(Color.red)
                }
                Section(header: Text("Select size for filtering: ")) {
                    Picker(selection: $sizeForFiltering, label: Text("Select country for filtering")){
                        ForEach(0..<self.sizes.count){ size in
                            Text("\(sizes[size])")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                    .colorMultiply(Color.green)
                }
                Section(header: Text("Select price for filtering: ")) {
                    Picker(selection: $priceForFiltering, label: Text("Select country for filtering")){
                        ForEach(0..<self.prices.count){ price in
                            Text("\(prices[price])")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                    .colorMultiply(Color.purple)
                }
            }
            .navigationBarItems(trailing: Button(action: {
                self.dismiss()
            }){
                Text("Done")
            })
        }
    }
    
    func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
}


//struct Settings_Previews: PreviewProvider {
//    static var previews: some View {
//        Settings()
//    }
//}
