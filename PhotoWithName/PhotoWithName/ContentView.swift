//
//  ContentView.swift
//  PhotoWithName
//
//  Created by Denys on 31.10.2021.
//

import SwiftUI

struct ContentView: View {
    @State private var image: Image?
    @State private var inputImage: UIImage?
    @State private var showingPictureView = false
    @State private var pictures = [SavedImage]()
    var body: some View {
        NavigationView {
            List {
                ForEach(pictures) {
                    picture in
                    NavigationLink(destination: ImageView(picture: picture)) {
                            Text(picture.imageName)
                    }
                }
                .onDelete(perform: removeItems(at:))
            }
            .navigationBarTitle(Text("Photos"))
            .navigationBarItems(leading: EditButton(), trailing: Button(action: {
                self.showingPictureView = true
            }) {
                Image(systemName: "plus")
            })
            .sheet(isPresented: $showingPictureView) {
                SaveImageView(savedImages: self.$pictures)
            }
            .onAppear {
                self.pictures = ManageData.loadPictures(pathName: "SavedImages")
            }
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        let image = pictures[offsets.first!]
        
        ManageData.removeImage(pathName: image.id.uuidString)
        pictures.remove(atOffsets: offsets)
        
        ManageData.savedPictures(pathName: "SavedImages", savedImages: self.pictures)
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
