//
//  InterfaceController.swift
//  Watch6 WatchKit Extension
//
//  Created by Macbook on 03/06/2017.
//  Copyright © 2017 Chappy-App. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {


     @IBOutlet var image: WKInterfaceImage!

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
     @IBAction func dictateTapped() {
          
          presentTextInputController(withSuggestions: nil, allowedInputMode: .plain) { result in
          
               guard let result = result?.first as? String else { return }
               
               print(result)
               
          }
     }

     @IBAction func multiInputTapped() {
     
          presentTextInputController(withSuggestions: ["Hacking with Swift", "Hacking with macOS", "Server-Side Swift"], allowedInputMode: .allowAnimatedEmoji) { result in
          
               if let result = result?.first as? String {
                    
                    print(result)
                    
               } else if let result = result?.first as? Data {
                    
                    guard let imageData = UIImage(data: result) else { return }
                    
                    self.image.setImage(imageData)
               }
               
          }
     }
     
     @IBAction func recordingTapped() {
     
          //set where we'll read and save from
          let saveURL = getDocumentsDirectory().appendingPathComponent("recording.wav")
          
          if FileManager.default.fileExists(atPath: saveURL.path) {
          
               //if we have a recording already, play it
               let options = [WKMediaPlayerControllerOptionsAutoplayKey: "true"]
               
               presentMediaPlayerController(with: saveURL, options: options) { didPlayToEnd, endTime, error in
               
               //do nothing here
          }
          
          } else {
               
               //we dont have a recording; make one
               let options: [String: Any] = [WKAudioRecorderControllerOptionsMaximumDurationKey: 60, WKAudioRecorderControllerOptionsAlwaysShowActionTitleKey: "Done"]
               
               presentAudioRecorderController(withOutputURL: saveURL, preset: .narrowBandSpeech, options: options) { success, error in
               
               if success {
                    
                    print("Saved successfully!")
                    
               } else {
                    
                    print(error?.localizedDescription ?? "Unknown error")
                    
               }
          }
     }
}
 
     
     func getDocumentsDirectory() -> URL {
          
          let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
          
          return paths[0]
     }
     
     
     
}
