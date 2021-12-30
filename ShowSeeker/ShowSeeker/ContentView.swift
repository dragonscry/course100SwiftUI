//
//  ContentView.swift
//  ShowSeeker
//
//  Created by Denys on 13.12.2021.
//

import SwiftUI

enum SortedResorts: String, CaseIterable{
    case none
    case country
    case alphabetical
}

struct ContentView: View {
    
    @ObservedObject var favorites = Favorites()
    
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    
    @State var sortedList : SortedResorts = .none
    
    @State var countryForFiltering = "All"
    @State var sizeForFiltering = 0
    @State var priceForFiltering = 0
    
    @State var countriesArray: Set<String> = ["All"]
    
    var sortedResorts: [Resort] {
        
        switch sortedList {
        case .none:
            return resorts
        case .country:
            return resorts.sorted {$0.country < $1.country}
        case .alphabetical:
            return resorts.sorted {$0.name < $1.name }
        }
    }
    
    var filteredResorts: [Resort] {
        var tempResort = sortedResorts
        
        tempResort = tempResort.filter({ (resort) -> Bool in
            resort.country == self.countryForFiltering || self.countryForFiltering == "All"
        })
        
        tempResort = tempResort.filter({ (resort) -> Bool in
            resort.size == self.sizeForFiltering || self.sizeForFiltering == 0
        })
        
        tempResort = tempResort.filter({ (resort) -> Bool in
            resort.price == self.priceForFiltering || self.priceForFiltering == 0
        })
        
        return tempResort
    }
    
    @State var isShowingSettings = false
    
    var body: some View {
        NavigationView {
            List(filteredResorts) { resort in
                NavigationLink(destination: ResortView(resort: resort)) {
                    Image(resort.country)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 25)
                        .clipShape(
                            RoundedRectangle(cornerRadius: 5)
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.black, lineWidth: 1)
                        )
                    VStack(alignment: .leading) {
                        Text(resort.name)
                            .font(.headline)
                        Text("\(resort.runs) runs")
                            .foregroundColor(.secondary)
                    }
                    .layoutPriority(1)
                    
                    if self.favorites.contains(resort) {
                        Spacer()
                        Image(systemName: "heart.fill")
                            .accessibility(label: Text("This is a farovrite resort"))
                            .foregroundColor(.red)
                    }
                }
            }
            .navigationBarTitle("Resorts")
            .navigationBarItems(trailing: Button(action: {
                isShowingSettings = true
            }){
                Text("Settings")
            })
            
            WelcomeView()
        }
        .environmentObject(favorites)
        .sheet(isPresented: $isShowingSettings){
            Settings(sorted: $sortedList, countries: Array(countriesArray).sorted(by: <), countryForFiltering: $countryForFiltering, sizeForFiltering: $sizeForFiltering, priceForFiltering: $priceForFiltering)
        }
        .onAppear(perform: countries)
    }
    
    func countries(){
        for resort in resorts {
            countriesArray.insert(resort.country)
        }
    }
}

extension View {
    func phoneOnlyStackNavigationView() -> some View {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return AnyView(self.navigationViewStyle(StackNavigationViewStyle()))
        } else {
            return AnyView(self)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
