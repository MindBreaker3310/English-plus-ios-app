//
//  ViewController.swift
//  EnglishPlus
//
//  Created by MAX on 2019/5/29.
//  Copyright © 2019年 MAX. All rights reserved.
//

import UIKit
import AVFoundation


class VocabularyVC: UIViewController {
    let synthesizer = AVSpeechSynthesizer()
    
    @IBOutlet var charArray: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


    @IBAction func soundButton(_ sender: UIButton) {
        let button = sender 
        let myText = button.titleLabel?.text
        
        let utterance = AVSpeechUtterance(string: myText!.lowercased())
        
        
        synthesizer.speak(utterance)
        
        self.performSegue(withIdentifier: "goDetail", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let button = sender as! UIButton
        //取得button的Restoration ID
        let idx = button.restorationIdentifier!
        
        guard let vtvc = segue.destination as? VocabularyTVC else { return }
        
        vtvc.passedData = idx
    }
    
    
    @IBAction func testButton(_ sender: UIButton) {
        let myText = "surprise mother fucker!"
        let utterance = AVSpeechUtterance(string: myText)
        
        synthesizer.speak(utterance)
    }
    
}

