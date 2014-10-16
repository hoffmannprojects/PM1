//
//  question.swift
//  PM1
//
//  Created by Moritz Kuentzler on 14/10/2014.
//  Copyright (c) 2014 PM Productions. All rights reserved.
//

import Foundation

class Question {
    var questionText: String
    var answerTexts: Array<String>
    var displayedAnswers: Array<String>
    var correctAnswer: Int?
    var category: Int
    
    init(question: String, answers: Array<String>, category: Int) {
        self.questionText = question
        self.answerTexts = answers
        self.category = category
        self.displayedAnswers = []
    }
    
    func drawAnswers() {
        // Randomly select the answers to be displayed from the answer pool.
        var randomNumber: Int
        var randomAnswer: String
        
        for i in 1...4 { // Draw four answers
            randomNumber = Int(arc4random_uniform(UInt32(answerTexts.count)))
            randomAnswer = answerTexts[randomNumber]
            displayedAnswers.append(randomAnswer)
            answerTexts.removeAtIndex(randomNumber)
        }
        
        // For subsequent rounds, add the drawn answers back to the answerText array
        answerTexts.extend(displayedAnswers)
    }
    
    func getQuestion() -> String {
        return questionText
    }
    
    func getAnswers() -> Array<String> {
        if displayedAnswers == [] {
            drawAnswers()
        }
        return displayedAnswers
    }
    
    func getAnswerNumber() -> Int? {
        return correctAnswer
    }
    
    func setRightAnswer(answerNumber: Int) {
        correctAnswer = answerNumber
    }
    
    func getCategoryNumber() -> Int {
        return category
    }
}