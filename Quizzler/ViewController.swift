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
    var currentQuestionNumber = 0
    var currentAnswer: Bool?
    var score = 0
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentQuestionNumber = 0
        updateUI()
    }

    @IBAction func answerPressed(_ sender: AnyObject) {
        if let tag = sender.tag {
            currentAnswer = (tag == 1) ? true : false
        }
        checkAnswer()
        nextQuestion()
    }
    
    func updateUI() {
        questionLabel.text = allQuestions.list[currentQuestionNumber].text
        scoreLabel.text = "Score: \(score)"
        progressLabel.text = "\(currentQuestionNumber + 1) / \(allQuestions.list.count)"
        progressBar.frame.size.width = view.frame.size.width / CGFloat(allQuestions.list.count) * CGFloat(currentQuestionNumber + 1)
    }

    func nextQuestion() {
        if currentQuestionNumber + 1 < allQuestions.list.count {
            currentQuestionNumber = currentQuestionNumber + 1
        } else {
            let alert = UIAlertController(title: "Awesome", message: "You've finished all the questions, do you want to start over?", preferredStyle: .alert)
            let restartAction = UIAlertAction(title: "Restart", style: .default, handler: { [weak self] (UIAlertAction) in
                self?.startOver()
            })
            
            alert.addAction(restartAction)
            
            present(alert, animated: true)
        }
        
        updateUI()
    }
    
    func checkAnswer() {
        if let currentAnswer = currentAnswer,
            allQuestions.list[currentQuestionNumber].correctAnswer == currentAnswer {
            ProgressHUD.showSuccess("Correct")
            score += 1
        } else {
            ProgressHUD.showError("Wrong!")
        }
    }
    
    func startOver() {
        currentQuestionNumber = 0
        score = 0
        updateUI()
    }

}
