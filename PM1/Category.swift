//
//  Category.swift
//  PM1
//
//  Created by Moritz Kuentzler on 24/11/2014.
//  Copyright (c) 2014 PM Productions. All rights reserved.
//

import Foundation

class Category: Printable {
    var allQuestions: Array<Question> = []
    var categoryName: String = ""
    var instanceQuestions: Array<Question> = []
    
    var description: String {get {return getCategoryName()}}
    
    //MARK: Methods for initialization and reset
    
    init(category: String, questions: Array<Question> = []) {
        self.categoryName = category
        self.allQuestions = questions
    }
    
    func addQuestion(question: Question) -> () {
        self.allQuestions.append(question)
    }
    
    func drawQuestions(numberOfQuestions: Int = 3) {
        // Pick questions to be used in the current round, drawn from the allQuestion array without replacement
        var randomNumber: Int
        var randomQuestion: Question

        // Reset instance questions
        instanceQuestions = []
        
        for i in 1...numberOfQuestions {
            randomNumber = Int(arc4random_uniform(UInt32(allQuestions.count)))
            randomQuestion = allQuestions[randomNumber]
            instanceQuestions.append(randomQuestion)
            allQuestions.removeAtIndex(randomNumber)
        }
        
        // For subsequent rounds, add the drawn questions back to the all question array
        allQuestions.extend(instanceQuestions)
    }
    
    //MARK: Getter and setter methods
    
    func getCurrentQuestion(currentQuestionNumber: Int) -> Question {
        return instanceQuestions[currentQuestionNumber]
    }
    
    func getCategoryName() -> String {
        return self.categoryName
    }
}