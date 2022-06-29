//
//  ViewController.swift
//  MAD3115Project1
//
//  Created by Shijith K  on 22/06/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var playButton: UIButton! {
        didSet {
            playButton.layer.cornerRadius = playButton.frame.height/2
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onClickPlay(_ sender: Any) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "QuizViewController") as? QuizViewController else {return}
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

