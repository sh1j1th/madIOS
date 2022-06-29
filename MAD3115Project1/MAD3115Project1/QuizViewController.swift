//
//  QuizViewController.swift
//  MAD3115Project1
//
//  Created by Shijith K  on 23/06/22.
//

import UIKit

class QuizViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var previousNumber: [Int] = []
    
    var questions = [Questions(correct_answer: "80km/h", option1: "70km/h", option2: "50km/h", option3: "80km/h", option4: "60km/h", question: "You are prohibited from driving on 400-series highways where speed limits _______ if you are driving with a G1 license."),
                     Questions(correct_answer: "7", option1: "5", option2: "3", option3: "6", option4: "7", question: "If you don't stop for the police, how many points can you get on your license?"),
                     Questions(correct_answer: "Gear down and use the motor to assist in braking", option1: "Disengage the clutch and coast", option2: "Place the gear shift in neutral", option3: "Gear down and use the motor to assist in braking", option4: "Turn off the ignition", question: "What is a good and safe driving practice wile driving down a steep hill?"),
                     Questions(correct_answer: "Never", option1: "Never", option2: "To a person who needs some ID", option3: "To a person who is learning to drive", option4: "To a person who has lost their own license", question: "When are you allowed to loan your license to others?"),
                     Questions(correct_answer: "Close to the right side of the road", option1: "The lane approaching from the left", option2: "Close to the centre line of the roadway", option3: "Close to the left side of the roadway", option4: "Close to the right side of the road", question: "If you plan on making a right-hand turn, which lane of traffic should you be in?"),
                     Questions(correct_answer: "Any of these", option1: "If they fail to attend for re-examination", option2: "Any of these", option3: "If they don't pay a traffic fine when ordered by court", option4: "If they don't pay the reinstatement fee", question: "In what situation could a driver lose their license?")
    ].shuffled()
    
    var answerSelected = false
    var isCorrectAnswer = false
    var points = 0
    var index = 0
    var questionsCount = 3
    
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
        
        if index < (questionsCount - 1) {
            index += 1
            collectionView.isPagingEnabled = false
            collectionView.scrollToItem(at: IndexPath(row: randomNumber(), section: 0), at: .left, animated: false)
            collectionView.isPagingEnabled = true
        } else {
            //to result
            guard let vc = storyboard?.instantiateViewController(withIdentifier: "ResultViewController") as? ResultViewController else {return}
            vc.result = points
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    //MARK: - random number generator
    func randomNumber() -> Int {
        var randomNumber = Int.random(in: 0..<questions.count)
        while previousNumber.contains(randomNumber)  {
            randomNumber = Int.random(in: 0..<questions.count)
        }
        previousNumber.append(randomNumber)
        print("prev", previousNumber)
        return randomNumber
    }
}

extension QuizViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return questions.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("Indexpath", indexPath.row)
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "QuizCollectionViewCell", for: indexPath) as? QuizCollectionViewCell else {return QuizCollectionViewCell()}
        cell.option1Control.layer.cornerRadius = 10
        cell.option2Control.layer.cornerRadius = 10
        cell.option3Control.layer.cornerRadius = 10
        cell.option4Control.layer.cornerRadius = 10
        cell.setValues = questions[indexPath.row]
        cell.setProgress = (index + 1, questionsCount)
        cell.selectedOption = {[weak self] isCorrect in
            self?.answerSelected = true
            self?.isCorrectAnswer = isCorrect
        }
        return cell
    }
}

//extension QuizViewController: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        var windowRect = self.view.window!.frame
//        var windowWidth = windowRect.size.width
//        var windowHeight = windowRect.size.height
//        return CGSize(width: windowWidth + 40, height: windowHeight - 50)
//    }
//}


