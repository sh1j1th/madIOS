//
//  ResultViewController.swift
//  MAD3115Project1
//
//  Created by Shijith K  on 23/06/22.
//

import UIKit

class ResultViewController: UIViewController {

    @IBOutlet weak var userScore: UILabel!
    @IBOutlet weak var totalScore: UILabel!
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var retakeQuiz: UIButton!
    
    var result = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        showMessage()
    }
    
    @IBAction func onClickRetakeQuiz(_ sender: UIButton) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "QuizViewController") as? QuizViewController else {return}
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func onClickHome(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func showMessage(){
        switch result {
        case 0:
            message.text = "Please try again!"
            message.textColor = .white
            userScore.text = "\(result)"
        case 1:
            message.text = "Good job!"
            message.textColor = .systemYellow
            userScore.text = "\(result)"
        case 2:
            message.text = "Very good!"
            message.textColor = .systemYellow
            userScore.text = "\(result)"
        case 3:
            message.text = "Excellent work!"
            message.textColor = .systemGreen
            retakeQuiz.isHidden = true
            userScore.text = "\(result)"
        default:
            message.text = "Error occured, please try again!"
            message.textColor = .systemRed
            userScore.text = "0"
        }
    }
}
