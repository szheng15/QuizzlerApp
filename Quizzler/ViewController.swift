//
//  ViewController.swift
//  Quizzler
//
//  Created by Angela Yu on 25/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //Place your instance variables here
    let allQuestions = QuestionBank()
    var questionNumber : Int = 0
    var pickAnswer:Bool = false
    var score:Int = 0
    
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextQuestion()
    }


    @IBAction func answerPressed(_ sender: AnyObject) {
        if sender.tag == 1{
            pickAnswer = true
        }
        else if sender.tag == 2{
            pickAnswer = false
        }
        checkAnswer()
        questionNumber += 1
        nextQuestion()
    }
    
    
    func updateUI() {
        scoreLabel.text = "Score: \(score)"
        progressLabel.text = "\(questionNumber+1) / \(allQuestions.list.count)"
        progressBar.frame.size.width = (view.frame.size.width / CGFloat(allQuestions.list.count)) * CGFloat(questionNumber + 1)
    }
    

    func nextQuestion() {
        if questionNumber <= allQuestions.list.count-1{
            questionLabel.text = allQuestions.list[questionNumber].questionText
            updateUI()
        }
        else{
            print("End of Quiz!")
            let alert = UIAlertController(title: "Awesome!!", message: "You've finished all problems!!\n Do you want to start again?", preferredStyle: .alert)
            
            let restartAction = UIAlertAction(title: "Restart", style: .default, handler: {
                (UIAlertAction) in self.startOver()
            })
            
            alert.addAction(restartAction)
            present(alert,animated: true, completion: nil)
        }
    }
    
    
    func checkAnswer() {
        let correctAnswer = allQuestions.list[questionNumber].answer
        if correctAnswer == pickAnswer {
            ProgressHUD.showSuccess("Correct!!")
            score += 1
        }
        else{
            ProgressHUD.showError("Wrong!!")
        }
    }
    
    
    func startOver() {
       questionNumber = 0
        score = 0
        nextQuestion()
    }
    

    
}
