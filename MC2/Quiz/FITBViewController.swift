//
//  FiITBViewController.swift
//  MC2
//
//  Created by Vincent Alexander Christian on 14/05/20.
//  Copyright © 2020 Vincent Alexander Christian. All rights reserved.
//

import UIKit

class FITBViewController: UIViewController {

    @IBOutlet weak var answer1: UIButton!
    @IBOutlet weak var answer2: UIButton!
    @IBOutlet weak var answer3: UIButton!
    @IBOutlet weak var answer4: UIButton!
    @IBOutlet weak var avatarImg: UIImageView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var question1: UILabel!
    @IBOutlet weak var question2: UILabel!
    @IBOutlet weak var question3: UILabel!
    @IBOutlet weak var question4: UILabel!
    @IBOutlet weak var continueBtn: UIButton!
    @IBOutlet weak var checkChatBubble: UIImageView!
    @IBOutlet weak var checkBtn: UIButton!
    
    var story = 0
    var stage = 0
    var allButton : [UIButton] = []
    
    let allQuestion = UserDefaults.standard.dictionary(forKey: "FITB") as! [String : [String]]
    var question : [String] = []
    let allAnswer = UserDefaults.standard.dictionary(forKey: "FITBAnswer") as! [String : [String]]
    var answer : [String] = []
    var tempAnswer : [String] = []
    var targetIsQ1 = "______"
    var targetIsQ2 = "______"
    var targetIsQ3 = "______"
    var targetIsQ4 = "______"
    var selectedButton = UIButton()
    var selectedLabel = UILabel()
    
    var success = UserDefaults.standard.object(forKey: "success") as! Int
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurePage()
        configureImg(stage: stage)
        configureBtn(story: story, stage: stage)
        configureQuestion(story: story, stage: stage)
    }
    
    func configureImg(stage: Int) {
        if stage == 1 {
            avatarImg.image = UIImage(named: "23-1")
        }
        else if stage == 2 {
            avatarImg.image = UIImage(named: "23-5")
        }
        else if stage == 3 {
            avatarImg.image = UIImage(named: "23-3")
        }
        else if stage == 4 {
            avatarImg.image = UIImage(named: "23-2")
        }
    }
    
    func configurePage() {
        allButton.append(answer1)
        allButton.append(answer2)
        allButton.append(answer3)
        allButton.append(answer4)
        
        for answer in allButton {
            answer.layer.cornerRadius = 8
            answer.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(self.moveBtn)))
        }

        contentView.layer.cornerRadius = 15
        continueBtn.isHidden = true
        continueBtn.isEnabled = false
        
        checkChatBubble.isHidden = true
        checkBtn.isHidden = true
        checkBtn.isEnabled = false
    }
    
    func configureBtn(story: Int, stage: Int) {
        if story == 1 {
            answer = allAnswer[String(stage)]!
        }
        else if story == 2 {
            answer = allAnswer[String(stage+4)]!
        }
        else if story == 3 {
            answer = allAnswer[String(stage+8)]!
        }
        
        tempAnswer.append(answer[0])
        tempAnswer.append(answer[1])
        tempAnswer.append(answer[2])
        tempAnswer.append(answer[3])
        
        var limit = 3
        for button in allButton {
            let randNumber = Int.random(in: 0...limit)
            button.setTitle(tempAnswer[randNumber], for: .normal)
            tempAnswer.remove(at: randNumber)
            limit -= 1
        }
    }
    
    func configureQuestion(story: Int, stage: Int) {
        if story == 1 {
            question = allQuestion[String(stage)]!
        }
        else if story == 2 {
            question = allQuestion[String(stage+4)]!
        }
        else if story == 3 {
            question = allQuestion[String(stage+8)]!
        }
        
        question1.text = question[0]
        question2.text = question[1]
        question3.text = question[2]
        question4.text = question[3]
    }
    
    @objc func moveBtn(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: self.view)
        if gesture.state == .changed {
            selectedButton.transform = CGAffineTransform(translationX: translation.x, y: translation.y)
            selectedQuestionBorder(point: selectedButton.frame.origin.y)
        }
        else if gesture.state == .ended {
            selectedQuestion(point: selectedButton.frame.origin.y)
            
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
                self.selectedButton.transform = .identity
            })
            
            question1.layer.borderWidth = 0
            question2.layer.borderWidth = 0
            question3.layer.borderWidth = 0
            question4.layer.borderWidth = 0
        }
    }
    func selectedQuestion(point: CGFloat) {
        if point >= question1.frame.origin.y && point <= question1.frame.origin.y + question1.frame.height{
            selectedLabel = question1
            replace(target: targetIsQ1)
            targetIsQ1 = selectedButton.title(for: .normal)!
        }
        else if point >= question2.frame.origin.y && point <= question2.frame.origin.y + question2.frame.height{
            selectedLabel = question2
            replace(target: targetIsQ2)
            targetIsQ2 = selectedButton.title(for: .normal)!
        }
        else if point >= question3.frame.origin.y && point <= question3.frame.origin.y + question3.frame.height{
            selectedLabel = question3
            replace(target: targetIsQ3)
            targetIsQ3 = selectedButton.title(for: .normal)!
        }
        else if point >= question4.frame.origin.y && point <= question4.frame.origin.y + question4.frame.height{
            selectedLabel = question4
            replace(target: targetIsQ4)
            targetIsQ4 = selectedButton.title(for: .normal)!
        }
        
        if targetIsQ1 != "______" && targetIsQ2 != "______" && targetIsQ3 != "______" && targetIsQ4 != "______" {
            checkChatBubble.isHidden = false
            checkBtn.isHidden = false
            checkBtn.isEnabled = true
        }
    }
    
    func selectedQuestionBorder(point: CGFloat) {
        if point >= question1.frame.origin.y && point <= question1.frame.origin.y + question1.frame.height{
            question1.layer.borderWidth = 1
            question2.layer.borderWidth = 0
            question3.layer.borderWidth = 0
            question4.layer.borderWidth = 0
        }
        else if point >= question2.frame.origin.y && point <= question2.frame.origin.y + question2.frame.height{
            question1.layer.borderWidth = 0
            question2.layer.borderWidth = 1
            question3.layer.borderWidth = 0
            question4.layer.borderWidth = 0
        }
        else if point >= question3.frame.origin.y && point <= question3.frame.origin.y + question3.frame.height{
            question1.layer.borderWidth = 0
            question2.layer.borderWidth = 0
            question3.layer.borderWidth = 1
            question4.layer.borderWidth = 0
        }
        else if point >= question4.frame.origin.y && point <= question4.frame.origin.y + question4.frame.height{
            question1.layer.borderWidth = 0
            question2.layer.borderWidth = 0
            question3.layer.borderWidth = 0
            question4.layer.borderWidth = 1
        }
        else {
            question1.layer.borderWidth = 0
            question2.layer.borderWidth = 0
            question3.layer.borderWidth = 0
            question4.layer.borderWidth = 0
        }
    }

    func replace(target: String) {
        let str = selectedLabel.text
        let new = str?.replace(target: target, withString: selectedButton.title(for: .normal)!)
        selectedLabel.text = new
    }
    
    func replaceCheck(target: String, label: UILabel, answer: String) {
        let str = label.text
        let new = str?.replace(target: target, withString: answer)
        label.text = new
    }
    
    @IBAction func click(_ sender: UIButton) {
        selectedButton = sender
    }
    
    @IBAction func checkAnswer(_ sender: UIButton) {
        check()
        continueBtn.isHidden = false
        continueBtn.isEnabled = true
        
        for button in allButton {
            button.isUserInteractionEnabled = false
        }
    }
    
    func changeColor(question: UILabel, target: String, color: UIColor) {
        let mainString = question.text
        let stringToColor = target
        let range = (mainString! as NSString).range(of: stringToColor)
        
        let attribute = NSMutableAttributedString.init(string: mainString!)
        attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: color , range: range)
        
        
        question.attributedText = attribute
    }
    
    func check() {
        if targetIsQ1 == answer[0] {
            changeColor(question: question1, target: targetIsQ1, color: .green)
            count += 1
        }
        else {
            changeColor(question: question1, target: targetIsQ1, color: .red)
            count -= 1
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.replaceCheck(target: self.targetIsQ1, label: self.question1, answer: self.answer[0])
                self.targetIsQ1 = self.answer[0]
                self.changeColor(question: self.question1, target: self.targetIsQ1, color: .green)
            }
        }
        
        if targetIsQ2 == answer[1] {
            changeColor(question: question2, target: targetIsQ2, color: .green)
            count += 1
        }
        else {
            changeColor(question: question2, target: targetIsQ2, color: .red)
            count -= 1
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.replaceCheck(target: self.targetIsQ2, label: self.question2, answer: self.answer[1])
                self.targetIsQ2 = self.answer[1]
                self.changeColor(question: self.question2, target: self.targetIsQ2, color: .green)
            }
        }
        
        if targetIsQ3 == answer[2] {
            changeColor(question: question3, target: targetIsQ3, color: .green)
            count += 1
        }
        else {
            changeColor(question: question3, target: targetIsQ3, color: .red)
            count -= 1
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.replaceCheck(target: self.targetIsQ3, label: self.question3, answer: self.answer[2])
                self.targetIsQ3 = self.answer[2]
                self.changeColor(question: self.question3, target: self.targetIsQ3, color: .green)
            }
        }
        
        if targetIsQ4 == answer[3] {
            changeColor(question: question4, target: targetIsQ4, color: .green)
            count += 1
        }
        else {
            changeColor(question: question4, target: targetIsQ4, color: .red)
            count -= 1
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.replaceCheck(target: self.targetIsQ4, label: self.question4, answer: self.answer[3])
                self.targetIsQ4 = self.answer[3]
                self.changeColor(question: self.question4, target: self.targetIsQ4, color: .green)
            }
        }
    }
    
    @IBAction func `continue`(_ sender: Any) {
        
        if count == 4 {
            success += 1
            UserDefaults.standard.set(success, forKey: "success")
        }
        
        let sb = UIStoryboard(name: "Quiz", bundle: nil).instantiateViewController(withIdentifier: "trueFalse") as! TrueFalseViewController
        sb.modalPresentationStyle = .fullScreen
        sb.story = self.story
        sb.stage = self.stage
        self.present(sb, animated: true, completion: nil)
    }
}

extension String {
    func replace(target: String, withString: String) -> String {
        return self.replacingOccurrences(of: target, with: withString, options: NSString.CompareOptions.literal, range: nil)
    }
}
