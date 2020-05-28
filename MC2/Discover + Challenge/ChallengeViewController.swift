//
//  ChallengeViewController.swift
//  MC2
//
//  Created by Vincent Alexander Christian on 23/05/20.
//  Copyright © 2020 Vincent Alexander Christian. All rights reserved.
//

import UIKit

class ChallengeViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var stage1Btn: UIButton!
    @IBOutlet weak var stage2Btn: UIButton!
    @IBOutlet weak var stage3Btn: UIButton!
    @IBOutlet weak var stage4Btn: UIButton!
    @IBOutlet weak var stage2Lock: UIImageView!
    @IBOutlet weak var stage3Lock: UIImageView!
    @IBOutlet weak var stage4Lock: UIImageView!
    
    var story = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurePage()
        configureStage()
    }
    
    func configurePage() {
        contentView.layer.cornerRadius = 10
        
        if story == 1 {
            titleLabel.text = "Conversation During Interview"
        }
        else if story == 2 {
            titleLabel.text = "Conversation at Work Place"
        }
        else if story == 3 {
            titleLabel.text = "Conversation During Presentation"
        }
        
        stage1Btn.layer.cornerRadius = 8
        stage2Btn.layer.cornerRadius = 8
        stage3Btn.layer.cornerRadius = 8
        stage4Btn.layer.cornerRadius = 8
        
        stage2Btn.isEnabled = false
        stage3Btn.isEnabled = false
        stage4Btn.isEnabled = false
    }
    
    func configureStage() {
        let starTotal = UserDefaults.standard.integer(forKey: "story\(story)")
        
        if starTotal == 3 {
            changeImg(img: stage2Lock)
            changeBtnState(btn: stage2Btn)
        }
        else if starTotal == 6 {
            changeImg(img: stage2Lock)
            changeBtnState(btn: stage2Btn)
            changeImg(img: stage3Lock)
            changeBtnState(btn: stage3Btn)
        }
        else if starTotal == 9 {
            changeImg(img: stage2Lock)
            changeBtnState(btn: stage2Btn)
            changeImg(img: stage3Lock)
            changeBtnState(btn: stage3Btn)
            changeImg(img: stage4Lock)
            changeBtnState(btn: stage4Btn)
        }
    }
    
    func changeImg(img: UIImageView) {
        img.image = UIImage(named: "unlocked")
    }

    func changeBtnState(btn: UIButton) {
        btn.isEnabled = true
    }
    
    @IBAction func toMultipleChoice(_ sender: UIButton) {
        let sb = UIStoryboard(name: "Quiz", bundle: nil).instantiateViewController(withIdentifier: "multipleChoice") as! multipleChoiceViewController
        sb.modalPresentationStyle = .fullScreen
        if sender == stage1Btn {
            sb.story = story
            sb.stage = 1
        }
        else if sender == stage2Btn {
            sb.story = story
            sb.stage = 2
        }
        else if sender == stage3Btn {
            sb.story = story
            sb.stage = 3
        }
        else if sender == stage4Btn {
            sb.story = story
            sb.stage = 4
        }
        
        self.present(sb, animated: true, completion: nil)
    }
    @IBAction func back(_ sender: Any) {
        let sb = UIStoryboard(name: "First", bundle: nil).instantiateViewController(withIdentifier: "Discover") as! DiscoverStoriesViewController
        sb.modalPresentationStyle = .fullScreen
        self.present(sb, animated: true, completion: nil)
    }
}
