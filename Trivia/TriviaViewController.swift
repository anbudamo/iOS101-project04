//
//  ViewController.swift
//  Trivia
//
//  Created by Mari Batilando on 4/6/23.
//

import UIKit

class TriviaViewController: UIViewController {
  
  @IBOutlet weak var currentQuestionNumberLabel: UILabel!
  @IBOutlet weak var questionContainerView: UIView!
  @IBOutlet weak var questionLabel: UILabel!
  @IBOutlet weak var categoryLabel: UILabel!
  @IBOutlet weak var answerButton0: UIButton!
  @IBOutlet weak var answerButton1: UIButton!
  @IBOutlet weak var answerButton2: UIButton!
  @IBOutlet weak var answerButton3: UIButton!
  
  private var questions = [TriviaQuestion]()
  private var currQuestionIndex = 0
  private var numCorrectQuestions = 0
  
  override func viewDidLoad() {
    super.viewDidLoad()
    addGradient()
    questionContainerView.layer.cornerRadius = 8.0
      
    let question1 = TriviaQuestion(category: "General Knowledge", question: "Sciophobia is the fear of what?", correctAnswer: "Shadows", incorrectAnswers: ["Eating", "Bright lights", "Transportation"])
    let question2 = TriviaQuestion(category: "Art", question: "What year was the Mona Lisa finished?", correctAnswer: "1504", incorrectAnswers: ["1487", "1523", "1511"])
    let question3 = TriviaQuestion(category: "Entertainment: Music", question: "What was Daft Punk's first studio album?", correctAnswer: "Homework", incorrectAnswers: ["Discovery", "Random Access Memories", "Human After All"])
//    let question4 = TriviaQuestion(category: "Entertainment: Video Games", question: "In the indie farming game Stardew Valley which NPC hates the prismatic shard item when received as a gift?", correctAnswer: "Haley", incorrectAnswers: ["Abigail ", "Elliott", "Lewis"])
    let question4 = TriviaQuestion(category: "Entertainment: Television", question: "Like his character in Parks and Recreation, Aziz Ansari was born in South Carolina.", correctAnswer: "True", incorrectAnswers: ["False"])
    let question5 = TriviaQuestion(category: "General Knowledge", question: "The word aprosexia means which of the following?", correctAnswer: "The inability to concentrate on anything", incorrectAnswers: ["The inability to make decisions", "A feverish desire to rip one's clothes off", "The inability to stand up"])
    questions = [question1, question2, question3, question4, question5]
    
    updateQuestion(withQuestionIndex: 0)
    // TODO: FETCH TRIVIA QUESTIONS HERE
  }
  
  private func updateQuestion(withQuestionIndex questionIndex: Int) {
    currentQuestionNumberLabel.text = "Question: \(questionIndex + 1)/\(questions.count)"
    let question = questions[questionIndex]
    questionLabel.text = question.question
    categoryLabel.text = question.category
    let answers = ([question.correctAnswer] + question.incorrectAnswers).shuffled()
    
    answerButton0.isHidden = true
    answerButton1.isHidden = true
    answerButton2.isHidden = true
    answerButton3.isHidden = true
      
    if answers.count > 0 {
      answerButton0.setTitle(answers[0], for: .normal)
      answerButton0.isHidden = false
    }
    if answers.count > 1 {
      answerButton1.setTitle(answers[1], for: .normal)
      answerButton1.isHidden = false
    }
    if answers.count > 2 {
      answerButton2.setTitle(answers[2], for: .normal)
      answerButton2.isHidden = false
    }
    if answers.count > 3 {
      answerButton3.setTitle(answers[3], for: .normal)
      answerButton3.isHidden = false
    }
  }
  
  private func updateToNextQuestion(answer: String) {
    if isCorrectAnswer(answer) {
      numCorrectQuestions += 1
    }
    if (currQuestionIndex < questions.count - 1) {
      showScore(answer: answer)
    }
    currQuestionIndex += 1
    guard currQuestionIndex < questions.count else {
      showFinalScore()
      return
    }
    //updateQuestion(withQuestionIndex: currQuestionIndex)
  }
  
  private func isCorrectAnswer(_ answer: String) -> Bool {
    return answer == questions[currQuestionIndex].correctAnswer
  }
  
  private func showFinalScore() {
    let alertController = UIAlertController(title: "Game over!",
                                            message: "Final score: \(numCorrectQuestions)/\(questions.count)",
                                            preferredStyle: .alert)
    let resetAction = UIAlertAction(title: "Restart", style: .default) { [unowned self] _ in
      currQuestionIndex = 0
      numCorrectQuestions = 0
      updateQuestion(withQuestionIndex: currQuestionIndex)
    }
    alertController.addAction(resetAction)
    present(alertController, animated: true, completion: nil)
  }
    
    private func showScore(answer: String) {
    
    if (isCorrectAnswer(answer)) {
        let alertController = UIAlertController(title: "Your answer was",
                                                  message: "Correct",
                                                  preferredStyle: .alert)
        let resetAction = UIAlertAction(title: "Okay", style: .default) { [unowned self] _ in
            updateQuestion(withQuestionIndex: currQuestionIndex)
        }
        alertController.addAction(resetAction)
        present(alertController, animated: true, completion: nil)
    }
    else {
        let alertController = UIAlertController(title: "Your answer was",
                                                  message: "Wrong",
                                                  preferredStyle: .alert)
        let resetAction = UIAlertAction(title: "Okay", style: .default) { [unowned self] _ in
          updateQuestion(withQuestionIndex: currQuestionIndex)
        }
        alertController.addAction(resetAction)
        present(alertController, animated: true, completion: nil)
    }
  }
  
  private func addGradient() {
    let gradientLayer = CAGradientLayer()
    gradientLayer.frame = view.bounds
    gradientLayer.colors = [UIColor(red: 0.54, green: 0.88, blue: 0.99, alpha: 1.00).cgColor,
                            UIColor(red: 0.51, green: 0.81, blue: 0.97, alpha: 1.00).cgColor]
    gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
    gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
    view.layer.insertSublayer(gradientLayer, at: 0)
  }
  
  @IBAction func didTapAnswerButton0(_ sender: UIButton) {
    showScore(answer: sender.titleLabel?.text ?? "")
    updateToNextQuestion(answer: sender.titleLabel?.text ?? "")
  }
  
  @IBAction func didTapAnswerButton1(_ sender: UIButton) {
    updateToNextQuestion(answer: sender.titleLabel?.text ?? "")
  }
  
  @IBAction func didTapAnswerButton2(_ sender: UIButton) {
    updateToNextQuestion(answer: sender.titleLabel?.text ?? "")
  }
  
  @IBAction func didTapAnswerButton3(_ sender: UIButton) {
    updateToNextQuestion(answer: sender.titleLabel?.text ?? "")
  }
}

