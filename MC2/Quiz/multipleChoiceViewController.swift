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
    @IBOutlet weak var QuestionLabel: UILabel!
    @IBOutlet weak var answer1 : UIButton!
    @IBOutlet weak var answer2 : UIButton!
    @IBOutlet weak var answer3 : UIButton!
    @IBOutlet weak var answer4 : UIButton!
    @IBOutlet weak var conversationAvatarA: UIImageView!
    @IBOutlet weak var conversationAvatarB: UIImageView!
    @IBOutlet weak var conversationAvatarA2: UIImageView!
    @IBOutlet weak var conversationA: UILabel!
    @IBOutlet weak var conversationB: UILabel!
    @IBOutlet weak var conversationA2: UILabel!
    
    var answerButtons : [UIButton] = []
    var answers : [String] = []
    var correctAnswer = String()
    
    var story = 1
    var stage = 1
    var success = 0
    
    let allMultipleChoice = UserDefaults.standard.dictionary(forKey: "multipleChoice") as! [String : [String]]
    let allConversation = UserDefaults.standard.dictionary(forKey: "multipleChoiceConversation") as! [String: [String]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setImg(stage: stage)
        configurePage()
        setConversation(story: story, stage: stage)
    }
    
    func configurePage() {
        contentView.layer.cornerRadius = 15
        randomAnswer(story: story, stage: stage)
    }
    
    func setImg(stage: Int) {
        if stage == 1 {
            conversationAvatarA.image = UIImage(named: "1-1")
            conversationAvatarB.image = UIImage(named: "1-2")
        }
        else if stage == 2 {
            conversationAvatarA.image = UIImage(named: "1-5")
            conversationAvatarB.image = UIImage(named: "1-3")
        }
        else if stage == 3 {
            conversationAvatarA.image = UIImage(named: "1-4")
            conversationAvatarB.image = UIImage(named: "1-3")
        }
        else if stage == 4 {
            conversationAvatarA.image = UIImage(named: "1-5")
            conversationAvatarB.image = UIImage(named: "1-4")
        }
        conversationAvatarA2.image = conversationAvatarA.image
    }
    
    func setConversation(story: Int, stage: Int) {
        var conversation : [String] = []
        if story == 1 {
            conversation = allConversation[String(stage)]!
        }
        else if story == 2 {
            conversation = allConversation[String(stage+4)]!
        }
        else if story == 3 {
            conversation = allConversation[String(stage+8)]!
        }
        
        conversationA.text = conversation[0]
        conversationB.text = conversation[1]
        conversationA2.text = conversation[2]
    }
    
    func randomAnswer(story: Int, stage: Int) {
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
        correctAnswer = multipleChoice[1]
        QuestionLabel.text = multipleChoice[0]
        
        
        answerButtons.append(answer1)
        answerButtons.append(answer2)
        answerButtons.append(answer3)
        answerButtons.append(answer4)
        
        answers.append(multipleChoice[1])
        answers.append(multipleChoice[2])
        answers.append(multipleChoice[3])
        answers.append(multipleChoice[4])
        
        var n = 3
        for answer in answerButtons {
            answer.layer.cornerRadius = 8
            let randNumber = Int.random(in: 0...n)
            answer.setTitle(answers[randNumber], for: .normal)
            answers.remove(at: randNumber)
            n -= 1
        }
    }
    
    func searchCorrectButton() {
        for answer in answerButtons {
            if answer.title(for: .normal) == correctAnswer {
                answer.backgroundColor = .green
            }
        }
    }
    
    func disableBtn() {
        for answer in answerButtons {
            answer.isEnabled = false
        }
    }
    
    @IBAction func checkAnswer(_ sender: UIButton) {
        let check = sender.title(for: .normal)
        if check == correctAnswer {
            sender.backgroundColor = .green
            success += 1
        }
        else {
            sender.backgroundColor = .red
            searchCorrectButton()
        }
        disableBtn()
        
        UserDefaults.standard.set(success, forKey: "success")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let sb = UIStoryboard(name: "Quiz", bundle: nil).instantiateViewController(withIdentifier: "FITB") as! FITBViewController
            sb.modalPresentationStyle = .fullScreen
            self.present(sb, animated: true, completion: nil)
        }
    }
}
