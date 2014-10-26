//
//  pm1.swift
//  PM1
//
//  Created by Moritz Kuentzler on 14/10/2014.
//  Copyright (c) 2014 PM Productions. All rights reserved.
//

import Foundation

class Quiz {
    
    // Instance variables
    var allQuestions: Array<Question> = []
    var categories: Array<String> = []
    var instanceQuestions: Array<Question> = []
    var round: Int = 0
    var pointArray: Array<Int> = [0]
    var currentQuestionNumber: Int = 0
    var totalRounds: Int = 2
    
    //MARK: Methods for initialization and reset
    
    init() {
        // Initialize category array
        categories = readCategories()
        println(categories)
        
        // Initialize array containing all questions
        allQuestions = readQuestions()
        
        // Draw the questions for the current round
        instanceQuestions = drawQuestions()
    }
    
    func newRound() {
        // Initialize a new round
        
        round += 1
        pointArray.append(0)
        currentQuestionNumber = 0
        
        // Draw new questions
        instanceQuestions = drawQuestions()
    }
    
    func reset() {
        // Reset game state values
        round = 0
        pointArray = [0]
        currentQuestionNumber = 0
        
        // Draw new questions
        instanceQuestions = drawQuestions()
    }
    
    func readCategories() -> Array<String> {
        let path = NSBundle.mainBundle().pathForResource("categoryList", ofType: "txt")
        var possibleContent = String(contentsOfFile: path!, encoding:NSUTF8StringEncoding, error: nil)
        
        if let content = possibleContent {
            return content.componentsSeparatedByString("\n")
        } else {
            return []
        }
    }
    
    func readQuestions() -> Array<Question> {
        // Read in questions from questionList.txt
        var questionList: Array<Question> = []
        
        let path = NSBundle.mainBundle().pathForResource("questionList", ofType: "txt")
        var possibleContent = String(contentsOfFile: path!, encoding:NSUTF8StringEncoding, error: nil)

        if let content = possibleContent {
            var rawQuestions = content.componentsSeparatedByString("\n")
            
            for line in rawQuestions {
                var contents = line.componentsSeparatedByString(";")
                var category: Int = contents.removeAtIndex(0).toInt()!
                var questionText = contents.removeAtIndex(0)
                var newQuestion = Question(question: questionText, answers: contents, category: category)
               questionList.append(newQuestion)
            }
        }

        return questionList
    }
    
    func drawQuestions(numberOfQuestions: Int = 3) -> Array<Question> {
        // Pick questions to be used in the current round, drawn from the allQuestion array without replacement
        var randomNumber: Int
        var randomQuestion: Question
        var questionList: Array<Question> = []
        
        for i in 1...numberOfQuestions {
            randomNumber = Int(arc4random_uniform(UInt32(allQuestions.count)))
            randomQuestion = allQuestions[randomNumber]
            questionList.append(randomQuestion)
            allQuestions.removeAtIndex(randomNumber)
        }
        
        // For subsequent rounds, add the drawn questions back to the all question array
        allQuestions.extend(questionList)
        
        return questionList
    }
    
    //MARK: Getter and setter methods
    
    func getCurrentQuestion() -> Question {
        return instanceQuestions[currentQuestionNumber]
    }
    
    func goToFirstQuestion() {
        currentQuestionNumber = 0
    }
    
    func getAnswerNumber() -> Int {
        return getCurrentQuestion().getAnswerNumber()!
    }
    
    func checkAnswer(answerNumber: Int) -> Bool {
        // Check if answer is right
        return getCurrentQuestion().getAnswerNumber() == answerNumber
    }
    
    func getCurrentPoints() -> Int {
        return pointArray[round]
    }
    
    func getPointsFromRound(whichRound: Int) -> Int {
        return pointArray[whichRound]
    }
    
    func getTotalPoints() -> Int {
        var totalPoints: Int = 0
        for point in pointArray {
            totalPoints += point
        }
        return totalPoints
    }
    
    func addPoints(pointsToAdd: Int) {
        pointArray[round] += pointsToAdd
    }
    
    func getTotalQuestionNumber() -> Int {
        return instanceQuestions.count
    }
    
    func nextQuestion() {
        currentQuestionNumber += 1
    }
    
    func phaseEnded() -> Bool {
        return currentQuestionNumber == instanceQuestions.count - 1
    }
    
    func getRound() -> Int {
        // +1 since we internally use zero-based indexing for round.
        return round + 1
    }
    
    func getTotalRounds() -> Int {
        return totalRounds
    }
    
    func getCategory() -> String {
        return categories[getCurrentQuestion().getCategoryNumber()]
    }
}