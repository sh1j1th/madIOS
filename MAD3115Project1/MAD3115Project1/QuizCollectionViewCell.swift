//
//  QuizCollectionViewCell.swift
//  MAD3115Project1
//
//  Created by Shijith K  on 23/06/22.
//

import UIKit

enum SelectedOption {
    case opt1
    case opt2
    case opt3
    case opt4
}
class QuizCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var option1: UILabel!
    @IBOutlet weak var option2: UILabel!
    @IBOutlet weak var option3: UILabel!
    @IBOutlet weak var option4: UILabel!
    
    @IBOutlet weak var option1Control: UIControl!
    @IBOutlet weak var option2Control: UIControl!
    @IBOutlet weak var option3Control: UIControl!
    @IBOutlet weak var option4Control: UIControl!
    private var correctAnswer: String?
    
    var setValues: Questions? {
        didSet {
            questionLabel.text = setValues?.question
            option1.text = setValues?.option1
            option2.text = setValues?.option2
            option3.text = setValues?.option3
            option4.text = setValues?.option4
            
            correctAnswer = setValues?.correct_answer
        }
    }
    
    override func prepareForReuse() {
        updateBorder(myView: option1Control)
        updateBorder(myView: option2Control)
        updateBorder(myView: option3Control)
        updateBorder(myView: option4Control)
    }
    
    func changeBorder(selectedOption: SelectedOption) {
        switch selectedOption {
        case .opt1:
            updateBorder(myView: option1Control, borderWidth: 4)
            updateBorder(myView: option2Control)
            updateBorder(myView: option3Control)
            updateBorder(myView: option4Control)
        case .opt2:
            updateBorder(myView: option2Control, borderWidth: 4)
            updateBorder(myView: option1Control)
            updateBorder(myView: option3Control)
            updateBorder(myView: option4Control)
        case .opt3:
            updateBorder(myView: option3Control, borderWidth: 4)
            updateBorder(myView: option2Control)
            updateBorder(myView: option1Control)
            updateBorder(myView: option4Control)
        case .opt4:
            updateBorder(myView: option4Control, borderWidth: 4)
            updateBorder(myView: option2Control)
            updateBorder(myView: option3Control)
            updateBorder(myView: option1Control)
        }
    }
    
    func updateBorder(myView: UIView, borderWidth: CGFloat = 0) {
        myView.layer.borderWidth = borderWidth
        myView.layer.borderColor = UIColor.white.cgColor
    }
    
    var selectedOption: ((_ selectedAnswer: Bool) -> Void)?
    
    @IBAction func onClickOption1(_ sender: Any) {
        var isCorrect = false
        if correctAnswer == setValues?.option1 {
            isCorrect = true
        }
        selectedOption?(isCorrect)
        changeBorder(selectedOption: .opt1)
    }
    @IBAction func onClickOption2(_ sender: Any) {
        var isCorrect = false
        if correctAnswer == setValues?.option2 {
            isCorrect = true
        }
        selectedOption?(isCorrect)
        changeBorder(selectedOption: .opt2)
    }
    @IBAction func onClickOption3(_ sender: Any) {
        var isCorrect = false
        if correctAnswer == setValues?.option3 {
            isCorrect = true
        }
        selectedOption?(isCorrect)
        changeBorder(selectedOption: .opt3)
    }
    @IBAction func onClickOption4(_ sender: Any) {
        var isCorrect = false
        if correctAnswer == setValues?.option4 {
            isCorrect = true
        }
        selectedOption?(isCorrect)
        changeBorder(selectedOption: .opt4)
    }
    
}
