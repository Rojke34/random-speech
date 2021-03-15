//
//  ViewController.swift
//  RandomSpech
//
//  Created by Kevin Rojas on 2/8/19.
//  Copyright © 2019 Kevin Rojas. All rights reserved.
//

import UIKit
import SwiftRandom
import AVFoundation
import SVProgressHUD

class ViewController: UIViewController, AVSpeechSynthesizerDelegate {

    @IBOutlet weak var nameLabel: UILabel!
    var randoms = [String]()
    var current = 0
    var currentName = String()
    
    var nameArray = [Character]()
    var currentCharacterIndex = Int()
    var currentCharacter = String()
    
    let synthesizer = AVSpeechSynthesizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        synthesizer.delegate = self
        
        randomValues()
    }
    
    @IBAction func sayItButtonDidTouch(_ sender: Any) {
        start()
    }
    
    fileprivate func start() {
        let name = randoms[current]
        currentName = name
        nameLabel.text = name
        
        nameArray = Array(name)
        
        nextCharacter()
    }
    
    func nextCharacter() {
        let nameArrayLenght = nameArray.count
        
        if currentCharacterIndex < nameArrayLenght {
            currentCharacterIndex += 1
        }
        
        spechCharacter()
    }
    
    func spechCharacter() {
        print(String(nameArray[currentCharacterIndex - 1]))
        
        let utterance = AVSpeechUtterance(string: String(nameArray[currentCharacterIndex - 1]))
        utterance.voice = AVSpeechSynthesisVoice(language: "en-GB")
        utterance.rate = 0.5
        
        synthesizer.speak(utterance)
    }
    

    fileprivate func randomValues() {
        SVProgressHUD.show()
        
        for _ in 0...1000 {
            randoms.append(Randoms.randomFakeName())
        }
        
        SVProgressHUD.dismiss()
    }
    
    fileprivate func next() {
        current += 1
        start()
        
    }
    
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        
        print(!(currentCharacterIndex >= nameArray.count))
        
        if !(currentCharacterIndex >= nameArray.count) {
            nextCharacter()
        } else {
            currentCharacterIndex = 0
            next()
        }
        
        
    }
    
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didStart utterance: AVSpeechUtterance) {
        
    }
    
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, willSpeakRangeOfSpeechString characterRange: NSRange, utterance: AVSpeechUtterance) {
        
    }
    
}

