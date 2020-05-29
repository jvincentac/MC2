//
//  TrueFalseViewController.swift
//  MC2
//
//  Created by Vincent Alexander Christian on 12/05/20.
//  Copyright © 2020 Vincent Alexander Christian. All rights reserved.
//

import UIKit

class TrueFalseViewController: UIViewController {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var avatarImg: UIImageView!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var falseBtn: UIButton!
    @IBOutlet weak var trueBtn: UIButton!
    
    let allTrueFalse = UserDefaults.standard.dictionary(forKey: "trueFalse") as! [String : [String]]
    var trueFalse : [String] = []
    
    var success = UserDefaults.standard.object(forKey: "success") as! Int
    var story = 0
    var stage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurePage()
        configureImg(stage: stage)
        configureQuestion(story: story, stage: stage)
    }
    
    func configurePage() {
        contentView.layer.cornerRadius = 15
    }
    
    func configureImg(stage: Int) {
        if stage == 1 {
            avatarImg.image = UIImage(named: "23-6")
        }
        else if stage == 2 {
            avatarImg.image = UIImage(named: "23-4")
        }
        else if stage ==  3 {
            avatarImg.image = UIImage(named: "23-5")
        }
        else if stage == 4 {
            avatarImg.image = UIImage(named: "23-3")
        }
    }
    
    func configureQuestion(story: Int, stage: Int) {
        if story == 1 {
            trueFalse = allTrueFalse[String(stage)]!
        }
        else if story == 2 {
            trueFalse = allTrueFalse[String(stage+4)]!
        }
        else if story ==  3 {
            trueFalse = allTrueFalse[String(stage+8)]!
        }
        
        questionLabel.text = trueFalse[0]
        
        splitBoldText(target: trueFalse[2], targetLabel: questionLabel)
    }
    
    @IBAction func check(_ sender: UIButton) {
        let answer = trueFalse[1]
        var temp = ""
        
        if sender == falseBtn {
            temp = "false"
            if temp == answer {
                sender.setImage(UIImage(named: "False_True"), for: .normal)
                success += 1
            }
            else {
                sender.setImage(UIImage(named: "False_False"), for: .normal)
            }
        }
        else if sender == trueBtn {
            temp = "true"
            if temp == answer {
                sender.setImage(UIImage(named: "True_True"), for: .normal)
                success += 1
            }
            else {
                sender.setImage(UIImage(named: "True_False"), for: .normal)
            }
        }
        trueBtn.isUserInteractionEnabled = false
        falseBtn.isUserInteractionEnabled = false
        
        UserDefaults.standard.set(success, forKey: "success")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let sb = UIStoryboard(name: "Completion", bundle: nil).instantiateViewController(withIdentifier: "completion") as! completionViewController
            sb.modalPresentationStyle = .fullScreen
            sb.story = self.story
            sb.stage = self.stage
            self.present(sb, animated: true, completion: nil)
        }
    }
}
