//
//  ViewController.swift
//  MilestoneProject3
//
//  Created by Jaroslav Janda on 12/02/2020.
//  Copyright © 2020 Jaroslav Janda. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var guessWord: UILabel!
    var liveCounter: UILabel!
    var buttons = [UIButton]()
    
    var words = [String]()
    var currentWord = [String]()
    
    let alphabeths = "abcdefghijklmnopqrstuvwxyz"
    
    var lives = 7 {
        didSet {
            liveCounter.text = "Lives: \(lives)"
        }
    }
    override func loadView() {
        setupUI()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        loadWords()
    }
    
    func setupUI() {
        view = UIView()
        view.backgroundColor = .blue
        
        guessWord = UILabel()
        guessWord.translatesAutoresizingMaskIntoConstraints = false
        guessWord.textAlignment = .center
        guessWord.font = UIFont.systemFont(ofSize: 40)
        guessWord.textColor = .yellow
        guessWord.text = ""
        view.addSubview(guessWord)
        
        liveCounter = UILabel()
        guessWord.font = UIFont.systemFont(ofSize: 25)
        liveCounter.translatesAutoresizingMaskIntoConstraints = false
        liveCounter.textAlignment = .right
        liveCounter.textColor = .yellow
        liveCounter.text = "Lives \(lives)"
        view.addSubview(liveCounter)
        
        let buttonViews = UIView()
        buttonViews.translatesAutoresizingMaskIntoConstraints = false
        buttonViews.layer.borderWidth = 0.2
        buttonViews.layer.borderColor = UIColor.gray.cgColor
        view.addSubview(buttonViews)
        
        
        NSLayoutConstraint.activate([
            liveCounter.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 20),
            liveCounter.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            guessWord.topAnchor.constraint(equalTo: liveCounter.topAnchor, constant: 100),
            guessWord.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            guessWord.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor),
            buttonViews.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -20),
            buttonViews.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonViews.widthAnchor.constraint(equalToConstant: 385),
            buttonViews.heightAnchor.constraint(equalToConstant: 320)
        ])
        
        let buttonWidth = 55
        let buttonHeight = 80
        
        for row in 0..<alphabeths.count / 6  {
            for column in 0...alphabeths.count / (alphabeths.count / 6) {
                let button = UIButton(type: .system)
                button.setTitle("", for: .normal)
                let frame = CGRect(x: column * buttonWidth, y: row * buttonHeight, width: buttonWidth, height: buttonHeight)
                button.frame = frame
                button.setTitleColor(.yellow, for: .normal)
                button.titleLabel?.font = UIFont.systemFont(ofSize: 24)
                buttonViews.addSubview(button)
                buttons.append(button)
                button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
            }
        }
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        guard let tappedWord = sender.titleLabel?.text else { return }
        if currentWord.contains(tappedWord) {
            for (i, char) in currentWord.enumerated() {
                if char == tappedWord {
                    guessWord.text = guessWord.text?.replace(tappedWord, at: i)
                }
            }
            if currentWord.joined() == guessWord.text {
                let ac = UIAlertController(title: "Great", message: "Yes the word was \(guessWord.text!)", preferredStyle: .alert)
                let action = UIAlertAction(title: "Let's take another 💪", style: .default, handler: nextWord)
                ac.addAction(action)
                present(ac, animated: true)
            }
        } else {
            lives -= 1
        }
        if lives <= 0 {
            let ac = UIAlertController(title: "You lose", message: "Do you want try again?", preferredStyle: .alert)
            let action = UIAlertAction(title: "Yes", style: .default, handler: reloadWholeGame)
            let storno = UIAlertAction(title: "Nope", style: .cancel, handler: nil)
            ac.addAction(action)
            ac.addAction(storno)
            present(ac, animated: true)
        }
        sender.isUserInteractionEnabled = false
        sender.setTitleColor(.gray, for: .normal)
        
    }
    
    func nextWord(action: UIAlertAction) {
        words.removeFirst()
        guessWord.text = ""
        currentWord.removeAll()
        if let word = words.first {
            for (_, char) in word.enumerated() {
                self.guessWord.text?.append("?")
                self.currentWord.append(String(char))
            }
        }
        for button in buttons {
            button.isUserInteractionEnabled = true
            button.setTitleColor(.yellow, for: .normal)
        }
    }
    
    func reloadWholeGame(action: UIAlertAction) {
        lives = 7
        loadWords()
        currentWord.removeAll()
        guessWord.text = ""
        for button in buttons {
            button.isUserInteractionEnabled = true
            button.setTitleColor(.yellow, for: .normal)
        }
    }
    
    func loadWords() {
        var firstWord: String?
        DispatchQueue.global(qos: .background).async { [weak self] in
            if let wordUrl = Bundle.main.url(forResource: "words", withExtension: "txt") {
                if let wordsContent = try? String(contentsOf: wordUrl) {
                    var lines = wordsContent.components(separatedBy: "\n")
                    lines.removeLast()
                    lines.shuffle()
                    self?.words = lines
                    firstWord = lines.first
                }
            }
            DispatchQueue.main.async { [weak self] in
                guard let `self` = self else { return }
                guard let unwrappedFirstWord = firstWord else { return }
                print(unwrappedFirstWord)
                for (_, char) in unwrappedFirstWord.enumerated() {
                    self.guessWord.text?.append("?")
                    self.currentWord.append(String(char))
                }
                
                for (i, char) in self.alphabeths.enumerated() {
                    self.buttons[i].setTitle(String(char), for: .normal)
                }
                
            }
        }
        
    }
    
}

