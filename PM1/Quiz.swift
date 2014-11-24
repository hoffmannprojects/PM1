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
    var allCategories: Array<Category> = []
    var instanceQuestions: Array<Question> = []
    var round: Int = 0
    var pointArray: Array<Int> = [0]
    var currentQuestionNumber: Int = 0
    var currentCategoryNumber: Int = 0
    var totalRounds: Int = 2
    var questionsPerRound: Int = 3
    
    //MARK: Methods for initialization and reset
    
    init() {
        // Initialize category array
        allCategories = readCategories()
        
        // Initialize array containing all questions
        allQuestions = readQuestions()
        
        // Put the questions into their respective categories
        sortQuestionsIntoCategories(allQuestions)
        
        // Draw the questions for the current round
        //instanceQuestions = drawQuestions()
        
        // Go to random category
        pickCategory(Int(arc4random_uniform(UInt32(allCategories.count))))
    }
    
    func newRound() {
        // Initialize a new round
        
        round += 1
        pointArray.append(0)
        currentQuestionNumber = 0
        
        // Draw new questions
        instanceQuestions = drawQuestions(numberOfQuestions: questionsPerRound)
        
        // Go to random category
        pickCategory(Int(arc4random_uniform(UInt32(allCategories.count))))
    }
    
    func reset() {
        // Reset game state values
        round = 0
        pointArray = [0]
        currentQuestionNumber = 0
        
        // Draw new questions
        instanceQuestions = drawQuestions()
    }
    
    func readCategories() -> Array<Category> {
        var categoryList : Array<Category> = []
        
        let path = NSBundle.mainBundle().pathForResource("categoryList", ofType: "txt")
        var possibleContent = String(contentsOfFile: path!, encoding:NSUTF8StringEncoding, error: nil)
        
        if let content = possibleContent {
            var rawCategories = content.componentsSeparatedByString("\n")
            
            for line in rawCategories {
                var newCategory: Category
                newCategory = Category(category: line)
                categoryList.append(newCategory)
            }
        }
        
        return categoryList
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
                var category: Int = contents.removeAtIndex(0).toInt()! - 1 // We use zero-based indexing internally for categories
                var questionText = contents.removeAtIndex(0)
                var newQuestion = Question(question: questionText, answers: contents, category: category)
               questionList.append(newQuestion)
            }
        }

        return questionList
    }
    
    func sortQuestionsIntoCategories(questions: Array<Question>) -> () {
        for question in questions {
            allCategories[question.getCategoryNumber()].addQuestion(question)
        }
    }
    
    func pickCategory(categoryNumber: Int) -> () {
        currentCategoryNumber = categoryNumber
        getCurrentCategory().drawQuestions(numberOfQuestions: questionsPerRound)
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
    
    func getCurrentCategory() -> Category {
        return allCategories[currentCategoryNumber]
    }
    
    func getCurrentQuestion() -> Question {
        //return instanceQuestions[currentQuestionNumber]
        return getCurrentCategory().getCurrentQuestion(currentQuestionNumber)
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
        return questionsPerRound
    }
    
    func nextQuestion() {
        currentQuestionNumber += 1
    }
    
    func phaseEnded() -> Bool {
        //return currentQuestionNumber == instanceQuestions.count - 1
        return currentQuestionNumber == questionsPerRound - 1
    }
    
    func getRound() -> Int {
        // +1 since we internally use zero-based indexing for round.
        return round + 1
    }
    
    func getTotalRounds() -> Int {
        return totalRounds
    }
    
    func getCategory() -> Category {
        return allCategories[getCurrentQuestion().getCategoryNumber()]
    }
}