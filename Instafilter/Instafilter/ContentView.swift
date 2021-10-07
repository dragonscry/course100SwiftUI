//
//  ContentView.swift
//  Instafilter
//
//  Created by Denys on 06.10.2021.
//

import SwiftUI

class ImageSaver: NSObject {
    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveError), nil)
        
    }
    
    @objc func saveError(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        print("Save Finished")
    }
}

struct ContentView: View {
    
    @State private var image: Image?
    @State private var filterIntensity = 0.5
    
    var body: some View {
        NavigationView{
            VStack{
                ZStack{
                    Rectangle()
                        .fill(Color.secondary)
                    
                    if image != nil {
                        image?
                            .resizable()
                            .scaledToFit()
                    } else {
                        Text("Tap to select a picture")
                            .foregroundColor(.white)
                            .font(.headline)
                    }
                }
                .onTapGesture {
                    
                }
                
                HStack{
                    Text("Intensity")
                    Slider(value: $filterIntensity)
                }
                .padding(.vertical)
                
                HStack{
                    Button("Change Filter") {
                        //
                    }
                    
                    Spacer()
                    
                    Button("Save"){
                        //
                    }
                }
            }
            .padding([.horizontal, .bottom])
            .navigationBarTitle("Instafilter")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
