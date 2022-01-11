//
//  ViewController.swift
//  SimpleApp
//
//  Created by Quinton Askew on 1/11/22.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    

    @IBOutlet weak var sentenceTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var answerTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.submitButton.layer.cornerRadius = 12
    }


   
    @IBAction func submitButtonTapped(_ sender: Any) {
        self.validate()
    }
    
    fileprivate func getFrequency(_ sentence: String) {
        // Convert sentence to a dictionary
         let sentenceArray = sentence.split(separator: " ")
            var sentenceDict: [String: Int] = [:]
            
            // Compare each word to the other words
            for word in sentenceArray {
                var count = 0
                for nextWord in sentenceArray {
                    if word == nextWord {
                        count += 1
                    }
                }
                
                sentenceDict["\(word)"] = count
            }
            
            // Format the answer
            var answer = ""
            for (word,count) in sentenceDict {
                answer += "\(word)    \(count)\n \n "
                print("\(word) \(count)")
            }
    
         // Present answer
            self.answerTextView.text = answer
        
    }
    
    fileprivate func validate() {
        
        var sentence = self.sentenceTextField.text?.lowercased()
        
        // Check if textfield is empty
        if sentence == nil || sentence == "" {
            self.alert("Error", "Please add text.")
            return
        }
        
        // Check for letters only
        if self.validateSentence(sentence: sentence!) == true {
            self.alert("Oops!", "Letters only please.")
            return
        }
        
        // Remove spaces from the beginning / end of the sentence
        sentence = sentence!.trimSentence()
    
        
        self.getFrequency(sentence!)
        
    }
    
    
    
    fileprivate func alert(_ title: String, _ message: String) {
        let alert = UIAlertController(title: title, message: message,         preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    fileprivate func validateSentence(sentence : String) -> Bool {

            let numberRegEx  = ".*[0-9]+.*"
            let testCase = NSPredicate(format:"SELF MATCHES %@", numberRegEx)
            let validated = testCase.evaluate(with: sentence)

            return validated
    }
    
    
    
}

extension String {
    func trimSentence(using characterSet: CharacterSet = .whitespacesAndNewlines) -> String {
        return trimmingCharacters(in: characterSet)
    }
}
