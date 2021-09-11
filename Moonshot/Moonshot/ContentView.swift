//
//  ContentView.swift
//  Moonshot
//
//  Created by Denys on 09.09.2021.
//

import SwiftUI

struct ContentView: View {
     @State var isLaunchDate = true
    
    var body: some View {
        NavigationView{
            List(missions) {mission in
                NavigationLink(destination: MissionView(mission: mission, astronauts: astronauts)){
                        Image(mission.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 44, height: 44)
                        
                        VStack(alignment: .leading){
                            Text(mission.displayName)
                                .font(.headline)
                            if isLaunchDate {
                                Text(mission.formattedLaunchDate)
                            }
                            else {
                                ForEach(mission.crew, id: \.name) {
                                    crew in
                                    Text("\(crew.role): \(crewName(name: crew.name))")
                                }
                            }
                        }
                    }
            }
            .navigationBarTitle("Moonshot")
            .navigationBarItems(leading: Button(action: {self.isLaunchDate.toggle()}, label: {
                Text(isLaunchDate ? "Date" : "Crew")
            }))
        }
    }
    
    func crewName(name:String)->String{
        
        var realName = ""
        
        for astronaut in astronauts {
            if astronaut.id == name {
                realName = astronaut.name
            }
        }
        
        
        return realName
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
