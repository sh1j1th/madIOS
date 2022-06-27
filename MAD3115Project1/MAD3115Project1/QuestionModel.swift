//
//  File.swift
//  MAD3115Project1
//
//  Created by Shijith K  on 23/06/22.
//

import Foundation

struct QuestionModel: Codable {
    var questions: [Questions]?
}

struct Questions: Codable {
    var correct_answer: String?
    var option1: String?
    var option2: String?
    var option3: String?
    var option4: String?
    var question: String?
}
