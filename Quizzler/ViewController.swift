//
//  ViewController.swift
//  Quizzler
//
//  Created by Konstantin Konstantinov on 11/8/17.
//  Copyright © 2017 Konstantin Konstantinov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var allQuestions = QuestionBank()
    var currentQuestionNumber: Int? {
        didSet {
            if let currentQuestionNumber = currentQuestionNumber {
                questionLabel.text = allQuestions.list[currentQuestionNumber].text
            }
        }
    }
    var currentAnswer: Bool?
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentQuestionNumber = 0
    }


    @IBAction func answerPressed(_ sender: AnyObject) {
        if let tag = sender.tag {
            currentAnswer = (tag == 1) ? true : false
        }
        checkAnswer()
        nextQuestion()
    }
    
    
    func updateUI() {
        
    }
    

    func nextQuestion() {
        if let currentQuestionNumberUnwrapped = currentQuestionNumber,
            currentQuestionNumberUnwrapped + 1 < allQuestions.list.count {
            currentQuestionNumber = currentQuestionNumberUnwrapped + 1
        } else {
            let alert = UIAlertController(title: "Awesome", message: "You've finished all the questions, do you want to start over?", preferredStyle: .alert)
            let restartAction = UIAlertAction(title: "Restart", style: .default, handler: { [weak self] (UIAlertAction) in
                self?.startOver()
            })
            
            alert.addAction(restartAction)
            
            present(alert, animated: true)
        }
    }
    
    
    func checkAnswer() {
        if let currentAnswer = currentAnswer,
            let currentQuestionNumber = currentQuestionNumber,
            allQuestions.list[currentQuestionNumber].correctAnswer == currentAnswer {
            print("You are right!")
        } else {
            print("Wrong!")
        }
    }
    
    
    func startOver() {
        currentQuestionNumber = 0
    }
    
}
