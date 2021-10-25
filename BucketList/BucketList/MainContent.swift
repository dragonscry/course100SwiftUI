//
//  MainContent.swift
//  BucketList
//
//  Created by Denys on 25.10.2021.
//

import SwiftUI
import MapKit

struct MainContent: View {
    @State private var centerCoordinate = CLLocationCoordinate2D()
    @State private var locations = [CodableMKPointAnnotation]()
    @State private var selectedPlace: MKPointAnnotation?
    @State private var showingPlaceDetails = false
    @State private var showingEditScreen = false
    
    var body: some View {
        ZStack{
            MapView(centerCoordinate: $centerCoordinate, selectedPlace: $selectedPlace, showingPlaceDetails: $showingPlaceDetails, annotations: locations).edgesIgnoringSafeArea(.all)
            CircleView()
            
            VStack{
                Spacer()
                HStack{
                    Spacer()
                    PlusButton(locations: $locations, selectedPlace: $selectedPlace, centerCoordinate: $centerCoordinate, showingEditScreen: $showingEditScreen)
                }
            }
        }
        .alert(isPresented: $showingPlaceDetails){
            Alert(title: Text(selectedPlace?.title ?? "Unknown"), message: Text(selectedPlace?.subtitle ?? "Missing place information"), primaryButton: .default(Text("Ok")), secondaryButton: .default(Text("Edit")){
                self.showingEditScreen = true
            })
        }
        .sheet(isPresented: $showingEditScreen, onDismiss: saveDate) {
            if self.selectedPlace != nil {
                EditView(placemark: self.selectedPlace!)
            }
        }
        .onAppear(perform: loadData)
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
        
    }
    
    func loadData() {
        let filename = getDocumentsDirectory().appendingPathComponent("SavedPlaces")
        
        do {
            let data = try Data(contentsOf: filename)
            locations = try JSONDecoder().decode([CodableMKPointAnnotation].self, from: data)
        } catch {
            print("Unable to load saved data")
        }
    }
    
    func saveDate() {
        do {
            let filename = getDocumentsDirectory().appendingPathComponent("SavedPlaces")
            let data = try JSONEncoder().encode(self.locations)
            try data.write(to: filename, options: [.atomicWrite, .completeFileProtection])
        } catch {
            print("Unable to save data")
        }
    }
}

struct CircleView: View {
    var body: some View {
        Circle()
            .fill(Color.blue)
            .opacity(0.3)
            .frame(width: 32, height: 32)
    }
}

struct PlusButton: View {
    @Binding var locations: [CodableMKPointAnnotation]
    @Binding var selectedPlace: MKPointAnnotation?
    @Binding var centerCoordinate: CLLocationCoordinate2D
    @Binding var showingEditScreen : Bool
    var body: some View {
        Button(action: {
            let newLocation = CodableMKPointAnnotation()
            newLocation.title = "Example Location"
            newLocation.coordinate = self.centerCoordinate
            self.locations.append(newLocation)
            
            self.selectedPlace = newLocation
            self.showingEditScreen = true
            
        }) {
            Image(systemName: "plus")
                .padding()
                .background(Color.black.opacity(0.75))
                .foregroundColor(.white)
                .font(.title)
                .clipShape(Circle())
                .padding(.trailing)
        }
    }
}
