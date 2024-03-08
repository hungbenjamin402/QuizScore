//
//  Question.swift
//  QuizScore
//
//  Created by benjamin on 3/4/24.
//

import Foundation

struct Question {
    let question: String
    let correctAnswer: String
    
    static let allQuestions: [Question] = [
        Question(question: "All spiders have eight eyes", correctAnswer: "False"),
        Question(question: "A group of crows is called a murder", correctAnswer: "True"),
        Question(question: "Sharks can blink with both eyes", correctAnswer: "False"),
        Question(question: "Dolphins sleep with one eye open", correctAnswer: "True"),
        Question(question: "Ostriches can run faster than horses", correctAnswer: "True"),
        Question(question: "Bats are mammals", correctAnswer: "True"),
    ]
}
