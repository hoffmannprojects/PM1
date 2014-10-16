//
//  ViewController.swift
//  PM1
//
//  Created by Moritz Kuentzler on 13/10/2014.
//  Copyright (c) 2014 PM Productions. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController {
    
    // Game logic class
    var quiz: Quiz!
    
    // Game state variable
    // State 1 refers to the "input" stage: Players pick their answer
    // State 2 refers to the "guess" stage: Players guess which answer has been picked
    var gameState: Int!
    
    // UI Outlets
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var currentNumberOfPointsLabel: UIBarButtonItem!
    @IBOutlet weak var answerOneButton: UIButton!
    @IBOutlet weak var answerTwoButton: UIButton!
    @IBOutlet weak var answerThreeButton: UIButton!
    @IBOutlet weak var answerFourButton: UIButton!
    @IBOutlet weak var nextQuestionButton: UIButton!
    @IBOutlet weak var navBarTitle: UINavigationItem!
    @IBOutlet weak var impressumButton: UIBarButtonItem!
    @IBOutlet weak var categoryLabel: UILabel!
    
    // UI Button Actions
    @IBAction func answerOneButtonPressed(sender: UIButton) {
        relabelPressedAnswerButton(answerOneButton)
    }
    @IBAction func answerTwoButtonPressed(sender: UIButton) {
        relabelPressedAnswerButton(answerTwoButton)
    }
    @IBAction func answerThreeButtonPressed(sender: UIButton) {
        relabelPressedAnswerButton(answerThreeButton)
    }
    @IBAction func answerFourButtonPressed(sender: UIButton) {
        relabelPressedAnswerButton(answerFourButton)
    }
    @IBAction func nextQuestionButtonPressed(sender: UIButton) {
        if quiz.phaseEnded() {
            newPhaseView()
        } else {
            displayNextQuestion()
        }
    }
    @IBAction func impressumButtonPressed(sender: UIBarButtonItem) {
        // Initialize and go to Impressum View
        let impressumView = self.storyboard?.instantiateViewControllerWithIdentifier("Impressum") as ImpressumViewController
        self.navigationController?.pushViewController(impressumView, animated: true)
    }
    
    func answerButtonToAnswer(button: UIButton) -> Int {
        switch button {
        case answerOneButton:
            return 1
        case answerTwoButton:
            return 2
        case answerThreeButton:
            return 3
        case answerFourButton:
            return 4
        default:
            return 0
        }
    }
    
    func answerToAnswerButton(answer: Int) -> UIButton {
        switch answer {
        case 1:
            return answerOneButton
        case 2:
            return answerTwoButton
        case 3:
            return answerThreeButton
        case 4:
            return answerFourButton
        default:
            return answerOneButton
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.autoresizingMask = UIViewAutoresizing.FlexibleHeight
        view.autoresizingMask = UIViewAutoresizing.FlexibleWidth
        
        // Initialize game logic class and state variable
        quiz = Quiz()
        gameState = 1
        
        // Initialize view
        initialView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Game phase views
    func initialView() {
        let firstQuestion: Question = quiz.getCurrentQuestion()
        
        // Set up label values
        currentNumberOfPointsLabel.title = "Punkte: \(quiz.getCurrentPoints())"
        questionLabel.text = "\(firstQuestion.getQuestion())"
        categoryLabel.text = "Kategorie \(quiz.getCategory())"
        
        // Set up button text
        let answers: Array<String> = firstQuestion.getAnswers()
        answerOneButton.setTitle  ("\(answers[0])", forState: UIControlState.Normal)
        answerTwoButton.setTitle  ("\(answers[1])", forState: UIControlState.Normal)
        answerThreeButton.setTitle("\(answers[2])", forState: UIControlState.Normal)
        answerFourButton.setTitle ("\(answers[3])", forState: UIControlState.Normal)
        
        answerOneButton.titleLabel?.adjustsFontSizeToFitWidth   = true
        answerTwoButton.titleLabel?.adjustsFontSizeToFitWidth   = true
        answerThreeButton.titleLabel?.adjustsFontSizeToFitWidth = true
        answerFourButton.titleLabel?.adjustsFontSizeToFitWidth  = true
        
        // Hide, enable and unhide buttons appropriately
        answerOneButton.hidden    = false
        answerTwoButton.hidden    = false
        answerThreeButton.hidden  = false
        answerFourButton.hidden   = false
        
        answerOneButton.enabled   = true
        answerTwoButton.enabled   = true
        answerThreeButton.enabled = true
        answerFourButton.enabled  = true
        
        nextQuestionButton.hidden = true
        
        navBarTitle.title = "Beantworte die Frage!"
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor.redColor()]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict
    }
    
    func newPhaseView() {
        if gameState == 1 {
            // Start second game phase
            gameState = 2
            quiz.goToFirstQuestion()
            initialView()
            
            navBarTitle.title = "Was hat sie gesagt?"
            
        } else if gameState == 2 {
            
            // If all rounds have been played, go to score screen
            if quiz.getRound() >= quiz.getTotalRounds() {
                // Initialize scoring view, pass in quiz object
                let scoringView = self.storyboard?.instantiateViewControllerWithIdentifier("Scoring") as ScoreViewController
                scoringView.quiz = quiz
                
                // Go to scoring view
                self.navigationController?.pushViewController(scoringView, animated: true)
            } else {
                // otherwise, start a new round
                quiz.newRound()
                gameState = 1
                initialView()
            }
        }
    }
    
    func phaseEndedView() {
        
        if gameState == 1 {
            
            questionLabel.text = "Antworten gespeichert! Du kannst das iPhone jetzt weitergeben."
            nextQuestionButton.setTitle("Los geht's!", forState: UIControlState.Normal)
            
        } else if gameState == 2 {
            
            // Change question label text to score
            questionLabel.text = "Du hast \(quiz.getCurrentPoints()) von \(quiz.getTotalQuestionNumber()) Punkten erreicht!"
            
            if quiz.getRound() < quiz.getTotalRounds() {
                nextQuestionButton.setTitle("Nächste Runde", forState: UIControlState.Normal)
            } else {
                nextQuestionButton.setTitle("Zum Endergebnis", forState: UIControlState.Normal)
            }
        }
        
        // Unhide the next question button
        nextQuestionButton.hidden = false
    }
    
    //MARK: Button handlers
    func relabelPressedAnswerButton(pressedButton: UIButton) {
        
        // Hide and disable all the buttons (with the correct one to be unhidden later)
        answerOneButton.hidden    = true
        answerTwoButton.hidden    = true
        answerThreeButton.hidden  = true
        answerFourButton.hidden   = true
        
        answerOneButton.enabled   = false
        answerTwoButton.enabled   = false
        answerThreeButton.enabled = false
        answerFourButton.enabled  = false
        
        if gameState == 1 {
            
            // Lock in the answer, and display confirmation
            quiz.getCurrentQuestion().setRightAnswer(answerButtonToAnswer(pressedButton))
            pressedButton.setTitle("Alles klar!", forState: UIControlState.Normal)
            
        } else if gameState == 2 {
            
            // Display whether the answer was right on the button
            if quiz.checkAnswer(answerButtonToAnswer(pressedButton)) {
                
                pressedButton.setTitle("Richtig!", forState: UIControlState.Normal)
                quiz.addPoints(1)
                currentNumberOfPointsLabel.title = "Punkte: \(quiz.getCurrentPoints())"
                
            } else {
                
                pressedButton.setTitle("Leider nicht.", forState: UIControlState.Normal)
                answerToAnswerButton(quiz.getAnswerNumber()).hidden = false
            }
        }
        
        // Unhide pressed button
        pressedButton.hidden = false
        
        if quiz.phaseEnded() {
            phaseEndedView()
        } else {
            nextQuestionButton.setTitle("Nächste Frage", forState: UIControlState.Normal)
        }
        
        // Unhide the next question button (currently deactivated, timer is doing this)
        // nextQuestionButton.hidden = false
        
        // Start a timer to automatically proceed to the next question or game phase
        var buttonTimer: Timer
        func buttonTimerHandler() {
            if quiz.phaseEnded() {
                //newPhaseView()
            } else {
                displayNextQuestion()
            }
        }
        buttonTimer = Timer(1, buttonTimerHandler)
    }
    
    func displayNextQuestion() {
        // Get next question
        quiz.nextQuestion()
        let newQuestion: Question = quiz.getCurrentQuestion()
        
        // Set question title and category
        questionLabel.text = "\(newQuestion.getQuestion())"
        categoryLabel.text = "Kategorie \(quiz.getCategory())"
        
        // Set answer titles
        let answers = newQuestion.getAnswers()
        answerOneButton.setTitle  ("\(answers[0])", forState: UIControlState.Normal)
        answerTwoButton.setTitle  ("\(answers[1])", forState: UIControlState.Normal)
        answerThreeButton.setTitle("\(answers[2])", forState: UIControlState.Normal)
        answerFourButton.setTitle ("\(answers[3])", forState: UIControlState.Normal)
        
        // Unhide, enable and hide buttons appropriately
        answerOneButton.hidden    = false
        answerTwoButton.hidden    = false
        answerThreeButton.hidden  = false
        answerFourButton.hidden   = false

        answerOneButton.enabled   = true
        answerTwoButton.enabled   = true
        answerThreeButton.enabled = true
        answerFourButton.enabled  = true
        
        nextQuestionButton.hidden = true
    }

}