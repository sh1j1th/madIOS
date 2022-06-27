//
//  QuizViewController.swift
//  MAD3115Project1
//
//  Created by Shijith K  on 23/06/22.
//

import UIKit

class QuizViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var questions = [Questions(correct_answer: "80km/h", option1: "70km/h", option2: "50km/h", option3: "80km/h", option4: "60km/h", question: "You are prohibited from driving on 400-series highways where speed limits _______ if you are driving with a G1 license."),
                     Questions(correct_answer: "7", option1: "5", option2: "3", option3: "6", option4: "7", question: "If you don't stop for the police, how many points can you get on your license?"),
                     Questions(correct_answer: "Gear down and use the motor to assist in braking", option1: "Disengage the clutch and coast", option2: "Place the gear shift in neutral", option3: "Gear down and use the motor to assist in braking", option4: "Turn off the ignition", question: "What is a good and safe driving practice wile driving down a steep hill?")]
    
    var answerSelected = false
    var isCorrectAnswer = false
    var points = 0
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

    @IBAction func onClickPrev(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func onClickNext(_ sender: UIButton) {
        if !answerSelected {
            //alert
            let alert = UIAlertController(title: "Select One Option", message: "Please select one option before moving to the next question.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
            return
        }
        answerSelected = false
        if isCorrectAnswer {
            points += 1
        }
        
        if index < (self.questions.count ?? 0) - 1 {
            index += 1
            collectionView.scrollToItem(at: IndexPath(row: index, section: 0), at: .right, animated: true)
        } else {
            //to result
            guard let vc = storyboard?.instantiateViewController(withIdentifier: "ResultViewController") as? ResultViewController else {return}
            vc.result = points
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension QuizViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return questions.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "QuizCollectionViewCell", for: indexPath) as? QuizCollectionViewCell else {return QuizCollectionViewCell()}
        cell.option1Control.layer.cornerRadius = 10
        cell.option2Control.layer.cornerRadius = 10
        cell.option3Control.layer.cornerRadius = 10
        cell.option4Control.layer.cornerRadius = 10
        cell.setValues = questions[indexPath.row]
        cell.selectedOption = {[weak self] isCorrect in
            self?.answerSelected = true
            self?.isCorrectAnswer = isCorrect
        }
        return cell
    }
}


