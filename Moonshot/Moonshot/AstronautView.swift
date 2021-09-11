//
//  AstronautView.swift
//  Moonshot
//
//  Created by Denys on 11.09.2021.
//

import SwiftUI

struct AstronautView: View {
    
    let astronaut: Astronaut
    
    var allMissions = [Mission]()
    
    var body: some View {
        GeometryReader{
            geometry in
            ScrollView(.vertical){
                VStack (alignment: .leading){
                    Image(self.astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width)
                    
                    Text(self.astronaut.description)
                        .padding()
                        .layoutPriority(1)
                    Text("Astronaut's Missions:")
                        .font(.headline).padding()
                    ForEach(allMissions, id: \.id){ mission in
                        HStack{
                            Image(mission.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 44, height: 44)
                            VStack(alignment: .leading){
                                Text(mission.displayName)
                                    .font(.headline)
                                Text(mission.formattedLaunchDate)
                            }
                        }.padding(.leading, 15)
                    }
                }
            }
        }
        .navigationBarTitle(Text(astronaut.name), displayMode: .inline)
    }
    
    init(astronaut:Astronaut){
        self.astronaut = astronaut
        
        for mission in missions {
            for crew in mission.crew{
                if crew.name == astronaut.id{
                    self.allMissions.append(mission)
                }
            }
        }
        
    }
}

struct AstronautView_Previews: PreviewProvider {
    static var previews: some View {
        AstronautView(astronaut: astronauts[0])
    }
}
