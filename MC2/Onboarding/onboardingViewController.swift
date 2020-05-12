//
//  onboardingViewController.swift
//  MC2
//
//  Created by Vincent Alexander Christian on 10/05/20.
//  Copyright © 2020 Vincent Alexander Christian. All rights reserved.
//

import UIKit

class onboardingViewController: UIViewController {

    @IBOutlet weak var descView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurePage()
        configureQuestion()
    }
    
    func configurePage() {
        descView.layer.cornerRadius = 15
    }
    
    func configureQuestion() {
        let multipleChoice = [
            "1" : ["what’s the word that represent a way that is free from outside control or influence","independently","alone","introvert","single"],
            "2" : ["what’s the word that represent serving to prepare for, intervene in, or control occurrence or situation, especially a negative or difficult one; anticipatory","proactively","negative","ineffectual","incapable"]
        ]
        
        UserDefaults.standard.set(multipleChoice, forKey: "multipleChoice")
    }
    
    @IBAction func next(_ sender: Any) {
        
    }
    
    @IBAction func skip(_ sender: UIButton) {
        //code dismiss onboarding
        let sb = UIStoryboard(name: "Quiz", bundle: nil).instantiateViewController(withIdentifier: "multipleChoice") as! multipleChoiceViewController
        present(sb, animated: true, completion: nil)
    }
}
