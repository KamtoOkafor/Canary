//
//  Camera.swift
//  FinanceTracker
//
//  Created by Killah-Kam on 3/17/21.
//

import SwiftUI

struct CaptureImageView {
    /// MARK: - Properties
        @Binding var isShown: Bool
        @Binding var image: Image?
        
        func makeCoordinator() -> Coordinator {
          return Coordinator(isShown: $isShown, image: $image)
        }
}
extension CaptureImageView: UIViewControllerRepresentable {
    
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<CaptureImageView> ) -> UIImagePickerController {
        
        let picker = UIImagePickerController()
        
        picker.delegate = context.coordinator
        picker.sourceType = .camera
        picker.allowsEditing = true
        picker.dismiss(animated: true)
        
        
        
        return picker
    }
    
    
    
    func updateUIViewController(_ uiViewController: UIImagePickerController,
                                context: UIViewControllerRepresentableContext<CaptureImageView>) {
        
    }
}

struct CameraView: View {
    
    @State var image: Image? = nil
    @State private var inputImage: UIImage?
    @State var showCaptureImageView: Bool = false
    
    var body: some View {
        
        VStack
        {
            
        
        
            HStack{
                Text("Billing Camera").padding().font(.title)
            } .padding()
            
            
           
            HStack
            {
               Image(systemName: "camera").font(.system(size: 100, weight: .regular))
            }.padding()
            
            ZStack {
                  VStack {
                    Button(action: {
                        self.showCaptureImageView.toggle()
                        
                       
                        
                        
                        
                        /*
                        guard let inputImage = inputImage else { return }
                        image = Image(uiImage: inputImage)
                        */
                        
                        
                        
                        
                        
                        //let pickedImage = inputImage.jpegData(compressionQuality: 0.80)

                        
                        //subscription.image = pickedImage
                        

                                
                               
                        
                    }) {
                      Text("Take a picture of bill")
                    }
                    image?.resizable()
                      .frame(width: 250, height: 200)
                      .clipShape(Circle())
                      .overlay(Circle().stroke(Color.white, lineWidth: 4))
                      .shadow(radius: 10)
                  }
                  if (showCaptureImageView) {
                    CaptureImageView(isShown: $showCaptureImageView, image: $image)
                    
                    //subscription.image = $image
                  }
            }
            
            HStack
            {
                Button(action: {

                    //UIImageWriteToSavedPhotosAlbum(image, self, nil, nil)
                    
                    print("bill photo added")
                    
                })
                {
                    Text("Add to Storage Coming Soon").font(.title3)
                }
            }.padding()
                
                
        
        }
    }
}

struct CameraView_Previews: PreviewProvider {
    static var previews: some View {
        CameraView()
    }
}
