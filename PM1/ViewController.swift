//
//  ViewController.swift
//  PM1
//
//  Created by Moritz Kuentzler on 13/10/2014.
//  Copyright (c) 2014 PM Productions. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

class QuestionViewController: UIViewController {
    
    // Instance variables
    var arrayOfQuestions = []
    var numberOfLives = 3
    var numberOfPoints = 0
    var currentQuestion = 0
    var questionCorrectAnswer = 1
    
    // UI Outlets
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var currentNumberOfPointsLabel: UILabel!
    @IBOutlet weak var currentNumberOfLivesLabel: UILabel!
    @IBOutlet weak var answerOneButton: UIButton!
    @IBOutlet weak var answerTwoButton: UIButton!
    @IBOutlet weak var answerThreeButton: UIButton!
    @IBOutlet weak var answerFourButton: UIButton!
    @IBOutlet weak var nextQuestionButton: UIButton!
    @IBOutlet weak var startOverButton: UIButton!
    
    // UI Button Actions
    @IBAction func answerOneButtonPressed(sender: UIButton) {
        relabelPressedAnswerButton(checkAnswer(questionCorrectAnswer, answerNumber: 1), pressedButton: answerOneButton)
    }
    @IBAction func answerTwoButtonPressed(sender: UIButton) {
        relabelPressedAnswerButton(checkAnswer(questionCorrectAnswer, answerNumber: 2), pressedButton: answerTwoButton)
    }
    @IBAction func answerThreeButtonPressed(sender: UIButton) {
        relabelPressedAnswerButton(checkAnswer(questionCorrectAnswer, answerNumber: 3), pressedButton: answerThreeButton)
    }
    @IBAction func answerFourButtonPressed(sender: UIButton) {
        relabelPressedAnswerButton(checkAnswer(questionCorrectAnswer, answerNumber: 4), pressedButton: answerFourButton)
    }
    @IBAction func nextQuestionButtonPressed(sender: UIButton) {
        if finishedGame(currentQuestion) {
            
        } else {
            nextQuestion()
        }
    }
    @IBAction func startOverButtonPressed(sender: UIButton) {
        initialState()
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //MARK: Questions
        let questionOne = question("What year did WWII start?", answerOne: "1939", answerTwo: "1940", answerThree: "1941", answerFour: "1942", correctAnswer: 1)
        let questionTwo = question("What day was D-Day?", answerOne: "June 6, 1944", answerTwo: "June 16, 1944", answerThree: "June 26, 1944", answerFour: "June 16, 1943", correctAnswer: 1)
        let questionThree = question("What country was first invaded by Germany?", answerOne: "France", answerTwo: "Belgium", answerThree: "Poland", answerFour: "Russia", correctAnswer: 3)
        let questionFour = question("Which article of the Weimar Constitution granted Hitler emergency powers? ", answerOne: "Article 26", answerTwo: "Article 86", answerThree: "Article 3", answerFour: "Article 48", correctAnswer: 4)
        let questionFive = question("Who was the leader of the Soviet Union during World War II?", answerOne: "Lenin", answerTwo: "Trotsky", answerThree: "Stalin", answerFour: "Khruschev", correctAnswer: 3)
        let questionSix = question("The main Axis powers of WWII Consisted of: Germany, _____, _____", answerOne: "Italy, Japan", answerTwo: "Russia, Japan", answerThree: "Romania, Russia", answerFour: "Japan, Romania", correctAnswer: 1)
        
        // Add all questions to the array
        arrayOfQuestions = [questionOne, questionTwo, questionThree, questionFour, questionFive, questionSix]
        
        // Initialize the app
        initialState()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Adding Question Function
    // Declare question function
    func question (question:String, answerOne:String, answerTwo:String, answerThree:String, answerFour:String, correctAnswer:Int) ->  NSArray {
        
        // Set the question
        var quizQuestion = question
        
        // Set the answers and declare the right one
        var firstAnswer = answerOne
        var secondAnswer = answerTwo
        var thirdAnswer = answerThree
        var fourthAnswer = answerFour
        var rightAnswer = correctAnswer
        
        // Add all the questions and answers to an array
        let questionAnswerArray = [quizQuestion, firstAnswer, secondAnswer, thirdAnswer, fourthAnswer, rightAnswer]
        return questionAnswerArray
    }
    
    func initialState() {
        // Setting the inital values
        numberOfLives = 3
        numberOfPoints = 0
        currentQuestion = 0
        questionCorrectAnswer = 1
        
        var firstQuestion: AnyObject = arrayOfQuestions[currentQuestion]
        
        // Setting up the label values
        currentNumberOfLivesLabel.text = "\(numberOfLives)"
        currentNumberOfPointsLabel.text = "\(numberOfPoints)"
        questionLabel.text = "\(firstQuestion[0])"
        
        // Setting up the button text
        answerOneButton.setTitle  ("\(firstQuestion[1])", forState: UIControlState.Normal)
        answerTwoButton.setTitle  ("\(firstQuestion[2])", forState: UIControlState.Normal)
        answerThreeButton.setTitle("\(firstQuestion[3])", forState: UIControlState.Normal)
        answerFourButton.setTitle ("\(firstQuestion[4])", forState: UIControlState.Normal)
        
        // Hide and unhide buttons appropriately
        answerOneButton.hidden    = false
        answerTwoButton.hidden    = false
        answerThreeButton.hidden  = false
        answerFourButton.hidden   = false
        nextQuestionButton.hidden = true
        startOverButton.hidden    = true
    }
    
    func checkAnswer(correctAnswerIdx: Int, answerNumber: Int) -> Bool {
        // Hide all the buttons (with the correct one to be unhidden later)
        answerOneButton.hidden   = true
        answerTwoButton.hidden   = true
        answerThreeButton.hidden = true
        answerFourButton.hidden  = true
        
        // Unhide the next question button
        nextQuestionButton.hidden = false
        
        // Check if answer is right
        if correctAnswerIdx == answerNumber {
            return true
        } else {
            return false
        }
    }
    
    func relabelPressedAnswerButton(isItRight: Bool, pressedButton: UIButton) {
        // Display whether the answer was right on the button
        if isItRight {
            pressedButton.setTitle("Richtig!", forState: UIControlState.Normal)
            numberOfPoints += 1
            currentNumberOfPointsLabel.text = "\(numberOfPoints)"
        } else {
            pressedButton.setTitle("Leider nicht", forState: UIControlState.Normal)
            numberOfLives -= 1
            currentNumberOfLivesLabel.text = "\(numberOfLives)"
            gameOver(numberOfLives)
        }
        
        pressedButton.hidden = false
        
    }
    
    func nextQuestion() {
        // Get next question index
        currentQuestion += 1
        
        // Get next question from arrayOfQuestions
        var newQuestion: AnyObject = arrayOfQuestions[currentQuestion]
        questionCorrectAnswer = newQuestion[5].integerValue
        
        // Set answer titles
        answerOneButton.setTitle  ("\(newQuestion[1])", forState: UIControlState.Normal)
        answerTwoButton.setTitle  ("\(newQuestion[2])", forState: UIControlState.Normal)
        answerThreeButton.setTitle("\(newQuestion[3])", forState: UIControlState.Normal)
        answerFourButton.setTitle ("\(newQuestion[4])", forState: UIControlState.Normal)
        
        // Set question title
        questionLabel.text = "\(newQuestion[0])"
        
        // Unhide and hide buttons appropriately
        answerOneButton.hidden    = false
        answerTwoButton.hidden    = false
        answerThreeButton.hidden  = false
        answerFourButton.hidden   = false
        nextQuestionButton.hidden = true
    }
    
    func gameOver(lives: Int) {
        if lives <= 0 {
            // Set up the alert view
            var alert = UIAlertController(title: "Game Over", message: "You lost all three lives", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Start again", style: UIAlertActionStyle.Default, handler: {action in self.initialState()}))
            
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    func finishedGame(currentQuestionNumber: Int) -> Bool {
        if currentQuestionNumber == arrayOfQuestions.count - 1 {
            // Hide and unhide buttons
            answerOneButton.hidden    = true
            answerTwoButton.hidden    = true
            answerThreeButton.hidden  = true
            answerFourButton.hidden   = true
            
            startOverButton.hidden    = false
            nextQuestionButton.hidden = true

            // Change question label text to score
            questionLabel.text = "Congratulations, you finished with a score of \(numberOfPoints) out of \(arrayOfQuestions.count) possible!"
            
            return true
        } else {
            return false
        }
    }
}
