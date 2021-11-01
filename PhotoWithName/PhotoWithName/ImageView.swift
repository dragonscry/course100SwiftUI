//
//  ImageView.swift
//  PhotoWithName
//
//  Created by Denys on 01.11.2021.
//

import SwiftUI
import MapKit

struct ImageView: View {
    var picture : SavedImage
    @State private var image: Image?
    @State private var inputImage: UIImage?
    @State private var centerCoorditane = CLLocationCoordinate2D()
    var body: some View {
        VStack{
            DrawImageNameView(text: "Photo name: ", textResults: picture.imageName)
            
            if image != nil {
                image?
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(20)
            } else {
                Text("Image not found")
            }
            ZStack {
                MapView(centerCoordinate: $centerCoorditane, annotations: picture.locations)
                    .edgesIgnoringSafeArea(.all)
            }
            Spacer()
        }
        .onAppear {
            loadImage()
        }
    }
    
    func loadImage() {
        let data = ManageData.loadImage(pathName: picture.id.uuidString)
        guard let loadedData = data else { return }
        self.inputImage = UIImage(data: loadedData)
        self.image = Image(uiImage: inputImage!)
    }
}
