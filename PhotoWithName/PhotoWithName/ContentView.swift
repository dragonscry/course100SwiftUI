//
//  ContentView.swift
//  PhotoWithName
//
//  Created by Denys on 31.10.2021.
//

import SwiftUI

class SavedPhotos: ObservableObject {
    @Published var arrayOfSavedImage = [SavedImage]()
}

struct ContentView: View {
    @State private var image: Image?
    @State private var showingSavedImageView = false
    @StateObject var savedPhotos = SavedPhotos()
    var buttonImage = Image(systemName: "plus")
    
    var body: some View {
        NavigationView {
            
            List(savedPhotos.arrayOfSavedImage, id: \.id) { image in
                Text(image.name)
                
            }
                .navigationTitle("Photos")
                .navigationBarItems(trailing: Button {
                    showingSavedImageView = true
                } label: {
                    Image(systemName: "plus")
                })
        }
        .sheet(isPresented: $showingSavedImageView){
            SaveImageView(savedPhotos: savedPhotos)
            
        }
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
