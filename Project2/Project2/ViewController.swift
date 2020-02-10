//
//  ViewController.swift
//  Project2
//
//  Created by Jaroslav Janda on 22/10/2019.
//  Copyright © 2019 Jaroslav Janda. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var firstFlag: UIButton!
    @IBOutlet weak var secondFlag: UIButton!
    @IBOutlet weak var thirdFlag: UIButton!
    
    var countries = [String]()
    var score = 0
    var totalAskedQuestion = 0
    let maxQuestions = 10
    var correctAnswer = 0
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .organize, target: self, action: #selector(showScore))
        
        firstFlag.layer.borderWidth = 1
        secondFlag.layer.borderWidth = 1
        thirdFlag.layer.borderWidth = 1
        
        firstFlag.layer.borderColor = UIColor.lightGray.cgColor
        secondFlag.layer.borderColor = UIColor.lightGray.cgColor
        thirdFlag.layer.borderColor = UIColor.lightGray.cgColor

        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        askQuestion()
    }
    
    func askQuestion(action: UIAlertAction! = nil) {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
        firstFlag.setImage(UIImage(named: countries[0]), for: .normal)
        secondFlag.setImage(UIImage(named: countries[1]), for: .normal)
        thirdFlag.setImage(UIImage(named: countries[2]), for: .normal)
        
        title = "\(countries[correctAnswer].uppercased()) \(totalAskedQuestion)/10"
        
        if totalAskedQuestion == maxQuestions {
            let ac = UIAlertController(title: "End of game", message: "Your score is \(score) from \(maxQuestions)", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Restart", style: .destructive, handler: restartGame))
            present(ac, animated: true)
        }
        
    }
    
    func restartGame(action: UIAlertAction!) {
        score = 0
        totalAskedQuestion = 0
        askQuestion()
    }
    
    @IBAction func flagClick(_ sender: UIButton) {
        var title: String
        
        totalAskedQuestion += 1
        
        if sender.tag == correctAnswer {
            score += 1
            askQuestion()
        } else {
            title = "Wrong! That’s the flag of \(countries[sender.tag])"
            let ac = UIAlertController(title: title, message: "", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
            present(ac, animated: true)
        }
    }
    
    @objc func showScore() {
        let ac = UIAlertController(title: "Score", message: "Your score is \(score) from \(maxQuestions)", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: nil))
        present(ac, animated: true)
    }
    
}

