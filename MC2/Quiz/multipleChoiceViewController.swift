//
//  multipleChoiceViewController.swift
//  MC2
//
//  Created by Vincent Alexander Christian on 12/05/20.
//  Copyright © 2020 Vincent Alexander Christian. All rights reserved.
//

import UIKit

class multipleChoiceViewController: UIViewController {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var questionTitle: UILabel!
    @IBOutlet weak var QuestionLabel: UILabel!
    @IBOutlet weak var answer1 : UIButton!
    @IBOutlet weak var answer2 : UIButton!
    @IBOutlet weak var answer3 : UIButton!
    @IBOutlet weak var answer4 : UIButton!
    
    var answerButtons : [UIButton] = []
    var answers : [String] = []
    
    var story = 1
    var stage = 2
    
    let allMultipleChoice = UserDefaults.standard.dictionary(forKey: "multipleChoice") as! [String : [String]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurePage()
    }
    
    func configurePage() {
        contentView.layer.cornerRadius = 15
        randomAnswer(story: story, stage: stage)
    }
    
    func randomAnswer(story : Int, stage : Int) {
        var multipleChoice : [String] = []
        if story == 1 {
            multipleChoice = allMultipleChoice[String(stage)]!
        }
        else if story == 2 {
            multipleChoice = allMultipleChoice[String(stage+4)]!
        }
        else if story == 3 {
            multipleChoice = allMultipleChoice[String(stage+8)]!
        }
        
        QuestionLabel.text = multipleChoice[0]
        var n = 3
        
        answerButtons.append(answer1)
        answerButtons.append(answer2)
        answerButtons.append(answer3)
        answerButtons.append(answer4)
        
        answers.append(multipleChoice[1])
        answers.append(multipleChoice[2])
        answers.append(multipleChoice[3])
        answers.append(multipleChoice[4])
        
        for answer in answerButtons {
            let randNumber = Int.random(in: 0...n)
            answer.setTitle(answers[randNumber], for: .normal)
            answers.remove(at: randNumber)
            n -= 1
        }
    }
}
