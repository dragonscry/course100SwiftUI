//
//  SaveImageView.swift
//  PhotoWithName
//
//  Created by Denys on 31.10.2021.
//

import SwiftUI
import CoreLocation
import MapKit

struct SaveImageView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var savedImages: [SavedImage]
    @State private var image : Image?
    @State private var inputImage: UIImage?
    @State private var imageName = ""
    @State private var showingImagePicker = false
    @State private var showingSourseTypeAlert = false
    @State private var centerCoordinage = CLLocationCoordinate2D()
    @State private var locations = [CodableMKPointAnnotation]()
    @State private var selectedPlace: MKPointAnnotation?
    @State private var locationFetcher = LocationFetcher()
    @State private var pictureSourceType = UIImagePickerController.SourceType.photoLibrary
    
    var body: some View {
        NavigationView {
            VStack {
                HStack{
                    TextField("Name Photo", text: $imageName)
                        .frame(width: 200, height: 50, alignment: .center)
                        .background(Color.gray)
                        .clipShape(Capsule())
                        .overlay(Capsule().stroke(Color.orange, lineWidth: 3))
                        .multilineTextAlignment(.center)
                }
                if image != nil {
                    image?
                        .resizable()
                        .scaledToFit()
                } else {
                    Button(action: {
                        self.showingSourseTypeAlert = true
                    }) {
                        Text("Select image")
                            .foregroundColor(Color.white)
                    }
                    .frame(width: 200, height: 59, alignment: .center)
                    .background(Color.blue)
                    .cornerRadius(20)
                    .padding(.top, 100)
                }
                
                ZStack {
                    MapView(centerCoordinate: $centerCoordinage, annotations: locations)
                        .edgesIgnoringSafeArea(.all)
                    CircleView()
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            PlusButtonView(locations: $locations, centerCoordinate: $centerCoordinage, imageName: self.imageName)
                        }
                    }
                }
                Spacer()
            }.padding(.top, 10)
                .sheet(isPresented: $showingImagePicker, onDismiss: addNewImage, content: {
                    ImagePicker(image: self.$inputImage, pickerSourceType: $pictureSourceType)
                })
                .onAppear{
                    self.locationFetcher.start()
                }
                .alert(isPresented: $showingSourseTypeAlert) {
                    if imageName.isEmpty {
                       return Alert(title: Text("Type Photo Name"), message: nil, dismissButton: .default(Text("OK")))
                    }
                    else {
                        return Alert(title: Text("Take Photo from: "), message: nil, primaryButton: .default(Text("Photo Library"), action: {
                            self.pictureSourceType = .photoLibrary
                            self.showingImagePicker = true
                        }), secondaryButton: .default(Text("Camera")){
                            self.pictureSourceType = .camera
                            self.showingImagePicker = true
                        })
                    }
                }
                .navigationBarItems(trailing: Button(action: {
                    self.saveImages()
                }, label: {
                    Text("Save")
                }))
        }
    }
    
    func addNewImage() {
        guard let inputImage = inputImage else {
            return
        }
        image = Image(uiImage: inputImage)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        if pictureSourceType == .camera {
            if let location = self.locationFetcher.lastKnownLocation {
                let newLocation = CodableMKPointAnnotation()
                newLocation.coordinate = location
                newLocation.title = "Location for photo with name \(self.imageName)"
                newLocation.subtitle = "Locations added: \(formatter.string(from: Date()))"
                self.locations.append(newLocation)
            }
        }

    }
    
    func saveImages() {
        let image =  SavedImage(id: UUID(), imageName: self.imageName, locations: locations)
        self.savedImages.append(image)
        ManageData.savesImage(pathName: image.id.uuidString, inputImage: self.inputImage)
        ManageData.savedPictures(pathName: "SavedImages", savedImages: self.savedImages)
        
        self.presentationMode.wrappedValue.dismiss()
    }

}
//
//struct SaveImageView_Previews: PreviewProvider {
//    static var previews: some View {
//        SaveImageView()
//    }
//}
