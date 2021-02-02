//
//  ReadFromPictureView.swift
//  Password MEnager
//
//  Created by Aneta Szmidt on 2021-01-29.
//

import SwiftUI
import VisionKit
import Vision

struct ReadFromPictureView: View {
    
    @State var text = "text"
   @State var image = UIImage(named: "logintext")
    @State private var currentDrawing: Drawing = Drawing()

    
    @Binding var username: String
    @Binding var password: String

    @State var wordsList = [String.SubSequence]()
    
    @State var listex: [Any] = [Any]()
    @State var intUser = 0
    @State var intPass = 0
    @State var showingAlert = false

    
    
  
    
    var body: some View {

        VStack{
            
            ZStack{
    

                DrawOnImageView(image: $currentDrawing)
                
            }
            
            HStack{
                Text("Username: ")
                    .bold()
            TextField("Loading username... ", text: $username)
                Spacer()
            }
            .padding()
            
            
            HStack{
                Text("Password: ")
                    .bold()
                TextField("Loading password...", text: $password)
            
                Spacer()
            }
            .padding()

        Button("Get text") {
            detectText(in: image!)
        }
        .padding()
         
            Spacer()
        }
        .background(backgrundColor())
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("No text found"), message: Text("Try a different image"), dismissButton: .default(Text("Got it!")))

              }
         
    }
  

    
    
    func handleDetectionResults(results: [Any]?) {
      guard let results = results, results.count > 0 else {
          print("No text found")
        self.showingAlert.toggle()

          return
      }
        
        listex = results

      for result in results {

        
        if let observation = result as? VNRecognizedTextObservation {
              for text in observation.topCandidates(1) {
                let getTextString = text.string
                
                if getTextString == "Username:" || getTextString == "Username" ||
                    getTextString == "username" || getTextString == "Email" ||
                    getTextString == "Email:" || getTextString == "Login:"{
                     intUser = results.firstIndex { i -> Bool in
                        i as! NSObject == observation
                     }!
                }
           
                if getTextString == "Password:" || getTextString == "Password" ||
                    getTextString == "password" || getTextString == "password:"{
                    intPass = results.firstIndex { i -> Bool in
                        i as! NSObject == observation
                     }!
                            }

              }
          }
      }

        var res =  results[intUser + 1] as! VNRecognizedTextObservation
    
        for getText in res.topCandidates(1){
            username = getText.string
        }
        
         res =  results[intPass + 1] as! VNRecognizedTextObservation
    
        for getText in res.topCandidates(1){
            password = getText.string
        }
        
    }
    
    
    func performDetection(request: VNRecognizeTextRequest, image: CGImage) {
      let requests = [request]
      
      let handler = VNImageRequestHandler(cgImage: image, orientation: .up, options: [:])
      
      DispatchQueue.global(qos: .userInitiated).async {
          do {
              try handler.perform(requests)

          } catch let error {
              print("Error: \(error)")
          }
      }
    }
    
    func detectText(in image: UIImage) {
      guard let image = image.cgImage else {
        print("Invalid image")
        return
      }
      

      let request = VNRecognizeTextRequest { (request, error) in
        if let error = error {
          print("Error detecting text: \(error)")
        } else {
          self.handleDetectionResults(results: request.results)
        }
      }
      
      request.recognitionLanguages = ["en_US"]
      request.recognitionLevel = .accurate
      
      performDetection(request: request, image: image)
    }
}

struct ReadFromPictureView_Previews: PreviewProvider {
    static var previews: some View {
        Text("Placeholder")
    }
}


