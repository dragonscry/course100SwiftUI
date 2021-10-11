//
//  ContentView.swift
//  Instafilter
//
//  Created by Denys on 06.10.2021.
//
import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

struct ContentView: View {
    
    @State private var image: Image?
    @State private var filterIntensity = 0.5
    
    @State private var filterRadius = 0.5
    @State private var filterScale = 0.5
    
    @State private var showingErrorWithoutImage = false
    @State private var showingFilterSheet = false
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var processedImage: UIImage?
    @State private var filterName: String?
    
    @State var currentFilter: CIFilter = CIFilter.sepiaTone()
    let context = CIContext()
    
    var body: some View {
        let intensity = Binding<Double>(
            get: {
                self.filterIntensity
            },
            set: {
                self.filterIntensity = $0
                self.applyProcessing()
            }
        )
        let radius = Binding<Double>(
            get: {
                self.filterRadius
            },
            set: {
                self.filterRadius = $0
                self.applyProcessing()
            }
        )
        let scale = Binding<Double>(
            get: {
                self.filterScale
            },
            set: {
                self.filterScale = $0
                self.applyProcessing()
            }
        )
        return NavigationView {
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
                    self.showingImagePicker = true
                }
                if currentFilter.inputKeys.contains(kCIInputIntensityKey){
                    HStack{
                        Text("Intensity")
                        Slider(value: intensity)
                    }
                    .padding(.vertical)
                }
                if currentFilter.inputKeys.contains(kCIInputRadiusKey){
                    HStack{
                        Text("Radius")
                        Slider(value: radius)
                    }
                    .padding(.vertical)
                }
                if currentFilter.inputKeys.contains(kCIInputScaleKey){
                    HStack{
                        Text("Scale")
                        Slider(value: scale)
                    }
                    .padding(.vertical)
                }
                
                HStack{
                    Button(filterName ?? "Sepia Tone") {
                        self.showingFilterSheet = true
                    }
                    
                    Spacer()
                    
                    Button("Save"){
                        if image == nil {
                            self.showingErrorWithoutImage = true
                        }
                        guard let processedImage = self.processedImage else {
                            return
                        }
                        let imageSaver = ImageSaver()
                        imageSaver.successHandler = {print("Success")}
                        imageSaver.errorHandler = {print("Oops: \($0.localizedDescription)")}
                        imageSaver.writeToPhotoAlbum(image: processedImage)

                    }
                }
            }
            .padding([.horizontal, .bottom])
            .navigationBarTitle("Instafilter")
            .sheet(isPresented: $showingImagePicker, onDismiss: loadImage){
                ImagePicker(image: self.$inputImage)
            }
            .actionSheet(isPresented: $showingFilterSheet) {
                ActionSheet(title: Text("Select a filter"), buttons: [
                    .default(Text("Crystallize")) {self.setFilter(CIFilter.crystallize(), name: "Crystallize")},
                    .default(Text("Edges")) {self.setFilter(CIFilter.edges(), name: "Edges")},
                    .default(Text("Gaussian Blur")) {self.setFilter(CIFilter.gaussianBlur(), name: "Gaussian Blur")},
                    .default(Text("Pixellate")) {self.setFilter(CIFilter.pixellate(), name: "Pixellate")},
                    .default(Text("Sepia Tone")) {self.setFilter(CIFilter.sepiaTone(), name: "Sepia Tone")},
                    .default(Text("Unsharp Mask")) {self.setFilter(CIFilter.unsharpMask(), name: "Unsharp Mask")},
                    .default(Text("Vignette")) {self.setFilter(CIFilter.vignette(), name: "Vignette")},
                    .cancel()
                ])
            }
            .alert(isPresented: $showingErrorWithoutImage){
                Alert(title: Text("You need add an image at first"), message: nil, dismissButton: .default(Text("Ok")))
            }
        }
    }
    func loadImage() {
        guard let inputImage = inputImage else {
            return
        }
        let beginImage = CIImage(image: inputImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
    }
    
    func applyProcessing() {
        let inputKeys = currentFilter.inputKeys
        if inputKeys.contains(kCIInputIntensityKey) {currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)}
        if inputKeys.contains(kCIInputRadiusKey) {currentFilter.setValue(filterRadius * 200, forKey: kCIInputRadiusKey)}
        if inputKeys.contains(kCIInputScaleKey) {currentFilter.setValue(filterScale * 10, forKey: kCIInputScaleKey)}
        guard let outputImage = currentFilter.outputImage
        else {return}
        
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgimg)
            image = Image(uiImage: uiImage)
            processedImage = uiImage
        }
    }
    func setFilter(_ filter: CIFilter, name: String){
        currentFilter = filter
        filterName = name
        loadImage()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
