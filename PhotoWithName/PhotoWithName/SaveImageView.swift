//
//  SaveImageView.swift
//  PhotoWithName
//
//  Created by Denys on 31.10.2021.
//

import SwiftUI

struct SaveImageView: View {
    @State var image : Image?
    @State var text = ""
    @State var showingImagePicker = false
    @State var inputImage: UIImage?
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var savedPhotos : SavedPhotos
    var body: some View {
        VStack{
            TextField("Name your picture", text: $text)
                .padding()
            
            if image == nil {
                Button("Select Photo"){
                    showingImagePicker = true
                }
                .padding()
                .background(Color.blue)
                .clipShape(Capsule())
                .foregroundColor(Color.white)
            }
            else {
                image?.resizable().scaledToFit()
                Button("Save"){
                    savedPhotos.arrayOfSavedImage.append(SavedImage(name: text, image: image ?? Image(systemName: "plus")))
                    presentationMode.wrappedValue.dismiss()
                }
                .padding()
                .background(Color.green)
                .clipShape(Capsule())
                .foregroundColor(Color.white)
            }
        }
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage){
            ImagePicker(image: self.$inputImage)
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else {return}
        image = Image(uiImage: inputImage)
        
    }
}
//
//struct SaveImageView_Previews: PreviewProvider {
//    static var previews: some View {
//        SaveImageView()
//    }
//}
